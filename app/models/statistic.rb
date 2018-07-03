# Statisics (an instance of a NASS database statistic with some additional fields)
class Statistic < ApplicationRecord
  belongs_to :county

  scope :latest, -> { order(year_int: :desc) }

# NASS FIELDS
  scope :survey, -> { where(source_desc: 'SURVEY') }
  scope :census, -> { where(source_desc: 'CENSUS') }

  scope :total, -> { where(domain_desc: 'TOTAL') }

# CROP_INVENTORIES
  scope :acres, -> { where(unit_desc: 'ACRES') }
  scope :all_production_practices, -> { where(prodn_practice_desc: 'ALL PRODUCTION PRACTICES') }
  scope :harvested, -> { where(statisticcat_desc: 'AREA HARVESTED') }

# CROPS
  scope :field_crops, -> { where(group_desc: 'FIELD CROPS') }

  scope :corn_commodity, -> { where(commodity_desc: 'CORN') }
  scope :soybeans_commodity, -> { where(commodity_desc: 'SOYBEANS') }
  scope :oats_commodity, -> { where(commodity_desc: 'OATS') }
  scope :forage_commodity, -> { where(commodity_desc: 'HAY & HAYLAGE') }
  scope :hay_commodity, -> { where(commodity_desc: 'HAY') }
  scope :haylage_commodity, -> { where(commodity_desc: 'HAYLAGE') }


  scope :grain, -> { where(util_practice_desc: 'GRAIN') }
  scope :silage, -> { where(util_practice_desc: 'SILAGE') }


# LIVESTOCK_INVENTORIES

  scope :head, -> { where(unit_desc: 'HEAD') }
  scope :inventory, -> { where(statisticcat_desc: 'INVENTORY') } #as opposed to SALES
  scope :animals_and_products, -> { where(sector_desc: 'ANIMALS & PRODUCTS') } #as opposed to DEMOGRAPHICS
  scope :all_classes, -> { where(class_desc: 'ALL CLASSES') } #as opposed to BREEDING
  # also use :total above

# LIVESTOCK

  scope :cattle_commodity, -> { where(commodity_desc: 'CATTLE') }
    scope :beef_cows_class, -> { where(class_desc: 'COWS, BEEF') }
    scope :milk_cows_class, -> { where(class_desc: 'COWS, MILK') }
    scope :including_calves_class, -> { where(class_desc: 'INCL CALVES') }
    scope :excluding_cows_class, -> { where(class_desc: '(EXCL COWS)') }
  scope :goats_commodity, -> { where(class_desc: 'GOATS') }
  scope :hogs_commodity, -> { where(commodity_desc: 'HOGS') }

  scope :equine_commodity, -> { where(commodity_desc: 'EQUINE') }
  scope :horses_and_ponies_class, -> { where(class_desc: 'HORSES & PONIES') }
  scope :mules_burros_donkeys_class, -> { where(class_desc: 'MULES & BURROS & DONKEYS') }
  scope :sheep_class, -> { where(commodity_desc: 'SHEEP') }
    scope :ewes_class, -> { where(class_desc: 'EWES, BREEDING, GE 1 YEAR') }
    scope :including_lambs_class, -> { where(class_desc: 'INCL LAMBS') }
  scope :layers_class, -> { where(class_desc: 'LAYERS') }
  scope :broilers_class, -> { where(class_desc: 'BROILERS') }


# LAND AREA & USE
  scope :total_land_area, -> { where(commodity_desc: 'LAND AREA', statisticcat_desc: 'AREA', unit_desc: 'ACRES', domain_desc: 'TOTAL') }

  # specification of unit_desc and domain_desc may be redundant if query is County.first.statistics.total.cropland.acres
  # this is equivalent to County.first.statistics.cropland

  scope :cropland, -> { where(class_desc: 'CROPLAND', statisticcat_desc: 'AREA', unit_desc: 'ACRES', domain_desc: 'TOTAL') }
  scope :cropland_harvested, -> { where(class_desc: 'CROPLAND, HARVESTED', statisticcat_desc: 'AREA', unit_desc: 'ACRES', domain_desc: 'TOTAL') }
  scope :woodland, -> { where(class_desc: 'WOODLAND', statisticcat_desc: 'AREA', unit_desc: 'ACRES', domain_desc: 'TOTAL') }
  scope :pastureland, -> { where(class_desc: 'PASTURELAND', statisticcat_desc: 'AREA', unit_desc: 'ACRES', domain_desc: 'TOTAL') }
  scope :other_agland, -> { where(class_desc: '(EXCL CROPLAND & PASTURELAND & WOODLAND)', statisticcat_desc: 'AREA', unit_desc: 'ACRES', domain_desc: 'TOTAL') }
  # SUM these for total "ag land"

# TOTAL NUMBER OF FARM OPERATIONS
  scope :total_farm_operations, -> { where(domain_desc: 'TOTAL', statisticcat_desc: 'OPERATIONS', short_desc: 'FARM OPERATIONS - NUMBER OF OPERATIONS') }

