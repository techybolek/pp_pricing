class Sensitivity < ActiveRecord::Base
  self.table_name = :sensitivity
  self.primary_key = :sensitivity_code
  
  def code_and_name
    "#{self.sensitivity_code} - #{self.name}"
  end
end
