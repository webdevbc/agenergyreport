class CreateSteps < ActiveRecord::Migration::Current
  def change
    create_table :steps do |t|
      t.string :type
      t.string :slug
      t.string :name
      t.decimal :energy_units_used
      t.string :category
      t.string :subcategory
      t.string :source_text
      t.string :source_url
      t.string :notes
      t.integer :sort_order
      t.references :energy_unit, foreign_key: true
      t.index :slug, unique: true
      t.timestamps
    end
  end
end
