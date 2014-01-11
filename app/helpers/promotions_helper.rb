# encoding: utf-8

module PromotionsHelper

  def charge_type(type)
    if type && type == "RC"
      return "Recurring"
    elsif type && type == "OT"
      return "One Time"
    else
      return type
    end
  end

end