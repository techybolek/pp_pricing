class TariffWeek < ActiveRecord::Base
  self.table_name = :tariff_week
  self.primary_key = :tariff_week_code
  
  def code_and_name
    "#{self.tariff_week_code} - #{self.name}"
  end
end
