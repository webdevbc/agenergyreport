class CreateStatistics < ActiveRecord::Migration::Current
  def change
    create_table :statistics do |t|
      t.string :value
      t.float :value_float # e.g. convert string to float?
      t.string :short_desc # e.g.  "CATTLE, COWS, MILK - INVENTORY", "CORN - ACRES PLANTED"
      t.string :year # convert to integer from NASS
      t.integer :year_int # convert to integer from NASS
      t.string :county_name # e.g.  "WINNESHIEK",
      t.references :county, foreign_key: true
      t.string :load_time # load_time into the nass database
      t.string :util_practice_desc # e.g.  "ALL UTILIZATION PRACTICES",
      t.string :prodn_practice_desc # e.g.  "ALL PRODUCTION PRACTICES",
      t.string :domain_desc # e.g.  "TOTAL",
      t.string :sector_desc # e.g.  "ANIMALS & PRODUCTS", "CROPS"
      t.string :reference_period_desc # e.g.  "FIRST OF JAN",
      t.string :class_desc # e.g.  "COWS, MILK",
      t.string :agg_level_desc # e.g.  "COUNTY",
      t.string :state_name # e.g.  "IOWA",
      t.string :location_desc # e.g.  "IOWA, NORTHEAST, WINNESHIEK",
      t.string :state_alpha # e.g.  "IA",
      t.string :asd_desc # e.g.  "NORTHEAST",
      t.string :freq_desc # e.g.  "POINT IN TIME",
      t.string :group_desc # e.g.  "LIVESTOCK", "FIELD CROPS"
      t.string :unit_desc # e.g.  "HEAD",
      t.string :source_desc # e.g.  "SURVEY",
      t.string :load_time # e.g.  "2016-05-09 15:00:01",
      t.string :statisticcat_desc # e.g.  "INVENTORY", "AREA PLANTED"
      t.string :commodity_desc # e.g.  "CATTLE", "CORN"
      t.string :domaincat_desc
      t.timestamps
    end
  end
end

# UNUSED NASS STATISTICS
# "week_ending":"",
#   "state_ansi":"19",
#   "county_ansi":"191",
#   "state_fips_code":"19",
#   "country_code":"9000",
#   "begin_code":"01",
#   "zip_5":"",
#   "end_code":"01",
#   "country_name":"UNITED STATES",
#   "CV (%)":"",
#   "asd_code":"30",
#   "region_desc":"",
#   "watershed_desc":"",
#   "congr_district_code":"",
#   "watershed_code":"00000000",
#   "county_code":"191",
