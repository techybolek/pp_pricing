class PlanSelectionRuleSet < ActiveRecord::Base
  self.table_name = :plan_selection_rule_set
  self.primary_key = :plan_selection_rule_set_id
  
  def self.find_selection_rule_set
    select("*")
    .from("plan_selection_rule_set psrs")
    .where("psrs.effective_date =
              (select max(effective_date)
                from plan_selection_rule_set eps
                  where eps.effective_status = 'ACTIVE')
            and psrs.effective_status = 'ACTIVE'");
  end
  
  def self.find_selection_rule_set_draft
    select("*")
    .from("plan_selection_rule_set psrs")
    .where("psrs.effective_date =
              (select max(effective_date)
                from plan_selection_rule_set eps
                  where eps.effective_status = 'ACTIVE')
            and psrs.effective_status = 'DRAFT'");
  end
  
  def self.get_rule_info(rule_id)
    select("psr.*, src.*, pp.*, src.name as condition_name, pp.name as price_plan_name")
    .from("plan_selection_rule psr
            left outer join selection_rule_condition src
              on psr.condition_id = src.condition_id
            left outer join price_plan pp
              on psr.price_plan_code = pp.price_plan_code")
    .where("psr.selection_rule_id = :rule_id", :rule_id => rule_id).first
  end
  
  def name
    return condition_name || price_plan_name
  end
  
  def condition_details
    SelectionRuleCondition.for_condition_id(condition_id)
  end
  
  def provider
    Provider.find(self.provider_code)
  end
  
  def services
    Service.for_price_plan_version(self.price_plan_version_id)
  end
  
  def options
    PricePlanOption.for_price_plan_version(self.price_plan_version_id)
  end
  
  def late_usage_description
    GeneralCodeItem.lookup("LATE_USAGE", self.separate_late_usage_ind).short_description
  end
  
  def state
    case effective_status
    when "ACTIVE"
      "Released"
    when "APPRVD"
      "Approved"
    when "DRAFT"
      "Draft"
    else
      effective_status
    end
  end
end