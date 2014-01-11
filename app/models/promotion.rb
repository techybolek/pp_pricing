class Promotion < ActiveRecord::Base
  self.table_name = :promotion
  self.primary_key = :promotion_code
  
  self.set_string_columns "apply_promotion_ind"
  self.set_string_columns "period_type_ind"
  self.set_string_columns "apply_promotion_date_ind"
  self.set_string_columns "ignore_partial_ind"
  self.set_date_columns "first_activation_date"
  self.set_boolean_columns "ignore_partial_ind"
  
  def pricing_structures
    PricingStructure.for_promotion(self.promotion_code)
  end
  
  def promotion_terms
    PromotionTerm.rows_for_promotion(self.promotion_code)
  end
  
  def self.search(terms)
    terms.each { |key, value| terms[key] = wildcard(value) }
    
    select(
      "promotion.promotion_code, promotion.promotion_name,
      promotion.promotion_status, offering_period_start_date,
      promotion.offering_period_end_date, promotion.descriptive_text"
    ).joins(
      "-- search on pricing structure code && product code
      left outer join pricing_structure_promotion psp
        on promotion.promotion_code = psp.promotion_code
        and upper(psp.product_code) like #{sanitize(terms[:product_code])}
        and upper(psp.pricing_structure_code) like #{sanitize(terms[:pricing_structure_code])}
      -- search on product name
      left outer join product prd
        on psp.product_code = prd.product_code
        and upper(prd.name) like #{sanitize(terms[:product_name])}
      -- rate plan code && price plan code
      left outer join promotion_term pt
        on promotion.promotion_code = pt.promotion_code
        and upper(pt.rate_plan_code) like #{sanitize(terms[:rate_plan_code])}
        and upper(pt.price_plan_code) like #{sanitize(terms[:price_plan_code])}
      -- search rate plan name
      left outer join algorithm alg
        on pt.rate_plan_code = alg.rate_plan_code
        and upper(alg.name) like #{sanitize(terms[:rate_plan_name])}
      -- search on price plan name
      left outer join price_plan pp
        on pt.price_plan_code = pp.price_plan_code
        and upper(pp.name) like #{sanitize(terms[:price_plan_code])}"
    ).where(
      "upper(promotion.promotion_code) like :promotion_code
      and upper(promotion.promotion_name) like :promotion_name
      and upper(promotion.promotion_status) like :promotion_status
      and upper(promotion.test_mode_ind) like :promotion_test_mode_ind
      and upper(NVL(promotion.change_group_id, ' ')) like :change_group_id",terms
    ).group(
      "promotion.promotion_code, promotion.promotion_name,
      promotion.promotion_status, offering_period_start_date,
      promotion.offering_period_end_date, promotion.descriptive_text"
    )
  end
  
  def self.for_pricing_structure(pricing_structure_code, product_code, product_version_code)
    joins(
      "join pricing_structure_promotion psp
      on promotion.promotion_code = psp.promotion_code"
    ).where(
      "psp.pricing_structure_code = :pricing_structure_code
      and psp.product_code = :product_code
      and psp.product_version_code = :product_version_code", {
        pricing_structure_code: pricing_structure_code,
        product_code: product_code,
        product_version_code: product_version_code
      }
    )
  end
  
  protected
    def self.wildcard(term)
      return "#{term}%".gsub(/\*+/,'%').gsub(/%+/,'%').upcase
    end
end