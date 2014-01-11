class TariffModelArea < ActiveRecord::Base
  self.table_name = :tariff_model_area
  self.primary_key = :tariff_model_area_version_id

  set_boolean_columns :test_mode_ind, :customizable_indicator, :rate_plan_indicator, :true => "Y", :false => "N"
  set_date_columns :effective_date

  before_create :default_values
  attr_accessible :tariff_model_area_code, :descriptive_text, :effective_status,
                  :effective_date, :rate_table_id, :calculation_id, :test_mode_ind,
                  :measure_unit_code, :tma_option_group_id, :rate_plan_indicator, :name,
                  :zonal_coverage_code, :tariff_week_code, :service_coverage_code,
                  :sensitivity_code, :tariff_tier_taper_code, :tma_option_group_id,
                  :tariff_model_area_version_id

  validates :descriptive_text, :length => { :maximum => 360 }
  validates :tariff_model_area_code, :presence => true, :length => { :maximum => 5 }
  validates :name, :presence => true, :length => { :maximum => 30 }
  validates :calculation_id, :presence => true, :numericality => true
  validates :effective_status, :presence => true
  validates :effective_date, :presence => true

  # Validations only for Create
  validates :tariff_model_area_code, :uniqueness => true, :on => :create
  validates :name, :uniqueness => true, :on => :create

  def self.search(terms = {})
    # Wildcard all search terms
    terms.each { |key, value| terms[key] = wildcard(value) }
    
    select("tariff_model_area.*, ca.calculation_name, mu.name as measure_unit_name")
      .joins("left outer join measure_unit mu
                on tariff_model_area.measure_unit_code = mu.measure_unit_code
              left outer join calculation ca
                on tariff_model_area.calculation_id = ca.calculation_id")
      .where("upper(tariff_model_area.name) like :tma_name
              and upper(NVL(tariff_model_area.tariff_model_area_code, ' ')) like :tma_code 
              and upper(NVL(tariff_model_area.measure_unit_code, ' ')) like :measure_unit
              and upper(NVL(tariff_model_area.calculation_id, ' ')) like :calculation_id
              and upper(NVL(test_mode_ind, ' ')) like :test_mode
              and upper(NVL(tariff_model_area.rate_plan_indicator, ' ')) like :rate_plan
              and upper(NVL(change_group_id, ' ')) like :change_group", terms)
  end

  def tma_calculation_options
    if self.tariff_model_area_version_id.nil? ||
         self.tariff_model_area_version_id.empty? ||
         self.calculation_id_changed?
      # TMA doesn't exist yet, or changed, just get the defaults
      CalculationOption.for_calculation(self.calculation_id)
    else
      # TMA exists, get the actaul values
      CalculationOption.for_tma(self.tariff_model_area_version_id, self.calculation_id)
    end
  end

  def tme_calculation_options
    if is_generated_tmes?
      CalculationOption.for_generated_tme(self.calculation_id)
    else
      raise NotImplementedError.new("Calculation options for existing TMEs should be retrieved from the TME object")
    end
  end

  def tmes
    if is_generated_tmes?
      # TMA doesn't exist yet, generate would-be TMEs
      generate_tmes
    else
      # TMA exists, get actaul TMEs
      TariffModelEntry.for_tma(self.tariff_model_area_version_id)
    end
  end

  def is_generated_tmes?
    self.tariff_model_area_version_id.nil? ||
    self.tariff_model_area_version_id.empty? ||
    self.calculation_id_changed? ||
    self.zonal_coverage_code_changed? ||
    self.service_coverage_code_changed? ||
    self.tariff_week_code_changed? ||
    self.sensitivity_code_changed? ||
    self.tariff_tier_taper_code_changed? ||
    self.rate_table_id_changed?
  end

  protected

    def default_values
      # Create a unique ID
      unique = Time.now.to_f.to_s.gsub('.','').to_i.to_s(36)
      unique += Random.rand("9".ljust(16-unique.length,"9").to_i).to_s.ljust(16-unique.length, "0")
      self.tariff_model_area_version_id ||= unique
      self.tariff_model_area_version_id = unique if self.tariff_model_area_version_id.empty?
      
      self.customizable_indicator ||= false
      self.audit_update_date_time = DateTime.now
      self.update_number ||= 1
    end
    
    def self.wildcard(term)
      return "#{term}%".gsub(/\*+/,'%').gsub(/%+/,'%').upcase
    end
    
    def generate_tmes
      sensitivities = []
      
      # Get Tariff Zones
      if zonal_coverage_code && !zonal_coverage_code.empty?
        tariff_zones = TariffZone.for_zonal_coverage(zonal_coverage_code)
        sensitivities << tariff_zones unless tariff_zones.empty?
      end
      
      # Get Tariff Times
      if tariff_week_code && !tariff_week_code.empty?
        tariff_times = TariffTime.for_tariff_week(tariff_week_code)
        sensitivities << tariff_times unless tariff_times.empty?
      end
      
      # Get Sensitivity Domain Conditions
      if sensitivity_code && !sensitivity_code.empty?
        sensitivity_conditions = SensitivityDomainCondition.for_sensitivity(sensitivity_code)
        sensitivities << sensitivity_conditions unless sensitivity_conditions.empty?
      end
      
      # Get Bands
      if tariff_tier_taper_code && !tariff_tier_taper_code.empty?
        bands = Band.for_tariff_tier_taper(tariff_tier_taper_code)
        sensitivities << bands unless bands.empty?
      end
      
      # Get Service Groups
      if service_coverage_code && !service_coverage_code.empty?
        service_groups = ServiceGroup.for_service_coverage(service_coverage_code)
        sensitivities << service_groups unless service_groups.empty?
      end
      
      # Get all combinations of the sensitivities
      if sensitivities.length > 1
        sensitivities = sensitivities.first.product(*sensitivities.drop(1))
      end
      
      # Convert the 'sensitivities' into actual TME objects to make it easy on the view layer
      tmes = []
      sensitivities.each do |sensitivity_group|
        tme = TariffModelEntry.new
        tme.set_virtual_attrib(:tariff_model_area_version_id, self.tariff_model_area_version_id)
        tme.set_virtual_attrib(:calculation_id, self.calculation_id)
        tme.set_virtual_attrib(:rate, 0)
        
        sensitivity_group.each do |sensitivity|
          case sensitivity.class.to_s
          when "TariffZone"
            tme.set_virtual_attrib(:zonal_coverage, sensitivity.name)
            tme.tariff_zone_code = sensitivity.tariff_zone_code
          when "TariffTime"
            tme.set_virtual_attrib(:tariff_week, sensitivity.name)
            tme.tariff_time_code = sensitivity.tariff_time_code
          when "SensitivityDomainCondition"
            tme.set_virtual_attrib(:sensitivity, sensitivity.name)
            tme.sdc_code = sensitivity.condition_code
          when "Band"
            tme.set_virtual_attrib(:band_min, sensitivity.min_value)
            tme.set_virtual_attrib(:band_max, sensitivity.max_value)
            tme.band_sequence = sensitivity.band_sequence
          when "ServiceGroup"
            tme.set_virtual_attrib(:service_group, sensitivity.name)
            tme.service_group_code = sensitivity.service_group_code
          else
            logger.error("Unknown sensitivity [#{sensitivity.class}] type when generating TMEs.")
          end
        end
        
        tmes << tme
      end
      
      return tmes
    end
end
