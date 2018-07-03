class OperationsController < ApplicationController
  before_action :set_operation, only: [:show]

  def index
    @operations = Operation.order(:name)
  end

  def show
    @steps = @operation.steps.order(:sort_order)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_operation
    @operation = Operation.find(params[:id])
  end

  def operation_params
    params.require(:operation).permit(:name, :rotation_practice, :tillage_practice, :description, :classification)
  end
end
