class CreateCounties < ActiveRecord::Migration::Current
  def change
    create_table :counties do |t|
      t.string :slug
      t.string :name
      t.string :state_name
      t.string :state_alpha
      t.integer :fips
      t.index :slug, unique: true
      t.index :fips, unique: true
      t.timestamps

      # a cached valued of the latest NASS or Ag Census stat values and source year
      t.integer :land_area_acres
      t.integer :land_area_acres_year
      t.integer :cropland_acres
      t.integer :cropland_acres_year
      t.integer :cropland_harvested_acres
      t.integer :cropland_harvested_acres_year
      t.integer :pastureland_acres
      t.integer :pastureland_acres_year
      t.integer :woodland_acres
      t.integer :woodland_acres_year
      t.integer :other_agland_acres
      t.integer :other_agland_acres_year
      t.integer :total_farm_operations_count
      t.integer :total_farm_operations_count_year
      t.integer :corn_grain_acres
      t.integer :corn_silage_acres
      t.integer :soybeans_acres
      t.integer :oats_acres
      t.integer :forage_acres
      t.integer :beef_cows
      t.integer :milk_cows
      t.integer :other_cattle
      t.integer :hogs
      t.integer :broilers
      t.integer :layers

    end
  end
end
