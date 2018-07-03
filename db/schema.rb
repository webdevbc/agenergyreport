# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2016_10_12_190453) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "counties", force: :cascade do |t|
    t.string "slug"
    t.string "name"
    t.string "state_name"
    t.string "state_alpha"
    t.integer "fips"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "land_area_acres"
    t.integer "land_area_acres_year"
    t.integer "cropland_acres"
    t.integer "cropland_acres_year"
    t.integer "cropland_harvested_acres"
    t.integer "cropland_harvested_acres_year"
    t.integer "pastureland_acres"
    t.integer "pastureland_acres_year"
    t.integer "woodland_acres"
    t.integer "woodland_acres_year"
    t.integer "other_agland_acres"
    t.integer "other_agland_acres_year"
    t.integer "total_farm_operations_count"
    t.integer "total_farm_operations_count_year"
    t.integer "corn_grain_acres"
    t.integer "corn_silage_acres"
    t.integer "soybeans_acres"
    t.integer "oats_acres"
    t.integer "forage_acres"
    t.integer "beef_cows"
    t.integer "milk_cows"
    t.integer "other_cattle"
    t.integer "hogs"
    t.integer "broilers"
    t.integer "layers"
    t.index ["fips"], name: "index_counties_on_fips", unique: true
    t.index ["slug"], name: "index_counties_on_slug", unique: true
  end

  create_table "energy_units", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.string "eia_series_id_code"
    t.string "eia_cost_units"
    t.string "eia_cost_units_short"
    t.string "eia_cost_description"
    t.datetime "eia_updated"
    t.string "eia_latest_data_period"
    t.decimal "eia_latest_data_value", precision: 10, scale: 4
    t.decimal "dollars_per_unit", precision: 10, scale: 6
    t.string "unit"
    t.string "unit_short"
    t.integer "btu_per_unit"
    t.decimal "kg_of_co2_emissions_per_unit", precision: 10, scale: 5
    t.decimal "kg_of_n2o_emissions_per_unit", precision: 14, scale: 10
    t.decimal "kg_of_ch4_emissions_per_unit", precision: 14, scale: 10
    t.decimal "kg_of_co2e_emissions_per_unit", precision: 15, scale: 10
    t.string "source_url_btu_per_unit"
    t.string "source_text_btu_per_unit"
    t.string "source_url_kg_of_co2_emissions_per_unit"
    t.string "source_text_kg_of_co2_emissions_per_unit"
    t.string "source_url_kg_of_n2o_emissions_per_unit"
    t.string "source_text_kg_of_n2o_emissions_per_unit"
    t.string "source_url_kg_of_ch4_emissions_per_unit"
    t.string "source_text_kg_of_ch4_emissions_per_unit"
    t.string "source_url_kg_of_co2e_emissions_per_unit"
    t.string "source_text_kg_of_co2e_emissions_per_unit"
    t.string "source_cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_energy_units_on_slug", unique: true
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "operations", force: :cascade do |t|
    t.string "name"
    t.string "rotation_practice"
    t.string "tillage_practice"
    t.string "description"
    t.string "classification"
    t.string "type"
    t.decimal "cached_energy_dollars_per_inventory_unit"
    t.decimal "cached_co2e_emissions_per_inventory_unit"
    t.decimal "cached_mmbtus_per_inventory_unit"
    t.decimal "cached_field_dollars_per_inventory_unit"
    t.decimal "cached_drying_dollars_per_inventory_unit"
    t.decimal "cached_fertilizer_dollars_per_inventory_unit"
    t.decimal "cached_kwh_per_inventory_unit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "operations_steps", id: false, force: :cascade do |t|
    t.bigint "operation_id", null: false
    t.bigint "step_id", null: false
    t.index ["operation_id"], name: "index_operations_steps_on_operation_id"
    t.index ["step_id"], name: "index_operations_steps_on_step_id"
  end

  create_table "statistics", force: :cascade do |t|
    t.string "value"
    t.float "value_float"
    t.string "short_desc"
    t.string "year"
    t.integer "year_int"
    t.string "county_name"
    t.bigint "county_id"
    t.string "load_time"
    t.string "util_practice_desc"
    t.string "prodn_practice_desc"
    t.string "domain_desc"
    t.string "sector_desc"
    t.string "reference_period_desc"
    t.string "class_desc"
    t.string "agg_level_desc"
    t.string "state_name"
    t.string "location_desc"
    t.string "state_alpha"
    t.string "asd_desc"
    t.string "freq_desc"
    t.string "group_desc"
    t.string "unit_desc"
    t.string "source_desc"
    t.string "statisticcat_desc"
    t.string "commodity_desc"
    t.string "domaincat_desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["county_id"], name: "index_statistics_on_county_id"
  end

  create_table "steps", force: :cascade do |t|
    t.string "type"
    t.string "slug"
    t.string "name"
    t.decimal "energy_units_used"
    t.string "category"
    t.string "subcategory"
    t.string "source_text"
    t.string "source_url"
    t.string "notes"
    t.integer "sort_order"
    t.bigint "energy_unit_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["energy_unit_id"], name: "index_steps_on_energy_unit_id"
    t.index ["slug"], name: "index_steps_on_slug", unique: true
  end

  add_foreign_key "statistics", "counties"
  add_foreign_key "steps", "energy_units"
end
