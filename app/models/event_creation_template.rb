class EventCreationTemplate < ActiveRecord::Base
  self.table_name = "event_creation_template"
  self.primary_key = "event_creation_template_ver_id"
  
  self.set_boolean_columns "apply_min_period_indicator"
  self.set_boolean_columns "test_mode_ind"
  
  self.set_string_columns "period_type_value"
  
  def charge_occurrence_name
    if self.charge_occurrence_type == "RC"
      "Recurring"
    elsif "OT"
      "One-Time"
    else
      self.charge_occurrence_type
    end
  end
  
  def self.search(filters = {})
    filters.each { |key, value| filters[key] = wildcard(value) if value.class == String}
    
    query = select(
      "ect.event_creation_template_ver_id, ect.code, ect.name, ect.effective_status, ect.effective_date,
       ect.charge_occurrence_type, ect.descriptive_text, s.name as service_name, s.service_code, gci.short_description as usage_mode_name"
    ).from(
      "event_creation_template ect"
    ).joins(
      "left outer join pricing_structure_ect psect
        on ect.event_creation_template_id = psect.event_creation_template_id
      left outer join pricing_structure_price_plan pspp
        on psect.pricing_structure_code = pspp.pricing_structure_code
        and psect.product_version_code = pspp.product_version_code
        and psect.product_code = pspp.product_code
      left outer join price_plan pp
        on pspp.price_plan_code = pp.price_plan_code
      left outer join price_plan_service pps
        on pp.price_plan_version_id = pps.price_plan_version_id
        and upper(pps.service_code) like #{sanitize(filters[:service_code])}
      left outer join service s
        on pps.service_code = s.service_code
        and upper(s.name) like #{sanitize(filters[:service_name])}
      left outer join general_code_item gci
        on gci.group_code = 'USAGE_MODE'
        and ect.usage_mode_value = gci.value"
    ).where(
      "upper(ect.code) like :ect_code
      and upper(ect.name) like :ect_name
      and ect.effective_status like :effective_status
      and ect.usage_mode_value like :usage_mode_value
      and ect.test_mode_ind like :test_mode_ind
      and NVL(ect.change_group_id, ' ') like :change_group_id
      and ect.charge_occurrence_type like :charge_occurrence_type", filters
    ).group(
      "ect.event_creation_template_ver_id, ect.code, ect.name, ect.effective_status, ect.effective_date,
       ect.charge_occurrence_type, ect.descriptive_text, s.name, s.service_code, gci.short_description"
    )
    
    query = query.most_effective if !filters[:search_all_versions]
    return query
  end
  
  def self.for_pricing_structure(pricing_structure_code, product_code, product_version_code)
    select("event_creation_template.*, gci.short_description as usage_mode_name")
    .joins(
      "join pricing_structure_ect psect
        on event_creation_template.event_creation_template_id = psect.event_creation_template_id
      left outer join general_code_item gci
        on gci.group_code = 'USAGE_MODE'
        and event_creation_template.usage_mode_value = gci.value"
    ).where(
      "psect.pricing_structure_code = :pricing_structure_code
      and psect.product_code = :product_code
      and psect.product_version_code = :product_version_code",{
        pricing_structure_code: pricing_structure_code,
        product_code: product_code,
        product_version_code: product_version_code
      }
    )
  end
  
  protected
    
    def self.wildcard(term)
      "%#{term}%".gsub(/\*+/,'%').gsub(/%+/,'%').upcase
    end
    
    def self.most_effective
      where(
        "ect.effective_date =
        (select max(effective_date)
          from event_creation_template ect2
            where ect.event_creation_template_id = ect2.event_creation_template_id
            and effective_date <= :now)",{
        now: DateTime.now
      })
    end
end
