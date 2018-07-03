class StatisticsController < ApplicationController
  before_action :set_statistic, only: %i[show edit update destroy]
  caches_page :show, :index

  # GET counties/96/statistics
  # GET counties/96/statistics.json
  def index
    @county = County.friendly.find(params[:county_id])
    @stats = @county.statistics
    @years = @stats.pluck('DISTINCT year_int').sort.reverse
  end

  # GET /statistics/1
  # GET /statistics/1.json
  def show
    @county = @statistic.county
  end

  # GET /statistics/new
  def new
    @statistic = Statistic.new
  end

  # GET /statistics/1/edit
  def edit; end

  # POST /statistics
  # POST /statistics.json
  def create
    @statistic = Statistic.new(statistic_params)

    respond_to do |format|
      if @statistic.save
        format.html { redirect_to @statistic, notice: 'Statistic was successfully created.' }
        format.json { render :show, status: :created, location: @statistic }
      else
        format.html { render :new }
        format.json { render json: @statistic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /statistics/1
  # PATCH/PUT /statistics/1.json
  def update
    respond_to do |format|
      if @statistic.update(statistic_params)
        format.html { redirect_to @statistic, notice: 'Statistic was successfully updated.' }
        format.json { render :show, status: :ok, location: @statistic }
      else
        format.html { render :edit }
        format.json { render json: @statistic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /statistics/1
  # DELETE /statistics/1.json
  def destroy
    @statistic.destroy
    respond_to do |format|
      format.html { redirect_to statistics_url, notice: 'Statistic was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_statistic
    @statistic = Statistic.includes(:county).find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def statistic_params
    params.fetch(:statistic, {})
  end
end
