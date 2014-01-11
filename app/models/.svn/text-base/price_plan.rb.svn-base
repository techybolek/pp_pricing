class PricePlan < ActiveRecord::Base
  require 'securerandom'
  self.table_name = :price_plan
  self.primary_key = :price_plan_version_id

  before_create :default_values
  attr_accessible :price_plan_code, :name, :effective_date

  #has_many :algorithm_selection_rules
  #has_many :selection_rule_conditions, :through => :algorithm_selection_rules
  #accepts_nested_attributes_for :algorithm_selection_rules, :selection_rule_conditions


  validates :name, :presence => true, :length => { :maximum => 30 }
  validates :price_plan_code, :presence => true, :length => { :maximum => 5 }
  validates :provider_code, :presence => true, :length => { :maximum => 5 }
  validates :service_independent_indicator, :presence => true, :length => { :maximum => 1 }
  validates :effective_date, :presence => true
  validates :billing_name_1, :presence => true, :length => { :maximum => 30 }
  validates :period_type_rd, :presence => true, :length => { :maximum => 16 }
  validates :period_factor, :presence => true, :length => { :maximum => 3 }

  def self.for_pricing_structure(pricing_structure_code, product_code, product_version_code)
    select(
      "pp.*, pspp.price_plan_sub1_rtti_path, pspp.price_plan_sub2_rtti_path,
      pspp.accumulation_account_rtti_path, pspp.option_value_rtti_path"
    ).from(
      "pricing_structure ps"
    ).joins(
      "join pricing_structure_price_plan pspp
        on ps.pricing_structure_code = pspp.pricing_structure_code
        and ps.product_code = pspp.product_code
        and ps.product_version_code = pspp.product_version_code
      join price_plan pp
        on pspp.price_plan_code = pp.price_plan_code
        and pp.effective_date = 
          (select max(effective_date)
            from price_plan where price_plan_code = pp.price_plan_code)"
    ).where(
      "ps.pricing_structure_code = :pricing_structure_code
      and ps.product_code = :product_code
      and ps.product_version_code = :product_version_code",{
        pricing_structure_code: pricing_structure_code,
        product_code: product_code,
        product_version_code: product_version_code
      }
    )
  end

  def self.search(terms)
    keys = [:price_plan_code, :price_plan_name, :price_plan_supplier_name, :test_mode,
            :price_plan_service_name, :price_plan_service_code, :price_plan_tma_code,
            :change_group_id]
    keys.each do |key|
      terms[key] = '' if !terms.key?(key)
      terms[key] = build_wildcards(terms[key])
    end
    
    where_query = ""
    where_query += " and upper(pp.change_group_id) like :change_group_id" if terms[:change_group_id] != '%'
    where_query += " and upper(pp.name) like :price_plan_name" if terms[:price_plan_name] != '%'
    where_query += " and upper(pro.name) like :price_plan_supplier_name" if terms[:price_plan_supplier_name] != '%'
    where_query += " and upper(pp.test_mode_ind) like :test_mode" if terms[:test_mode] != '%'
    where_query += " and upper(s.name) like :price_plan_service_name" if terms[:price_plan_service_name] != '%'
    where_query += " and upper(s.service_code) like :price_plan_service_code" if terms[:price_plan_service_code] != '%'
    where_query += " and upper(tma.tariff_model_area_code) like :price_plan_tma_code" if terms[:price_plan_tma_code] != '%'
    
    select("pp.price_plan_code, pp.name, pp.effective_status, pp.effective_date, pro.name as product_name,
            pp.discontinue_indicator, pp.global_indicator, pp.promotion_ind, pp.test_mode_ind,
            pp.descriptive_text, pp.price_plan_version_id")
    .from("price_plan pp
            left outer join provider pro
              on pp.provider_code = pro.provider_code
            left outer join price_plan_service pps
              on pp.price_plan_version_id = pps.price_plan_version_id
            left outer join service s
              on pps.service_code = s.service_code
            left outer join algorithm_selection_rule asr
              on pp.price_plan_version_id = asr.price_plan_version_id
            left outer join process_step p
              on asr.algorithm_id = p.algorithm_id
            left outer join tariff_model_area tma
              on p.tariff_model_area_code = tma.tariff_model_area_code")
    .where("upper(pp.price_plan_code) like :price_plan_code" + where_query, terms)
    .group("pp.price_plan_code, pp.name, pp.effective_status, pp.effective_date, pro.name,
            pp.discontinue_indicator, pp.global_indicator, pp.promotion_ind, pp.test_mode_ind,
            pp.descriptive_text, pp.price_plan_version_id")
  end
  
  def provider
    Provider.find(self.provider_code)
  end
  
  def selection_rule_tree
    AlgorithmSelectionRule.tree(self.root_selection_rule_id)
  end
  
  def root_rule
    AlgorithmSelectionRule.get_rule_info(self.root_selection_rule_id)
  end

  def services
    Service.for_price_plan_version(self.price_plan_version_id)
  end
  
  def options
    PricePlanOption.for_price_plan_version(self.price_plan_version_id)
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
  
  def late_usage_description
    GeneralCodeItem.where(
      group_code: "LATE_USAGE",
      value:  self.separate_late_usage_ind
    ).pluck(
      :short_description
    ).first
  end
  
  protected
    # Called before create (insert), only sets the default value
    # if it has not already been set. 
    def default_values
      ttime = DateTime.now
      self.effective_date ||= ttime.to_date 
      self.effective_status ||= "DRAFT"
      
      # Create a unique ID
      unique = Time.now.to_f.to_s.gsub('.','').to_i.to_s(36)
      unique += Random.rand("9".ljust(20-unique.length,"9").to_i).to_s.ljust(20-unique.length, "0")
      self.price_plan_version_id ||= unique
      
      # Default values
      self.audit_update_user_id ||= 'tromanow'
      self.audit_update_date_time ||= ttime.to_date
      self.update_number ||= 1
      self.max_selected_destinations_val ||= 4
      self.minimum_charge_indicator ||= "N"
      self.summarize_indicator ||= "N"
      self.plan_period_indicator ||= "N"
      self.comment_id ||= self.price_plan_version_id
      self.contributing_item_indicator ||= "N"
      self.discontinue_indicator ||= "N"
      self.separate_late_usage_ind ||= "N"
      self.account_discount_indicator ||= "N"
      self.global_indicator ||= "N"
      self.test_mode_ind ||= "N"
      self.promotion_ind ||= "N"
    end
    
    def self.build_wildcards(term)
      "%#{term}%".gsub(/\*+/,'%').gsub(/%+/,'%').upcase
    end
end
