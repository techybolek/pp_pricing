class PricingStructure < ActiveRecord::Base
  self.table_name = :pricing_structure
  
  set_date_columns :start_date, :end_date
  
  def price_plans
    PricePlan.for_pricing_structure(
      self.pricing_structure_code,
      self.product_code,
      self.product_version_code
    )
  end
  
  def ects
    EventCreationTemplate.for_pricing_structure(
      self.pricing_structure_code,
      self.product_code,
      self.product_version_code
    )
  end
  
  def promotions
    Promotion.for_pricing_structure(
      self.pricing_structure_code,
      self.product_code,
      self.product_version_code
    )
  end
  
  def qualifications
    PricingStructureQual.for_pricing_structure(
      self.pricing_structure_code,
      self.product_code,
      self.product_version_code
    )
  end
  
  def self.for_product(code, version)
    PricingStructure.where(
      product_code: code,
      product_version_code: version
    )
  end
  
  def self.for_promotion(promotion_code)
    select(
      "pricing_structure.*, p.name as product_name"
    ).joins(
      "join pricing_structure_promotion psp
        on pricing_structure.product_code = psp.product_code
        and pricing_structure.product_version_code = psp.product_version_code
        and pricing_structure.pricing_structure_code = psp.pricing_structure_code
      join product p
        on pricing_structure.product_code = p.product_code"
    ).where(
      "psp.promotion_code = :promotion_code", {
        promotion_code: promotion_code
      }
    )
  end
end