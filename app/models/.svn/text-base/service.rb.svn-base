class Service < ActiveRecord::Base
  self.table_name = "service"

  def avaliable_usage_modes
    GeneralCodeItem.select(
      'unique usage_mode_value, short_description'
    ).joins(
      'left outer join service_usage_mode
      on general_code_item.value = service_usage_mode.usage_mode_value'
    ).where(
      "group_code= :group_code
      and usage_mode_value not in 
        (select usage_mode_value from service_usage_mode where service_code = :service_code)",{
        service_code: self.service_code,
        group_code: 'USAGE_MODE'
      }
    )
  end

  def usage_modes
    ServiceUsageMode.select(
      'service_usage_mode.*, short_description'
    ).joins(
      "left outer join general_code_item
      on service_usage_mode.usage_mode_value = general_code_item.value
      and general_code_item.group_code = 'USAGE_MODE'"
    ).where(service_code: self.service_code)
  end

  def associated_services
    ServiceAssociation.associations_for_service(self.service_code)
  end

  def characteristics
    ServiceCharacteristicValue.for_service(self.service_code, self.service_version_code)
  end

  def postal_codes
    ServicePostal.for_service(self.service_code, self.service_version_code)
  end

  def journalization
    ServiceJournalization.for_service(self.service_code, self.service_version_code)
  end

  def self.get(code, version)
    @service = Service.select(
      "service.*, service_level.service_level_value, service_level.descriptive_text as service_level_description"
    ).joins(
      "left outer join service_level
      on service.service_level_id = service_level.service_level_id"
    ).where(
      :service_code => code,
      :service_version_code => version
    ).first
  end

  def self.search(terms = {})
    # Wildcard all search terms
    terms.each { |key, value| terms[key] = wildcard(value) }
    
    select(
      "service.service_version_code, service.service_code, service.name, service.effective_status,
      service.effective_date, service.descriptive_text"
    ).joins(
      "left outer join service_postal sp
        on service.service_code = sp.service_code
        and service.service_version_code = sp.service_version_code
        and upper(NVL(sp.postal_code, '')) like #{sanitize(terms[:postal_code])}
      left outer join product_service_rule psr
        on service.service_code = psr.service_code
        and upper(NVL(psr.product_code, '')) like #{sanitize(terms[:product_code])}
      left outer join product p
        on psr.product_code = p.product_code
        and upper(NVL(p.name, '')) like #{sanitize(terms[:product_name])}
      left outer join service_association sa
        on service.service_code = sa.service_code
        and upper(NVL(sa.associated_service_code, '')) like #{sanitize(terms[:associated_service_code])}
      left outer join service s2
        on sa.associated_service_code = s2.service_code
        and upper(NVL(s2.name, '')) like #{sanitize(terms[:associated_service_name])}
      left outer join service_characteristic_value scv
        on service.service_code = scv.service_code
        and service.service_version_code = scv.service_version_code
        and upper(NVL(scv.service_char_code, '')) like #{sanitize(terms[:service_characteristic_code])}
      left outer join service_characteristic sc
        on scv.service_char_code = sc.service_char_code
        and upper(NVL(sc.name, '')) like #{sanitize(terms[:service_characteristic_name])}"
    ).group(
      "service.service_version_code, service.service_code, service.name, service.effective_status,
      service.effective_date, service.descriptive_text"
    ).where(
      "upper(service.service_code) like :service_code
       and upper(service.name) like :service_name
       and upper(service.technical_service_value) like :technical_service_value
       and upper(service.test_mode_ind) like :service_test_mode_ind
       and upper(NVL(service.change_group_id, ' ')) like :service_change_group_id
       and upper(NVL(service.provider_code, ' ')) like :provider_code",
    terms)
  end

  def self.for_price_plan_version(price_plan_version)
    select("distinct s.service_code, s.name, s.descriptive_text")
    .from("price_plan_service pp_service
             join service s
               on pp_service.service_code = s.service_code")
    .where("pp_service.price_plan_version_id = :price_plan_version
            and s.effective_date = 
              (select max(effective_date)
                from service
                where service.effective_date = s.effective_date)",{
           :price_plan_version => price_plan_version
     })
  end
  
  private
  
    def self.wildcard(term)
      return "#{term}%".gsub(/\*+/,'%').gsub(/%+/,'%').upcase
    end
end