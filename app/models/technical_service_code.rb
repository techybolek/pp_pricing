class TechnicalServiceCode < ActiveRecord::Base
  self.table_name = "technical_service_code"
  
  def self.for_select_box
    select(
      "unique technical_service_code_name,
      technical_service_description"
    ).order("technical_service_description")
  end
end