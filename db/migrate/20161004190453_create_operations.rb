class CreateOperations < ActiveRecord::Migration::Current
  def change
    create_table :operations do |t|
      t.string :name
      t.string :rotation_practice
      t.string :tillage_practice
      t.string :description
      t.string :classification
      t.string :type
      t.decimal :cached_energy_dollars_per_inventory_unit
      t.decimal :cached_co2e_emissions_per_inventory_unit
      t.decimal :cached_mmbtus_per_inventory_unit
      t.decimal :cached_field_dollars_per_inventory_unit
      t.decimal :cached_drying_dollars_per_inventory_unit
      t.decimal :cached_fertilizer_dollars_per_inventory_unit
      t.decimal :cached_kwh_per_inventory_unit

      t.timestamps
    end
  end
end
