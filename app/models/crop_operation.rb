class CropOperation < Operation
  ENERGY_UNITS_PER_ACRE = YAML.load_file('app/lib/energy_units_per_step_per_acre.yml')

  def import_steps
    EnergyUnit.all.each do |energy_unit|
      if ENERGY_UNITS_PER_ACRE[name][energy_unit.slug].nil?
        next # Energy unit is not used for the operation with this name
      elsif ENERGY_UNITS_PER_ACRE[name][energy_unit.slug].is_a? Array
        ENERGY_UNITS_PER_ACRE[name][energy_unit.slug].each do |hash|
          steps << if CropStep.where(slug: hash['step']['slug']).exists?
                     # add step to operation
                     CropStep.where(slug: hash['step']['slug'])
                   else
                     # create step and add it to operation
                     CropStep.create(
                       slug: hash['step']['slug'],
                       name: hash['step']['name'],
                       category: hash['step']['category'],
                       energy_units_used: hash['step']['energy_units_used'],
                       subcategory: hash['step']['subcategory'],
                       source_text: hash['step']['source_text'],
                       source_url: hash['step']['source_url'],
                       notes: hash['step']['notes'],
                       sort_order: hash['step']['sort_order'],
                       energy_unit: energy_unit
                     )
                   end
        end
      elsif ENERGY_UNITS_PER_ACRE[name][energy_unit.slug][tillage_practice].is_a? Array
        ENERGY_UNITS_PER_ACRE[name][energy_unit.slug][tillage_practice].each do |hash|
          steps << if CropStep.where(slug: hash['step']['slug']).exists?
                     CropStep.where(slug: hash['step']['slug'])
                   else
                     CropStep.create(
                       slug: hash['step']['slug'],
                       name: hash['step']['name'],
                       category: hash['step']['category'],
                       energy_units_used: hash['step']['energy_units_used'],
                       subcategory: hash['step']['subcategory'],
                       source_text: hash['step']['source_text'],
                       source_url: hash['step']['source_url'],
                       notes: hash['step']['notes'],
                       sort_order: hash['step']['sort_order'],
                       energy_unit: energy_unit
                     )
                   end
        end
      elsif ENERGY_UNITS_PER_ACRE[name][energy_unit.slug][tillage_practice][rotation_practice].is_a? Array
        ENERGY_UNITS_PER_ACRE[name][energy_unit.slug][tillage_practice][rotation_practice].each do |hash|
          steps << if CropStep.where(slug: hash['step']['slug']).exists?
                     CropStep.where(slug: hash['step']['slug'])
                   else
                     CropStep.create(
                       slug: hash['step']['slug'],
                       name: hash['step']['name'],
                       category: hash['step']['category'],
                       energy_units_used: hash['step']['energy_units_used'],
                       subcategory: hash['step']['subcategory'],
                       source_text: hash['step']['source_text'],
                       source_url: hash['step']['source_url'],
                       notes: hash['step']['notes'],
                       sort_order: hash['step']['sort_order'],
                       energy_unit: energy_unit
                     )
                   end
        end
      else
        puts "Unexpected result when reading energy_units_per_step_per_acre.yml. name: #{name}; energy_unit.slug: #{energy_unit.slug}; tillage_practice: #{tillage_practice}; rotation_practice: #{rotation_practice}"
      end
    end
  end

  def unit
    'acre'
  end
end
