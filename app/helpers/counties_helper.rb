module CountiesHelper
  def latest_crop_stats_list(county)
    latest_stat_list(county, :crop)
  end

  def latest_livestock_stats_list(county)
    latest_stat_list(county, :livestock)
  end

  private

  def latest_stat_list(county, stat_type)
    string = '<ul class="list-unstyled">'

    case stat_type
    when :crop
      county.latest_crop_stats.each do |stat|
        string += "<li class='py-1'>#{link_to stat.short_desc.titleize, stat} <em>(#{stat.year})</em>: #{stat.value}</li>"
      end
    when :livestock
      county.latest_livestock_stats.each do |stat|
        string += "<li class='py-1'>#{link_to stat.short_desc.titleize, stat} <em>(#{stat.reference_period_desc.titleize}, #{stat.year})</em>: #{stat.value}</li>"
      end
    end
    string + '</ul>'
  end
end