# MISC
  scope :no_value, -> { where(value_float: 0 )}
  scope :with_value, -> { where.not(value_float: 0 )}


  #CHAINED SCOPES

  scope :corn_grain, -> { total.acres.corn_commodity.grain.harvested.all_production_practices.with_value.latest }
  scope :corn_silage, -> { total.acres.corn_commodity.silage.harvested.all_production_practices.with_value.latest }
  scope :soybeans, -> { total.acres.soybeans_commodity.harvested.all_production_practices.with_value.latest }
  scope :oats, -> { total.acres.oats_commodity.harvested.all_production_practices.with_value.latest }
  scope :forage, -> { total.acres.forage_commodity.harvested.all_production_practices.with_value.latest }


  scope :cattle, -> { total.head.cattle_commodity.with_value.latest }
  scope :beef_cows, -> { total.head.beef_cows_class.with_value.latest }
  scope :milk_cows, -> { total.head.milk_cows_class.with_value.latest }
  scope :other_cattle, -> { total.head.cattle_commodity.excluding_cows_class.with_value.latest }
  scope :broilers, -> { total.inventory.head.broilers_class.with_value.latest }
  scope :layers, -> { total.inventory.head.layers_class.with_value.latest }
  scope :hogs, -> { total.inventory.head.hogs_commodity.all_classes.with_value.latest }


  def suppressed?
    value.include? "(D)"
  end


  def self.fetch_all_nass_statistics_for_existing_counties
    County.find_each do |c|
      fetch_nass_statistics_for_county(c, {year__GE: 2012} )
    end
  end



  def self.fetch_nass_statistics_for_county(county, nass_query_options = {})
    # FIXME Your request will return a maximum of 50,000 data records. You can determine the returned record account before you execute the Quick Stats API call using the GET /api/get_counts function. If your request will return more than the maximum limit of 50,000 data records, you can do either of the following:


    q = { county_name: county.name.gsub("'", ' '), state_alpha: county.state_alpha } #apostrophes are converted to spaces Example: O'Brien (local) -> O Brien (NASS)

    q.merge!(nass_query_options)
      begin
        response = NassAPI.new.results({ query: q })
        if response.success?
          response.parsed_response['data'].each do |stat|
            Statistic.create_with(
              load_time: stat['load_time'], # load_time into the nass database
            ).find_or_create_by(
              short_desc: stat['short_desc'],
              value: stat['Value'],
              value_float: stat['Value'].delete(',').to_f, # convert NASS string without commas to float
              county_name: stat['county_name'],
              year: stat['year'], # convert to integer from NASS
              year_int: stat['year'].to_i ,#convert NASS string to integer
              county: county,
              util_practice_desc: stat['util_practice_desc'], # e.g.  'ALL UTILIZATION PRACTICES',
              prodn_practice_desc: stat['prodn_practice_desc'], # e.g.  'ALL PRODUCTION PRACTICES',
              domain_desc: stat['domain_desc'], # e.g.  'TOTAL',
              sector_desc: stat['sector_desc'], # e.g.  'ANIMALS & PRODUCTS', 'CROPS'
              reference_period_desc: stat['reference_period_desc'], # e.g.  'FIRST OF JAN',
              class_desc: stat['class_desc'], # e.g.  'COWS, MILK',
              agg_level_desc: stat['agg_level_desc'], # e.g.  'COUNTY',
              state_name: stat['state_name'], # e.g.  'IOWA',
              location_desc: stat['location_desc'], # e.g.  'IOWA, NORTHEAST, WINNESHIEK',
              state_alpha: stat['state_alpha'], # e.g.  'IA',
              asd_desc: stat['asd_desc'], # e.g.  'NORTHEAST',
              freq_desc: stat['freq_desc'], # e.g.  'POINT IN TIME',
              group_desc: stat['group_desc'], # e.g.  'LIVESTOCK', 'FIELD CROPS'
              unit_desc: stat['unit_desc'], # e.g.  'HEAD',
              source_desc: stat['source_desc'], # e.g.  'SURVEY',
              statisticcat_desc: stat['statisticcat_desc'], # e.g.  'INVENTORY', 'AREA PLANTED'
              commodity_desc: stat['commodity_desc'], # e.g.  'CATTLE', 'CORN'
              domaincat_desc: stat['domaincat_desc'],
            ) #unless stat['value'].delete(',').to_f == 0 # do not create suppressed statistics
          end
        else
          logger.debug "Something went wrong accessing NASS data for county: #{county.inspect} and the query: #{response}"
          return false
        end
      rescue HTTParty::Error
        # don´t do anything / whatever
        logger.debug "Something went wrong accessing NASS. The query response was as follows: #{(response)}"
      # rescue StandardError
        # rescue instances of StandardError,
        # i.e. Timeout::Error, SocketError etc
      end
  end
end
