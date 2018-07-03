class CreateEnergyUnits < ActiveRecord::Migration::Current
  def change
    create_table :energy_units do |t|
      t.string :name
      t.string :slug
      t.string :eia_series_id_code
      t.string :eia_cost_units
      t.string :eia_cost_units_short
      t.string :eia_cost_description
      t.datetime :eia_updated
      t.string :eia_latest_data_period
      t.decimal :eia_latest_data_value, precision: 10, scale: 4
      t.decimal :dollars_per_unit, precision: 10, scale: 6
      t.string :unit
      t.string :unit_short
      t.integer :btu_per_unit
      t.decimal :kg_of_co2_emissions_per_unit, precision: 10, scale: 5
      t.decimal :kg_of_n2o_emissions_per_unit, precision: 14, scale: 10
      t.decimal :kg_of_ch4_emissions_per_unit, precision: 14, scale: 10
      t.decimal :kg_of_co2e_emissions_per_unit, precision: 15, scale: 10
      t.string :source_url_btu_per_unit
      t.string :source_text_btu_per_unit
      t.string :source_url_kg_of_co2_emissions_per_unit
      t.string :source_text_kg_of_co2_emissions_per_unit
      t.string :source_url_kg_of_n2o_emissions_per_unit
      t.string :source_text_kg_of_n2o_emissions_per_unit
      t.string :source_url_kg_of_ch4_emissions_per_unit
      t.string :source_text_kg_of_ch4_emissions_per_unit
      t.string :source_url_kg_of_co2e_emissions_per_unit
      t.string :source_text_kg_of_co2e_emissions_per_unit
      t.string :source_cost
      t.timestamps
      t.index :slug, unique: true
    end
  end
end
