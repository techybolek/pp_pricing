class CalculationOptionValue < ActiveRecord::Base
  self.table_name = :calculation_option_value
  self.set_string_columns "option_level_indicator"
  self.primary_keys = :parent_id, :tariff_model_area_version_id, :calculation_option_id

  before_create :default_values
  attr_accessible :calculation_option_value, :calculation_id, :parent_id, :tariff_model_area_version_id,
                  :calculation_option_id,  :option_level_indicator, :audit_update_user_id, :grid_row_number,
                  :audit_update_user_id

  validates :parent_id, :presence => true
  validates :calculation_option_id, :presence => true
  validates :calculation_id, :presence => true
  validates :calculation_option_value, :length => { :maximum => 360 }
  validates :tariff_model_area_version_id, :presence => true
  validates :option_level_indicator, :presence => true
  validates :audit_update_user_id, :presence => true

protected

  def default_values
    self.update_number ||= 1
    self.audit_update_date_time = DateTime.now 
    self.grid_row_number ||= 0
    self.calculation_option_value ||= '0'
    self.calculation_option_value = '0' if self.calculation_option_value.to_s.empty?
  end
end
