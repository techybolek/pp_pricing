class ServiceCharacteristicValue < ActiveRecord::Base
  self.table_name = :service_characteristic_value
  
  def self.for_service(service_code, service_version)
    select(
      "service_characteristic_value.*, service_characteristic.name,
      service_characteristic.datatype_value, service_characteristic.descriptive_text"
    ).joins(
    "join service_characteristic
      on service_characteristic_value.service_char_code = service_characteristic.service_char_code"
    ).where(
      service_code: service_code, service_version_code: service_version
    )
  end
end
