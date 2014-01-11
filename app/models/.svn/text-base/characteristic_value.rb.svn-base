class CharacteristicValue < ActiveRecord::Base
  self.table_name = :characteristic_value
  self.primary_key = :characteristic_value_id
  
  def measure_unit
    MeasureUnit.where(
      measure_unit_code: self.measure_unit_code
    ).first
  end
  
  def self.for_service_characteristic(service_char_code)
    where(
      service_char_code: service_char_code
    )
  end
end
