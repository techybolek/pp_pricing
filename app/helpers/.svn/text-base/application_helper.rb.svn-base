module ApplicationHelper
  def pagination_options
    [["10", 10],
     ["25", 25],
     ["50", 50],
     ["100", 100],
     ["All", 99999]]
  end
  
  def sortable(collection, column_name, column)
    icon = ''
    direction = " asc"
    if collection && collection.respond_to?(:order_values) && collection.order_values[0]
      if collection.order_values[0].match(/#{column}/i) != nil
        if collection.order_values[0].match(/desc/i)
          icon = " <i class='icon-chevron-down'></i>".html_safe
        else
          icon = " <i class='icon-chevron-up'></i>".html_safe
          direction = " desc"
        end
      end
    end
    
    link_to (column_name + icon).html_safe, :order=> (column + direction)
  end
  
  def autotab
    @current_tab ||= 0
    @current_tab += 1
  end

  def autotab_with_offset(offset)
    @current_tab ||= 0
    @current_tab += 1
    return @current_tab + offset
  end
  
  def indicator(ind)
    return "Yes" if ind == 'Y'
    return "No" if ind == 'N'
    ind
  end
  
  def alternate_status(status)
    case status
    when "ACTIVE"
      "Released"
    when "APPRVD"
      "Approved"
    when "DRAFT"
      "Draft"
    else
      status
    end
  end
  
  def nullable_date(date)
    if date && date.year == 1900
      return nil
    end
    return date
  end
end
