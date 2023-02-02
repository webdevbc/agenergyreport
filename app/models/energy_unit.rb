# frozen_string_literal: true

class EnergyUnit < ApplicationRecord
  has_many :steps
  scope :fertilizer, -> { where(source_cost: 'ams') }
  scope :fuel, -> { where(source_cost: 'eia') }

  def fertilizer?
    source_cost == 'ams'
  end

  def self.get_latest_costs
    get_latest_eia_data
    get_latest_fertilizer_data
  end

  private

  # Grab price data on electricity and fuels from the Energy Information Administration API

  def self.get_latest_eia_data
    EnergyUnit.where(source_cost: 'eia').each do |e|
      results = EiaAPI.new.results(query: { series_id: e.eia_series_id_code, num: 1 })

      e.update(
        eia_cost_units: results.parsed_response['series'].first['units'],
        eia_cost_units_short: results.parsed_response['series'].first['unitsshort'],
        eia_cost_description: results.parsed_response['series'].first['name'],
        eia_updated: DateTime.parse(results.parsed_response['series'].first['updated']),
        eia_latest_data_period: results.parsed_response['series'].first['data'].first.first,
        eia_latest_data_value: results.parsed_response['series'].first['data'].first.second,
        dollars_per_unit: results.parsed_response['series'].first['data'].first.second
      )

      if e.eia_cost_units.downcase.include?('dollars')
        e.update(
          dollars_per_unit: e.eia_latest_data_value
        )
      elsif e.eia_cost_units.downcase.include?('cents')
        e.update(
          dollars_per_unit: e.eia_latest_data_value / 100.0
        )
      else
        puts "#{e.eia_cost_units} is an unknown monetary unit. Cannot establish 'dollars_per_unit'"
      end
    end
  end

  # Read USDA Market News Service text file (nw_gr210.txt) line by line to get $/ton of ammonia, phosphate, and potash and convert to $/lb
  # TODO read nw_gr910.txt, which is in an easier format to read.
  # TODO Access to either file is denied from Heroku servers (403 Forbidden)
  # try this one instead: https://usda.mannlib.cornell.edu/usda/ams/NW_GR210.txt
  # or convert to: https://usda.mannlib.cornell.edu/usda/ams/NW_GR910.txt
  def self.get_latest_fertilizer_data
    f = URI.open('https://www.ams.usda.gov/mnreports/nw_gr210.txt')
    # f = open("#{Rails.root.to_s}/public/fallback_data/nw_gr210.txt")
    # f = open('https://usda.mannlib.cornell.edu/usda/ams/NW_GR210.txt')



    publication_date = DateTime.new

    f.each do |line|
      publication_date = DateTime.parse(line[17..38].strip) if line.start_with?('Des Moines') # FIXME the date should be located in the second line (not, "the line that starts with 'Des Moines'")

      if line.start_with?('Anhydrous')
        cost = line[55..66].strip.to_f
        if cost > 0 # 'NA'.to_f returns 0.0
          EnergyUnit.find_or_initialize_by(slug: 'fertilizer_n', source_cost: 'ams').update(
            eia_cost_description: 'Nitrogen (N) in the form of Anhydrous Ammonia Fertilizer',
            dollars_per_unit: cost / 0.82 / 2000, # Ammonia is 82% N; 1 ton == 2000 lbs
            eia_updated: publication_date,
            eia_latest_data_period: 'Every two weeks'
          )
        end
      end

      if line.start_with?('MAP')
        cost = line[55..66].strip.to_f
        if cost > 0 # 'NA'.to_f returns 0.0
          EnergyUnit.find_or_initialize_by(slug: 'fertilizer_p', source_cost: 'ams').update(
            eia_cost_description: 'MAP (Monoammonium Phosphate 11%N 52%P) Fertilizer',
            dollars_per_unit: cost / 2000, # 1 ton == 2000 lbs
            eia_updated: publication_date,
            eia_latest_data_period: 'Every two weeks'
          )
        end
      end

      next unless line.start_with?('Potash (Red)')
      cost = line[55..66].strip.to_f
      if cost > 0 # 'NA'.to_f would return 0.0
        EnergyUnit.find_or_initialize_by(slug: 'fertilizer_k', source_cost: 'ams').update(
          eia_cost_description: 'Potash (Red) (0-0-60) Fertilizer',
          dollars_per_unit: cost / 2000, # 1 ton == 2000 lbs
          eia_updated: publication_date,
          eia_latest_data_period: 'Every two weeks'
        )
      elsif EnergyUnit.find_by(slug: 'fertilizer_k').dollars_per_unit.nil?
        # Set a default value since data is 'NA' and no previous value exists in database
        EnergyUnit.find_or_initialize_by(slug: 'fertilizer_k', source_cost: 'ams').update(
          eia_cost_description: 'Potash (Red) (0-0-60) Fertilizer',
          dollars_per_unit: 357.2 / 2000, # 1 ton == 2000 lbs
          eia_updated: DateTime.parse('March 28, 2018'),
          eia_latest_data_period: 'Every two weeks'
        )
      end
    end
  end
end
