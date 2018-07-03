module OperationsHelper
  def humanize(string)
    case string
    when 'reduced_tillage'
      'Reduced Tillage'
    when 'no_tillage'
      'No-till'
    when 'intensive_tillage'
      'Intensive Tillage'
    when 'following_corn'
      'Following corn'
    when 'following_soybeans'
      'Following soybeans'
    else
      string
    end
  end

  def description_plus_tillage_practice(operation)
    if operation.tillage_practice
      "#{operation.description} (#{humanize(operation.tillage_practice)})"
    else
      operation.description
    end
  end

end
