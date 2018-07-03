class EnergyUnitsController < ApplicationController
  def index
    # @energy_units = EnergyUnit.all
  end

  private

  def energy_unit_params
    params.require(:energy_unit).permit(:name, :slug, :eia_series_id_code, :eia_cost_units, :eia_cost_units_short, :eia_cost_description, :eia_updated, :eia_latest_data_period, :eia_latest_data_value, :unit, :unit_short, :dollars_per_unit, :btu_per_unit, :kg_of_co2_emissions_per_unit, :kg_of_n2o_emissions_per_unit, :kg_of_ch4_emissions_per_unit)
  end
end
