class TariffModelEntry < ActiveRecord::Base
  self.table_name = :tariff_model_entry
  self.primary_key = :tariff_model_entry_id

  before_create :default_values
  attr_accessible :tariff_model_area_version_id, :rate, :zonal_coverage, :tariff_week, :sensitivity,
                :band_min, :band_max, :service_group, :tariff_model_entry_id, :calculation_id,
                :billing_name_1, :billing_name_2, :audit_update_user_id, :sdc_code,
                :service_group_code, :tariff_time_code, :tariff_zone_code, :band_sequence,
                :grid_row_number

  validates :audit_update_user_id, :presence => true, :length => { :maximum => 15 }
  validates :tariff_model_area_version_id, :presence => true, :length => { :maximum => 16 }
  validates :billing_name_1, :length => { :maximum => 60 }
  validates :billing_name_2, :length => { :maximum => 60 }
  validates :sdc_code, :length => { :maximum => 5 }
  validates :service_group_code, :length => { :maximum => 5 }
  validates :tariff_time_code, :length => { :maximum => 5 }
  validates :tariff_zone_code, :length => { :maximum => 5 }

  # This is used to set the attributes that are not actaully on the TME table.
  # It is needed for creating a virtual TME. See: http://stackoverflow.com/q/19014340/912563
  # examples: band_max, service_group, tariff_week, etc. 
  def set_virtual_attrib(key, value)
    write_attribute(key, value)
  end

  def self.for_tma(tma_version_id)
    select("tme.tariff_model_entry_id, tz.name zonal_coverage,
            tt.name tariff_week, sdc.name sensitivity,
            b.min_value band_min, b.max_value band_max, sg.name service_group,
            tme.tariff_model_entry_id, tme.tariff_model_area_version_id,
            tma.calculation_id, tme.tariff_zone_code, tme.sdc_code, tme.tariff_time_code,
            tme.service_group_code, tme.band_sequence, tme.billing_name_1")
    .from("tariff_model_entry tme
          left outer join tariff_model_area tma
            on tme.tariff_model_area_version_id = tma.tariff_model_area_version_id
          left outer join tariff_zone tz
            on tme.tariff_zone_code = tz.tariff_zone_code
          left outer join tariff_time tt
            on tme.tariff_time_code = tt.tariff_time_code
          left outer join sensitivity s
            on tma.sensitivity_code = s.sensitivity_code  
          left outer join sensitivity_domain_condition sdc
            on (tme.sdc_code = sdc.condition_code
                and s.sensitivity_version_id = sdc.sensitivity_version_id)
          left outer join service_group sg
            on tme.service_group_code = sg.service_group_code
          left outer join tariff_tier_taper ttt
            on tma.tariff_tier_taper_code = ttt.tariff_tier_taper_code
            and ttt.effective_status = 'ACTIVE'
          left outer join band b
            on (b.band_sequence = tme.band_sequence
                and ttt.tariff_tier_taper_version_id = b.tariff_tier_taper_version_id)")
    .where("tma.tariff_model_area_version_id = :tma_version_id
            and (ttt.effective_date is null
                 OR
                 ttt.effective_date = (select max(effective_date)
                          from tariff_tier_taper
                          where tariff_tier_taper_code = ttt.tariff_tier_taper_code))
            and (s.effective_date is null
                 OR
                 s.effective_date = (select max(effective_date)
                  from sensitivity
                  where sensitivity_code = tma.sensitivity_code
                    and effective_status = 'ACTIVE'))",{
      :tma_version_id => tma_version_id
    })
    .order("tme.grid_row_number")
  end

  def calculation_options
    if is_generated?
      CalculationOption.for_generated_tme(self[:calculation_id])
    else
      CalculationOption.for_existing_tme(self[:tariff_model_area_version_id],
                                         self[:tariff_model_entry_id],
                                         self[:calculation_id])
    end
  end
  
  def is_generated?
    self.tariff_model_entry_id.nil?
  end

  private
    def default_values
      self.audit_update_date_time = DateTime.now
      self.update_number ||= 1
      self.grid_row_number ||= 0
      unique = Time.now.to_f.to_s.gsub('.','').to_i.to_s(36)
      unique += Random.rand("9".ljust(16-unique.length,"9").to_i).to_s.ljust(16-unique.length, "0")
      self.tariff_model_entry_id = unique
    end
end
