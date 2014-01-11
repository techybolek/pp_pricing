class ServiceCharacteristic < ActiveRecord::Base
  self.table_name = :service_characteristic
  self.primary_key = :service_char_code
  set_string_columns :value_type_ind

  def default_characteristic_value
    CharacteristicValue.where(
      characteristic_value_id: self.def_char_value_id
    ).first
  end

  def characteristic_values
    CharacteristicValue.for_service_characteristic(self.service_char_code)
  end

  def self.search(terms = {})
    # Wildcard all search terms
    terms.each { |key, value| terms[key] = wildcard(value) }
    
    select(
      "service_characteristic.*, gci1.short_description as datatype_value_name,
      gci2.short_description as value_type_name"
    ).joins(
      "left outer join general_code_item gci1
        on gci1.group_code = 'DATATYPE'
        and service_characteristic.datatype_value = gci1.value
       left outer join general_code_item gci2
        on gci2.group_code = 'VALUE_TYPE'
        and service_characteristic.value_type_ind = gci2.value"
    ).where(
      "upper(service_characteristic.name) like :name
      and upper(service_characteristic.service_char_code) like :service_char_code
      and upper(service_characteristic.datatype_value) like :datatype_value", terms
    )
  end
  
  private
  
    def self.wildcard(term)
      return "%#{term}%".gsub(/\*+/,'%').gsub(/%+/,'%').upcase
    end
end