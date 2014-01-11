class PromotionTerm < ActiveRecord::Base
  self.table_name = :promotion_term
  self.primary_key = :promotion_term_id
  
  @ranges = nil
  
  def includes_period?(period)
    build_ranges if @ranges.nil?
    found = false
    @ranges.each do |range|
      if range.include?(period)
        found = true
        break
      end
    end
    return found
  end
  
  def self.rows_for_promotion(promotion_code)
    select(
      "price_plan_code, service_code, usage_mode_rd, gci.short_description as usage_mode_name,
       charge_occurance_type_rd, rate_plan_code, promotion_code"
    ).joins(
      "left outer join general_code_item gci
        on gci.group_code = 'USAGE_MODE'
        and promotion_term.usage_mode_rd = gci.value"
    ).where(
      promotion_code: promotion_code
    ).group(
      "price_plan_code, service_code, usage_mode_rd, gci.short_description,
       charge_occurance_type_rd, rate_plan_code, promotion_code"
    ).order("price_plan_code asc")
  end
  
  protected
    def promotion_terms
      PromotionTerm.where(
        promotion_code: self.promotion_code,
        price_plan_code: self.price_plan_code,
        service_code: self.service_code,
        usage_mode_rd: self.usage_mode_rd,
        charge_occurance_type_rd: self.charge_occurance_type_rd,
        rate_plan_code: self.rate_plan_code,
        promotion_code: self.promotion_code
      )
    end
    
    def build_ranges
      @ranges = []
      promotion_terms.each do |row|
        @ranges << Range.new(row.term_start_period, row.term_start_period + row.term_duration - 1)
      end
    end
end