class ProductVersionService < ActiveRecord::Base
  self.table_name = :product_version_service
  
  def self.services_for_product(code, version)
    Service.select(
      "s.*, pvs.maximum_subscriptions, pvs.product_subscription_rule"
    ).from(
      "product_version_service pvs"
    ).joins(
      "join service s
        on pvs.service_code = s.service_code
          and s.effective_date = 
            (select max(effective_date)
              from service
              where service_code = s.service_code)"
    ).where(
      "pvs.product_code = :code
       and pvs.product_version_code = :version",{
        code: code,
        version: version
      }
    )
  end
end