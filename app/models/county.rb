# frozen_string_literal: true

# A County in the United States
class County < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :statistics, dependent: :destroy

  validates :name,
            presence: true,
            format: { with: /\A[[:upper:] ']+\z/, message: 'must be UPPERCASE' }, # also allow space and apostrophe
            uniqueness: { scope: :state_alpha,
                          message: 'has already been added',
                          case_sensitve: false }
  validates :state_alpha,
            presence: true,
            format: { with: /\A[[:upper:]]{2}\z/, message: 'must be UPPERCASE' },
            length: { is: 2 }
  validates :state_name,
            presence: true,
            format: { with: /\A[[:upper:]]+\z/, message: 'must be UPPERCASE' }

  def title
    case fips
    when 19_141
      "O'Brien County, #{state_alpha}" # special case in order that "Brien" is capitalized
    else
      "#{name.titleize} County, #{state_alpha}"
    end
  end

  def title_short
    name.titleize
  end

  def acres_hash
    {
      'corn' => corn_grain_acres || 0,
      'corn silage' => corn_silage_acres || 0,
      'forage' => forage_acres || 0,
      'oats' => oats_acres || 0,
      'soybeans' => soybeans_acres || 0
    }
  end

  def head_hash
    {
      'hogs' => hogs || 0,
      'cattle' => cattle || 0,
      'chickens' => chickens || 0
    }
  end

  def classifications_hash
    {
      'other cattle' => other_cattle || 0,
      'beef cows' => beef_cows || 0,
      'dairy cows' => milk_cows || 0,
      'layers' => layers || 0,
      'broilers' => broilers || 0,
      # while 'hogs' is not actually a Operation classifcation, it serves as one in controller where it reads "op.classification or op.name"
      'hogs' => hogs || 0
    }
  end

  def chickens
    [broilers, layers].compact.sum
  end

  def cattle
    [beef_cows, milk_cows, other_cattle].compact.sum
  end

  def latest_crop_stats
    statistics.where(id: [statistics.corn_grain.exists? ? statistics.corn_grain.first.id : nil,
                          statistics.corn_silage.exists? ? statistics.corn_silage.first.id : nil,
                          statistics.soybeans.exists? ? statistics.soybeans.first.id : nil,
                          statistics.oats.exists? ? statistics.oats.first.id : nil,
                          statistics.forage.exists? ? statistics.forage.first.id : nil]).select(:id, :short_desc, :year, :value).order(:short_desc)
  end

  def latest_livestock_stats
    statistics.where(id: [statistics.beef_cows.exists? ? statistics.beef_cows.first.id : nil,
                          statistics.milk_cows.exists? ? statistics.milk_cows.first.id : nil,
                          statistics.cattle.exists? ? statistics.other_cattle.first.id : nil,
                          statistics.cattle.exists? ? statistics.cattle.first.id : nil,
                          statistics.hogs.exists? ? statistics.hogs.first.id : nil,
                          statistics.broilers.exists? ? statistics.broilers.first.id : nil,
                          statistics.layers.exists? ? statistics.layers.first.id : nil]).select(:id, :short_desc, :reference_period_desc, :year, :value).order(:short_desc)
  end

  def agland_acres
    # sum cropland, pastureland, woodland, and other-agland acres
    agland_acres ||= [cropland_acres, pastureland_acres, woodland_acres, other_agland_acres].compact.sum
  end

  # Update cached attributes for county using latest statistics
  def update_cached_values
    update(
      land_area_acres: statistics.total_land_area.latest.first.value_float.to_i,
      land_area_acres_year: statistics.total_land_area.latest.first.year,
      cropland_acres: statistics.cropland.first.value_float.to_i,
      cropland_acres_year: statistics.cropland.first.year,
      cropland_harvested_acres: statistics.cropland_harvested.first.value_float.to_i,
      cropland_harvested_acres_year: statistics.cropland_harvested.first.year,
      pastureland_acres: statistics.pastureland.first.value_float.to_i,
      pastureland_acres_year: statistics.pastureland.first.year,
      woodland_acres: statistics.woodland.first.value_float.to_i,
      woodland_acres_year: statistics.woodland.first.year,
      other_agland_acres: statistics.other_agland.first.value_float.to_i,
      other_agland_acres_year: statistics.other_agland.first.year,
      total_farm_operations_count: statistics.total_farm_operations.first.value_float.to_i,
      total_farm_operations_count_year: statistics.total_farm_operations.first.year,
      corn_grain_acres: (statistics.corn_grain.exists? ? statistics.corn_grain.first.value_float.to_i : nil),
      corn_silage_acres: (statistics.corn_silage.exists? ? statistics.corn_silage.first.value_float.to_i : nil),
      soybeans_acres: (statistics.soybeans.exists? ? statistics.soybeans.first.value_float.to_i : nil),
      oats_acres: (statistics.oats.exists? ? statistics.oats.first.value_float.to_i : nil),
      forage_acres: (statistics.forage.exists? ? statistics.forage.first.value_float.to_i : nil),
      beef_cows: (statistics.beef_cows.exists? ? statistics.beef_cows.first.value_float.to_i : nil),
      milk_cows: (statistics.milk_cows.exists? ? statistics.milk_cows.first.value_float.to_i : nil),
      other_cattle: (statistics.other_cattle.exists? ? statistics.other_cattle.first.value_float.to_i : nil),
      hogs: (statistics.hogs.exists? ? statistics.hogs.first.value_float.to_i : nil),
      broilers: (statistics.broilers.exists? ? statistics.broilers.first.value_float.to_i : nil),
      layers: (statistics.layers.exists? ? statistics.layers.first.value_float.to_i : nil)
    )
  end

  # NASS Statistics
  # Update local statistics using remote (NASS) statistics
  def update_nass_statistics(years_of_stats = 1)
    # field crops
    Statistic.fetch_nass_statistics_for_county(self, unit_desc: 'ACRES', domain_desc: 'TOTAL', group_desc: 'FIELD CROPS', year__GE: Date.today.year - years_of_stats)

    # livestock
    Statistic.fetch_nass_statistics_for_county(self, unit_desc: 'HEAD', year__GE: Date.today.year - years_of_stats)

    # county ag land area
    Statistic.fetch_nass_statistics_for_county(self, unit_desc: 'ACRES', commodity_desc: 'AG LAND', domain_desc: 'TOTAL', group_desc: 'FARMS & LAND & ASSETS', year__GE: Date.today.year - years_of_stats)

    # county total land area
    Statistic.fetch_nass_statistics_for_county(self, unit_desc: 'ACRES', commodity_desc: 'LAND AREA', domain_desc: 'TOTAL', statisticcat_desc: 'AREA', year__GE: Date.today.year - years_of_stats)

    # county total farm operations
    Statistic.fetch_nass_statistics_for_county(self, short_desc: 'FARM OPERATIONS - NUMBER OF OPERATIONS', domain_desc: 'TOTAL', statisticcat_desc: 'OPERATIONS', year__GE: Date.today.year - years_of_stats)
  end

  def combined_mmbtus
    @crop_mmbtus_hash = Hash.new(0)
    @livestock_mmbtus_hash = Hash.new(0)

    @tillage_factor = {
      'no_tillage' => 6 / 100.0,
      'reduced_tillage' => 49 / 100.0,
      'intensive_tillage' => 45 / 100.0
    }
    @rotation_factor = {
      'following_corn' => 60 / 100.0,
      'following_soybeans' => 40 / 100.0
    }

    CropOperation.order(:name).each do |op|
      @crop_mmbtus_hash[op.name] += acres_hash[op.name].to_i * op.cached_mmbtus_per_inventory_unit * @tillage_factor[op.tillage_practice] * (op.name == 'corn' ? @rotation_factor[op.rotation_practice] : 1)
    end

    LivestockOperation.all.each do |op|
      @livestock_mmbtus_hash[op.name] += classifications_hash[(op.classification || op.name)].to_i * op.cached_mmbtus_per_inventory_unit
    end

    @combined_mmbtus = @crop_mmbtus_hash.map(&:last).reduce(:+) + @livestock_mmbtus_hash.map(&:last).reduce(:+)

  end

end
