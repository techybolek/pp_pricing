# encoding: utf-8

module PricePlansHelper

  def rule_type(rule)
    if rule && rule.condition_id
      return "<strong>Ⓒ  </strong>".html_safe
    else
      return "<strong>Ⓐ  </strong>".html_safe
    end
  end
  
  def rule_condition_type(rule, parent)
    if parent.nil?
      '<i class="icon-ok"></i>'.html_safe
    elsif parent.true_rule_id == rule.selection_rule_id && parent.false_rule_id == rule.selection_rule_id
      '<i class="icon-exchange"></i>'.html_safe
    elsif parent.true_rule_id == rule.selection_rule_id
      '<i class="icon-ok"></i>'.html_safe
    elsif parent.false_rule_id == rule.selection_rule_id
      '<i class="icon-remove"></i>'.html_safe
    else
      '<i class="icon-question"></i>'.html_safe
    end
  end

  def event_type(value)
    results = GeneralCodeItem.where(:group_code => "SDC_TYPE", :value => value)
    if results.size > 0
      results = results.first.short_description
    else
      results = value
    end
    return results
  end
  
  def find_rate_effective_indicator(value)
    results = GeneralCodeItem.where(:group_code => "RATEFF_IND", :value => value)
    if results.size > 0
      results = results.first.short_description
    else
      results = value
    end
    return results
  end
  
  def find_calculation_type_indicator(value)
    results = GeneralCodeItem.where(:group_code => "CALCTYPE", :value => value)
    if results.size > 0
      results = results.first.short_description
    else
      results = value
    end
    return results
  end
  
  def find_summary_group(value)
    results = SummaryGroup.where(:summary_group_id => value)
    if results.size > 0
      results = results.first.name
    else
      results = 'None'
    end
    return results
  end
  
  def find_link_kind(value)
    results = GeneralCodeItem.where(:group_code => "EXPL_LINK", :value => value)
    if results.size > 0
      results = results.first.short_description
    else
      results = value
    end
    return results
  end
  
  def find_rate_plan_use(value)
    result = 'unknown'
    if value == 'T'
      result = 'Yes'
    elsif value == 'F'
      result = 'No'
    end
    return result
  end
  
  def find_tma_option_group(value)
    result = value
    if value == nil
      result = 'None'
    end
    return result
  end
  
  def find_measure_unit(value)
    results = select("*").from("measure_unit mu").where("mu.measure_unit_code = :value", { :value => value })
    if results.size > 0
      results = results.first.name
    else
      results = value
    end
    return results
  end
end