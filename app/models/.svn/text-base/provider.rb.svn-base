class Provider < ActiveRecord::Base
  self.table_name = :provider
  self.primary_key = :provider_code
  
  def code_and_name
    "#{self.provider_code} - #{self.name}"
  end
  
  def self.join_price_plan
    from("provider p join price_plan pp on p.provider_code = pp.provider_code")
  end
  
  def self.join_service
    from("provider p join service s on p.provider_code = s.provider_code")
  end
  
  def self.join_product
    from("provider p join product prod on p.provider_code = prod.provider_code")
  end
end
