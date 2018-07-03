module EnergyUnitsHelper

  def round_energy_unit_value(e, value)
    if e.fertilizer?
      value.round
    else
      value
    end
  end


  def display_emission_value(number)
    if number < 10
      number_with_delimiter(number.round(1))
    elsif number < 1_000_000
      number_with_delimiter(number.round)
    else
      number_to_human(number)
    end
  end
end
