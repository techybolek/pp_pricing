#require 'composite_primary_keys'
class CalculationOption < ActiveRecord::Base
  self.table_name = :calculation_option
  #self.primary_key = :  #self.primary_key = :calculation_option_id
  
  def self.for_tma(tma_version, calculation_id)
    select("*")
    .joins("left outer join calculation_option_value cov
             on calculation_option.calculation_option_id = cov.calculation_option_id")
    .where("(calculation_option.option_level_indicator= 'P' or calculation_option.option_level_indicator= 'I' or calculation_option.option_level_indicator= 'E')
            and calculation_option.calculation_id = :calculation_id
            and cov.tariff_model_area_version_id = :tma_version
            and parent_id = :tma_version",{
               :tma_version => tma_version,
               :calculation_id => calculation_id
    })
    .order("calculation_option.calculation_option_id ASC")
  end
  
  def self.for_calculation(calculation_id)
    where("(option_level_indicator= 'P' or option_level_indicator= 'I' or option_level_indicator= 'E')
            and calculation_id = :calculation_id",{
               :calculation_id => calculation_id
    })
    .order("calculation_option_id ASC")
  end
  
  def self.for_generated_tme(calculation_id)
    where(:calculation_id => calculation_id, :option_level_indicator => 'T').order('calculation_option_id ASC')
  end
  
  def self.for_existing_tme(tma_version, tme_id, calculation_id)
    select("calculation_option.*, cov.parent_id, cov.calculation_option_value, cov.tariff_model_area_version_id")
    .joins("left outer join calculation_option_value cov
             on calculation_option.calculation_option_id = cov.calculation_option_id")
    .where("calculation_option.calculation_id = :calculation_id
            and calculation_option.option_level_indicator = 'T'
            and cov.tariff_model_area_version_id = :tma_version
            and cov.parent_id = :tme_id",{
              :calculation_id => calculation_id,
              :tma_version => tma_version,
              :tme_id => tme_id
    })
    .order("calculation_option.calculation_option_id ASC")
  end
  
  def value_or_default
    if respond_to?(:calculation_option_value)
      return self.calculation_option_value
    else
      return default_value
    end
  end
  
  private
    def default_value
      if field_type == "A"
        return self.default_rtti_path
      else
        return 0
      end
    end
end
