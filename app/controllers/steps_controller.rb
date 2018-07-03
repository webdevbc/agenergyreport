class StepsController < ApplicationController
  def index
    @steps = Step.order(:sort_order).includes(:energy_unit)
  end

  private

  def step_params
    params.require(:step).permit(:type, :slug, :name, :cost, :energy_unit_id, :energy_units_used, :category, :subcategory, :source_text, :source_url, :notes)
  end
end
