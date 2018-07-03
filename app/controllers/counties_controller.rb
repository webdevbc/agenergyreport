# frozen_string_literal: false

class CountiesController < ApplicationController
  before_action :set_county, only: [:show]
  before_action :set_custom_factors, only: [:show, :show_multiple]

  caches_page :index

  # GET /counties
  # GET /counties.json
  def index
    @counties = County.all
  end

  # GET /counties/1
  # GET /counties/1.json
  def show
    # used by partials to differentiate single county from multiple county
    @multiple = false

    ########### Initialize hashes ###########
    @acres = @county.acres_hash
    @head = @county.head_hash
    @classifications = @county.classifications_hash

    @crop_energy_dollars_hash = Hash.new(0)
    @crop_energy_dollars_per_acre_hash = Hash.new(0)
    @crop_co2e_emissions_hash = Hash.new(0)
    @crop_mmbtus_hash = Hash.new(0)
    @crop_field_dollars_hash = Hash.new(0)
    @crop_drying_dollars_hash = Hash.new(0)
    @crop_fertilizer_dollars_hash = Hash.new(0)

    @livestock_energy_dollars_hash = Hash.new(0)
    @livestock_energy_dollars_per_unit_hash = Hash.new(0)
    @livestock_co2e_emissions_hash = Hash.new(0)
    @livestock_mmbtus_hash = Hash.new(0)


    # used in calculating energy savings through electricity
    electricity = EnergyUnit.find_by(slug: 'electricity')


    CropOperation.order(:name).each do |op|
      # corn is special because it has a rotation factor as well; "corn silage", "forage", "oats", "soybeans" are not since they all use the same tillage factor
      @crop_energy_dollars_hash[op.name] += @acres[op.name].to_i * op.cached_energy_dollars_per_inventory_unit * @tillage_factor[op.tillage_practice] * (op.name == 'corn' ? @rotation_factor[op.rotation_practice] : 1)
      @crop_co2e_emissions_hash[op.name] += @acres[op.name].to_i * op.cached_co2e_emissions_per_inventory_unit * @tillage_factor[op.tillage_practice] * (op.name == 'corn' ? @rotation_factor[op.rotation_practice] : 1)
      @crop_mmbtus_hash[op.name] += @acres[op.name].to_i * op.cached_mmbtus_per_inventory_unit * @tillage_factor[op.tillage_practice] * (op.name == 'corn' ? @rotation_factor[op.rotation_practice] : 1)

      @crop_field_dollars_hash[op.name] += @acres[op.name].to_i * op.cached_field_dollars_per_inventory_unit * @tillage_factor[op.tillage_practice] * (op.name == 'corn' ? @rotation_factor[op.rotation_practice] : 1)
      @crop_drying_dollars_hash[op.name] += @acres[op.name].to_i * op.cached_drying_dollars_per_inventory_unit * @tillage_factor[op.tillage_practice] * (op.name == 'corn' ? @rotation_factor[op.rotation_practice] : 1)
      @crop_fertilizer_dollars_hash[op.name] += @acres[op.name].to_i * op.cached_fertilizer_dollars_per_inventory_unit * @tillage_factor[op.tillage_practice] * (op.name == 'corn' ? @rotation_factor[op.rotation_practice] : 1)

      if @energy_savings_factor > 0
        # subtract energy savings from energy_dollars, co2e, mmbtus, and drying hashes
        electricity_dollars_per_inventory_unit = op.cached_kwh_per_inventory_unit * electricity.dollars_per_unit
        electricity_co2e_per_inventory_unit = op.cached_kwh_per_inventory_unit * electricity.kg_of_co2e_emissions_per_unit
        electricity_mmbtu_per_inventory_unit = op.cached_kwh_per_inventory_unit * electricity.btu_per_unit * 0.00001

        @crop_energy_dollars_hash[op.name] -= @energy_savings_factor * @acres[op.name].to_i * electricity_dollars_per_inventory_unit * @tillage_factor[op.tillage_practice] * (op.name == 'corn' ? @rotation_factor[op.rotation_practice] : 1)
        @crop_co2e_emissions_hash[op.name] -= @energy_savings_factor * @acres[op.name].to_i * electricity_co2e_per_inventory_unit * @tillage_factor[op.tillage_practice] * (op.name == 'corn' ? @rotation_factor[op.rotation_practice] : 1)
        @crop_mmbtus_hash[op.name]         -= @energy_savings_factor * @acres[op.name].to_i * electricity_mmbtu_per_inventory_unit * @tillage_factor[op.tillage_practice] * (op.name == 'corn' ? @rotation_factor[op.rotation_practice] : 1)
        @crop_drying_dollars_hash[op.name] -= @energy_savings_factor * @acres[op.name].to_i * electricity_dollars_per_inventory_unit * @tillage_factor[op.tillage_practice] * (op.name == 'corn' ? @rotation_factor[op.rotation_practice] : 1)
        # @crop_fertilizer_dollars_hash and @crop_field_dollars_hash are unaffected because field and fertilizer operations use no electricity
      end
    end

    @acres.keys.each do |key|
      @crop_energy_dollars_per_acre_hash[key] = @crop_energy_dollars_hash[key] / @acres[key]
    end

    LivestockOperation.all.each do |op|
      # op.names => ["chickens", "hogs", "cattle"]
      # op.classifications => ["dairy cows", "other cattle", "broilers", "layers", nil, "beef cows"]
      # notice, hogs are the only livestock without a classification. The following methods work because op.name is used for the key only if op.classification is nil

      @livestock_energy_dollars_hash[op.name] += @classifications[(op.classification || op.name)].to_i * op.cached_energy_dollars_per_inventory_unit
      @livestock_co2e_emissions_hash[op.name] += @classifications[(op.classification || op.name)].to_i * op.cached_co2e_emissions_per_inventory_unit
      @livestock_mmbtus_hash[op.name] += @classifications[(op.classification || op.name)].to_i * op.cached_mmbtus_per_inventory_unit

      if @energy_savings_factor != 0
        # subtract energy savings from energy_dollars, co2e, and mmbtus hashes
        electricity_dollars_per_inventory_unit = op.cached_kwh_per_inventory_unit * electricity.dollars_per_unit
        electricity_co2e_per_inventory_unit = op.cached_kwh_per_inventory_unit * electricity.kg_of_co2e_emissions_per_unit
        electricity_mmbtu_per_inventory_unit = op.cached_kwh_per_inventory_unit * electricity.btu_per_unit * 0.00001

        @livestock_energy_dollars_hash[op.name] -= @energy_savings_factor * @classifications[(op.classification || op.name)].to_i * electricity_dollars_per_inventory_unit
        @livestock_co2e_emissions_hash[op.name] -= @energy_savings_factor * @classifications[(op.classification || op.name)].to_i * electricity_co2e_per_inventory_unit
        @livestock_mmbtus_hash[op.name]         -= @energy_savings_factor * @classifications[(op.classification || op.name)].to_i * electricity_mmbtu_per_inventory_unit
      end
    end

    # Build the @livestock_energy_dollars_per_unit_hash by taking the totals energy dollars divided by # of head
    @head.keys.each do |key|
      @livestock_energy_dollars_per_unit_hash[key] = @livestock_energy_dollars_hash[key] / @head[key]
    end

    #     ########### SUM THE VALUES IN THE HASHES FOR EASY VIEWS ###########

    @crop_energy_dollars = @crop_energy_dollars_hash.map(&:last).reduce(:+)
    @livestock_energy_dollars = @livestock_energy_dollars_hash.map(&:last).reduce(:+)
    @crop_field_dollars = @crop_field_dollars_hash.map(&:last).reduce(:+)
    @crop_drying_dollars = @crop_drying_dollars_hash.map(&:last).reduce(:+)
    @crop_fertilizer_dollars = @crop_fertilizer_dollars_hash.map(&:last).reduce(:+)

    #     ########### COMBINE CROP DATA WITH LIVESTOCK DATA ###########

    @combined_energy_dollars = @crop_energy_dollars + @livestock_energy_dollars
    @combined_co2e_emissions = @crop_co2e_emissions_hash.map(&:last).reduce(:+) + @livestock_co2e_emissions_hash.map(&:last).reduce(:+)
    @combined_mmbtus = @crop_mmbtus_hash.map(&:last).reduce(:+) + @livestock_mmbtus_hash.map(&:last).reduce(:+)

    ########

    respond_to do |format|
      format.html
      format.json
    end
  end

  def show_multiple
    if params[:selectedCounties].empty? || params[:selectedCounties].blank? || (params[:selectedCounties] == '[]')
      redirect_back(flash: { error: 'Please select at least one county.' }, fallback_location: root_path) # halts request cycle
    else
      @selected_counties = County.where(fips: JSON.parse(params[:selectedCounties])).order(:slug)
      # @selected_counties = County.all
      redirect_to @selected_counties.first if @selected_counties.size == 1

      # used by partials to differentiate single county from multiple county
      @multiple = true

      # Initialize Empty Hashes with zeros or other hashes with zeros
      @acres = Hash.new(0)
      @head = Hash.new(0)
      @classifications = Hash.new { |hash, key| hash[key] = Hash.new(0) }

      @crop_energy_dollars_hash = Hash.new { |hash, key| hash[key] = Hash.new(0) }
      @crop_energy_dollars_per_acre_hash = Hash.new { |hash, key| hash[key] = Hash.new(0) }
      @crop_co2e_emissions_hash = Hash.new { |hash, key| hash[key] = Hash.new(0) }
      @crop_mmbtus_hash = Hash.new { |hash, key| hash[key] = Hash.new(0) }
      @crop_field_dollars_hash = Hash.new { |hash, key| hash[key] = Hash.new(0) }
      @crop_drying_dollars_hash = Hash.new { |hash, key| hash[key] = Hash.new(0) }
      @crop_fertilizer_dollars_hash = Hash.new { |hash, key| hash[key] = Hash.new(0) }

      @aggregate_crop_energy_dollars = Hash.new(0)
      @aggregate_livestock_energy_dollars = Hash.new(0)
      @crop_field_dollars = Hash.new(0)
      @crop_drying_dollars = Hash.new(0)
      @crop_fertilizer_dollars = Hash.new(0)
      @combined_energy_dollars = Hash.new(0)
      @combined_mmbtus = Hash.new(0)
      @combined_co2e_emissions = Hash.new(0)

      @livestock_energy_dollars_hash = Hash.new { |hash, key| hash[key] = Hash.new(0) }
      @livestock_energy_dollars_per_unit_hash = Hash.new { |hash, key| hash[key] = Hash.new(0) }
      @livestock_co2e_emissions_hash = Hash.new { |hash, key| hash[key] = Hash.new(0) }
      @livestock_mmbtus_hash = Hash.new { |hash, key| hash[key] = Hash.new(0) }


      @crop_operations = CropOperation.order(:name)
      @livestock_operations = LivestockOperation.order(:name)

      # used in calculating energy savings through electricity
      electricity = EnergyUnit.find_by(slug: 'electricity')



      # Calculate values for each hash
      @selected_counties.each_with_index do |county, index|
        @acres[county.id] = county.acres_hash

        @classifications[county.id] = county.classifications_hash
        @head[county.id] = county.head_hash

        @crop_operations.each do |op|
          # corn is special because it has a rotation factor as well; "corn silage", "forage", "oats", "soybeans" are not since they all use the same tillage factor
          @crop_energy_dollars_hash[county.id][op.name] += @acres[county.id][op.name].to_i * op.cached_energy_dollars_per_inventory_unit * @tillage_factor[op.tillage_practice] * (op.name == 'corn' ? @rotation_factor[op.rotation_practice] : 1)
          @crop_co2e_emissions_hash[county.id][op.name] += @acres[county.id][op.name].to_i * op.cached_co2e_emissions_per_inventory_unit * @tillage_factor[op.tillage_practice] * (op.name == 'corn' ? @rotation_factor[op.rotation_practice] : 1)
          @crop_mmbtus_hash[county.id][op.name] += @acres[county.id][op.name].to_i * op.cached_mmbtus_per_inventory_unit * @tillage_factor[op.tillage_practice] * (op.name == 'corn' ? @rotation_factor[op.rotation_practice] : 1)

          @crop_drying_dollars_hash[county.id][op.name] += @acres[county.id][op.name].to_i * op.cached_drying_dollars_per_inventory_unit * @tillage_factor[op.tillage_practice] * (op.name == 'corn' ? @rotation_factor[op.rotation_practice] : 1)
          @crop_field_dollars_hash[county.id][op.name] += @acres[county.id][op.name].to_i * op.cached_field_dollars_per_inventory_unit * @tillage_factor[op.tillage_practice] * (op.name == 'corn' ? @rotation_factor[op.rotation_practice] : 1)
          @crop_fertilizer_dollars_hash[county.id][op.name] += @acres[county.id][op.name].to_i * op.cached_fertilizer_dollars_per_inventory_unit * @tillage_factor[op.tillage_practice] * (op.name == 'corn' ? @rotation_factor[op.rotation_practice] : 1)

          if @energy_savings_factor > 0
            # subtract energy savings from energy_dollars, co2e, mmbtus, and drying hashes
            electricity_dollars_per_inventory_unit = op.cached_kwh_per_inventory_unit * electricity.dollars_per_unit
            electricity_co2e_per_inventory_unit = op.cached_kwh_per_inventory_unit * electricity.kg_of_co2e_emissions_per_unit
            electricity_mmbtu_per_inventory_unit = op.cached_kwh_per_inventory_unit * electricity.btu_per_unit * 0.00001

            @crop_energy_dollars_hash[county.id][op.name] -= @energy_savings_factor * @acres[county.id][op.name].to_i * electricity_dollars_per_inventory_unit * @tillage_factor[op.tillage_practice] * (op.name == 'corn' ? @rotation_factor[op.rotation_practice] : 1)
            @crop_co2e_emissions_hash[county.id][op.name] -= @energy_savings_factor * @acres[county.id][op.name].to_i * electricity_co2e_per_inventory_unit * @tillage_factor[op.tillage_practice] * (op.name == 'corn' ? @rotation_factor[op.rotation_practice] : 1)
            @crop_mmbtus_hash[county.id][op.name] -=         @energy_savings_factor * @acres[county.id][op.name].to_i * electricity_mmbtu_per_inventory_unit * @tillage_factor[op.tillage_practice] * (op.name == 'corn' ? @rotation_factor[op.rotation_practice] : 1)
            @crop_drying_dollars_hash[county.id][op.name] -= @energy_savings_factor * @acres[county.id][op.name].to_i * electricity_dollars_per_inventory_unit * @tillage_factor[op.tillage_practice] * (op.name == 'corn' ? @rotation_factor[op.rotation_practice] : 1)
            # @crop_fertilizer_dollars_hash and @crop_field_dollars_hash are unaffected because field and fertilizer operations use no electricity
          end
        end

        @livestock_operations.each do |op|
          # op.names => ["chickens", "hogs", "cattle"]
          # op.classifications => ["dairy cows", "other cattle", "broilers", "layers", nil, "beef cows"]
          # notice, hogs are the only livestock without a classification. The following methods work because op.name is used for the key only if op.classification is nil
          @livestock_energy_dollars_hash[county.id][op.name] += @classifications[county.id][(op.classification || op.name)].to_i * op.cached_energy_dollars_per_inventory_unit
          @livestock_co2e_emissions_hash[county.id][op.name] += @classifications[county.id][(op.classification || op.name)].to_i * op.cached_co2e_emissions_per_inventory_unit
          @livestock_mmbtus_hash[county.id][op.name] += @classifications[county.id][(op.classification || op.name)].to_i * op.cached_mmbtus_per_inventory_unit

          if @energy_savings_factor != 0
            # subtract energy savings from energy_dollars, co2e, and mmbtus hashes
            electricity_dollars_per_inventory_unit = (op.cached_kwh_per_inventory_unit * electricity.dollars_per_unit)
            electricity_co2e_per_inventory_unit = (op.cached_kwh_per_inventory_unit * electricity.kg_of_co2e_emissions_per_unit)
            electricity_mmbtu_per_inventory_unit = (op.cached_kwh_per_inventory_unit * electricity.btu_per_unit) * 0.00001

            @livestock_energy_dollars_hash[county.id][op.name] -= @energy_savings_factor * @classifications[county.id][(op.classification || op.name)].to_i * electricity_dollars_per_inventory_unit
            @livestock_co2e_emissions_hash[county.id][op.name] -= @energy_savings_factor * @classifications[county.id][(op.classification || op.name)].to_i * electricity_co2e_per_inventory_unit
            @livestock_mmbtus_hash[county.id][op.name]         -= @energy_savings_factor * @classifications[county.id][(op.classification || op.name)].to_i * electricity_mmbtu_per_inventory_unit
          end
        end

        #     ########### SUM THE VALUES IN THE HASHES FOR EASY VIEWS ###########

        # Summed by county...
        @aggregate_crop_energy_dollars[county.id] = @crop_energy_dollars_hash[county.id].map(&:last).reduce(:+)
        @aggregate_livestock_energy_dollars[county.id] = @livestock_energy_dollars_hash[county.id].map(&:last).reduce(:+)
        @crop_field_dollars[county.id] = @crop_field_dollars_hash[county.id].map(&:last).reduce(:+)
        @crop_drying_dollars[county.id] = @crop_drying_dollars_hash[county.id].map(&:last).reduce(:+)
        @crop_fertilizer_dollars[county.id] = @crop_fertilizer_dollars_hash[county.id].map(&:last).reduce(:+)



        # only need to do the following once, not for every county. Doing it in this manner however, may cause problems if a crop isn't grown or livestock isn't raised in the county that matches the index e.g. first).
        if index == 0
          @acres[county.id].keys.each do |key|
            @crop_energy_dollars_per_acre_hash[county.id][key] = @crop_energy_dollars_hash[county.id][key] / @acres[county.id][key]
          end

          # Build the @livestock_energy_dollars_per_unit_hash by taking the totals energy dollars divided by number of head
          @head[county.id].keys.each do |key|
            @livestock_energy_dollars_per_unit_hash[county.id][key] = @livestock_energy_dollars_hash[county.id][key] / @head[county.id][key]
          end
        end

        #  summed by crop or species (e.g. cattle, chicken, hogs) (not broken down by dairy cattle etc.)

        @combined_acres = sum = Hash.new(0)
        @acres.values.each_with_object(sum) do |hash, sum|
          hash.each { |key, value| sum[key] += value }
        end

        @combined_head = sum = Hash.new(0)
        @head.values.each_with_object(sum) do |hash, sum|
          hash.each { |key, value| sum[key] += value }
        end

        @crop_energy_dollars = sum = Hash.new(0)
        @crop_energy_dollars_hash.values.each_with_object(sum) do |hash, sum|
          hash.each { |key, value| sum[key] += value }
        end

        @livestock_energy_dollars = sum = Hash.new(0)
        @livestock_energy_dollars_hash.values.each_with_object(sum) do |hash, sum|
          hash.each { |key, value| sum[key] += value }
        end

        #     ########### COMBINE CROP DATA WITH LIVESTOCK DATA ###########

        @combined_energy_dollars[county.id] = @aggregate_crop_energy_dollars[county.id] + @aggregate_livestock_energy_dollars[county.id]
        @combined_mmbtus[county.id] = @crop_mmbtus_hash[county.id].map(&:last).reduce(:+) + @livestock_mmbtus_hash[county.id].map(&:last).reduce(:+)
        @combined_co2e_emissions[county.id] = @crop_co2e_emissions_hash[county.id].map(&:last).reduce(:+) + @livestock_co2e_emissions_hash[county.id].map(&:last).reduce(:+)

        ########
      end

    end
    respond_to do |format|
      format.html
    end
  end

  private

  def set_custom_factors
    if params[:reset] # reset button was clicked
      session[:tillage_factor] = {
        'no_tillage' => 6 / 100.0,
        'reduced_tillage' => 49 / 100.0,
        'intensive_tillage' => 45 / 100.0
      }
      session[:rotation_factor] = {
        'following_corn' => 60 / 100.0,
        'following_soybeans' => 40 / 100.0
      }
    elsif params[:no_tillage] # form was submitted
      session[:tillage_factor]['no_tillage'] = percentage_to_number(params['no_tillage'])
      session[:tillage_factor]['reduced_tillage'] = percentage_to_number(params['reduced_tillage'])
      session[:tillage_factor]['intensive_tillage'] = percentage_to_number(params['intensive_tillage'])

      session[:rotation_factor]['following_corn'] = percentage_to_number(params['following_corn'])
      session[:rotation_factor]['following_soybeans'] = percentage_to_number(params['following_soybeans'])

    elsif session[:tillage_factor] # page was refreshed, another page was visited, or another form was submitted: change nothing
    else # initial load
      session[:tillage_factor] = {
        'no_tillage' => 6 / 100.0,
        'reduced_tillage' => 49 / 100.0,
        'intensive_tillage' => 45 / 100.0
      }
      session[:rotation_factor] = {
        'following_corn' => 60 / 100.0,
        'following_soybeans' => 40 / 100.0
      }

    end
    @tillage_factor = session[:tillage_factor]
    @rotation_factor = session[:rotation_factor]


    if params[:reset_energy] # reset button was clicked
      session[:energy_savings_factor] = 0
    elsif params[:energy_savings_factor] # form was submitted
      session[:energy_savings_factor] = percentage_to_number(params['energy_savings_factor'])
    elsif session[:energy_savings_factor] # do nothing
    else
      session[:energy_savings_factor] = 0 # initial load
    end
    @energy_savings_factor = session[:energy_savings_factor]

  end

  # Use callbacks to share common setup or constraints between actions.
  def set_county
    @county = County.friendly.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def county_params
    params.require(:county).permit(:name, :state_alpha, :state_name)
  end

  def percentage_to_number(string)
    string.chomp('%').to_f / 100
  end
end
