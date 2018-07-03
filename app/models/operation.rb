class Operation < ApplicationRecord
  has_and_belongs_to_many :energy_units
  has_and_belongs_to_many :steps, -> { includes :energy_unit }
  has_and_belongs_to_many :livestock_steps
  has_and_belongs_to_many :crop_steps

  accepts_nested_attributes_for :steps, :livestock_steps, :crop_steps

  # Crop Operations
  scope :no_tillage, -> { where(tillage_practice: 'no_tillage') }
  scope :reduced_tillage, -> { where(tillage_practice: 'reduced_tillage') }
  scope :intensive_tillage, -> { where(tillage_practice: 'intensive_tillage') }

  scope :following_corn, -> { where(rotation_practice: 'following_corn') }
  scope :following_soybeans, -> { where(rotation_practice: 'following_soybeans') }

  scope :corn_grain, -> { where(name: 'corn') }
  scope :corn_silage, -> { where(name: 'corn silage') }
  scope :soybeans, -> { where(name: 'soybeans') }
  scope :forage, -> { where(name: 'forage') }
  scope :oats, -> { where(name: 'oats') }

  # similar to scopes, but for use at times when scopes can't be called.
  def self.with_tillage_practice(tillage_practice)
    where(tillage_practice: tillage_practice)
  end

  def self.with_rotation_practice(rotation_practice)
    where(rotation_practice: rotation_practice)
  end

  def kwh
    energy_units_per_inventory_unit_for(EnergyUnit.where(slug:'electricity'))
  end

  # Store the following values in the Operation table as shortcuts to speed up access to common values...
  # They are automatically updated in the database anytime the fuel prices are updated
  def update_cached_values
    energy_dollars = 0
    co2e = 0
    btu = BigDecimal(0)

    EnergyUnit.find_each do |energy_unit|
      energy_dollars += (energy_units_per_inventory_unit_for(energy_unit) * energy_unit.dollars_per_unit)
      co2e += (energy_units_per_inventory_unit_for(energy_unit) * energy_unit.kg_of_co2e_emissions_per_unit)
      btu += (energy_units_per_inventory_unit_for(energy_unit) * energy_unit.btu_per_unit)
    end

    update(cached_energy_dollars_per_inventory_unit: energy_dollars)
    update(cached_co2e_emissions_per_inventory_unit: co2e)
    update(cached_mmbtus_per_inventory_unit: btu * 0.00001)

    update(cached_kwh_per_inventory_unit: kwh)

    if type == 'CropOperation'
      field = 0
      fertilizer = 0
      drying = 0
      EnergyUnit.find_each do |energy_unit|
        field += (energy_units_per_inventory_unit_for_energy_unit_and_category(energy_unit, 'field') * energy_unit.dollars_per_unit)
        drying += (energy_units_per_inventory_unit_for_energy_unit_and_category(energy_unit, 'drying') * energy_unit.dollars_per_unit)
        fertilizer += (energy_units_per_inventory_unit_for_energy_unit_and_category(energy_unit, 'fertilizer') * energy_unit.dollars_per_unit)
      end
      update(cached_field_dollars_per_inventory_unit: field)
      update(cached_drying_dollars_per_inventory_unit: drying)
      update(cached_fertilizer_dollars_per_inventory_unit: fertilizer)
    end
  end

  def energy_units_per_inventory_unit_for(energy_unit)
    @energy_use ||= Hash.new do |h, key|
      h[key] = steps.where(energy_unit: key).sum(:energy_units_used).round(2)
    end
    @energy_use[energy_unit]
  end

  def energy_units_per_inventory_unit_for_energy_unit_and_category(energy_unit, category)
    # @energy_use ||= Hash.new do |h, key|
    steps.where(energy_unit: energy_unit, category: category).sum(:energy_units_used).round(2)
    # end
    # @energy_use[energy_unit]
  end

  def categories
    steps.pluck(:category).uniq
  end

  def subcategories
    steps.pluck(:subcategory).uniq
  end

end
