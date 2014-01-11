class Product < ActiveRecord::Base
  self.table_name = "product"
  self.primary_key = :product_code

  before_create :default_values

  def self.by_provider(provider)
    where("provider_code in (select provider_code from provider where name = :name)",
      :name => provider)
  end

  def services
    ProductVersionService.services_for_product(self.product_code, self.product_version_code)
  end

  def pricing_structures
    PricingStructure.for_product(self.product_code, self.product_version_code)
  end

  def versions
    ProductVersion.where(
      product_code: self.product_code
    ).order(
      "product_version_code asc"
    )
  end

  def self.get(code, version)
    select(
      "*"
    ).joins(
      "join product_version
        on product.product_code = product_version.product_code"
    ).where(
      "product.product_code = :code
      and product_version.product_version_code = :version",{
        code: code,
        version: version
      }
    ).first
  end

  def self.search(filters = {})
    filters.each { |key, value| filters[key] = wildcard(value) if value.class == String}
    
    query = select(
      "product.product_code, product.name, pv.product_version_code,
      pv.effective_status, pv.effective_date, pv.descriptive_text"
    ).joins(
      "join product_version pv
        on product.product_code = pv.product_code
      left outer join product_version_service pvs
        on pv.product_version_code = pvs.product_version_code
      left outer join service s
        on pvs.service_code = s.service_code
        and s.service_code like #{sanitize(filters[:associated_service_code])}
        and s.name like #{sanitize(filters[:associated_service_name])}
      left outer join pricing_structure_qual psq
        on pv.product_code = psq.product_code
        and pv.product_version_code = psq.product_version_code
        and psq.qualification_group_code like #{sanitize(filters[:qualification_group_code])}
        and psq.qualification_value like #{sanitize(filters[:qualification_value])}"
    ).where(
      "NVL(pv.change_group_id, ' ') like :change_group_id
      and product.product_code like :product_code
      and product.name like :product_name
      and NVL(product.provider_code, ' ') like :provider_code
      and pv.test_mode_ind like :test_mode_ind", filters
    ).group(
      "product.product_code, product.name, pv.product_version_code,
      pv.effective_status, pv.effective_date, pv.descriptive_text"
    )
    
    query = query.most_effective if !filters[:search_all_versions]
    return query
  end
  
  protected
    def self.wildcard(term)
      return "#{term}%".gsub(/\*+/,'%').gsub(/%+/,'%').upcase
    end
    
    def default_values
      self.classification_value ||= "STANDARD"
      self.audit_update_user_id ||= "tromanow"
      self.audit_update_date_time = DateTime.now.to_date
      self.update_number ||= 1
    end
    
    def self.most_effective
      where(
        "pv.effective_date =
        (select max(effective_date)
          from product_version
            where product_code = product.product_code
            and effective_date <= :now)",{
        now: DateTime.now
      })
    end
end
