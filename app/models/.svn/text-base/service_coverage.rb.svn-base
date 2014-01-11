class ServiceCoverage < ActiveRecord::Base
  self.table_name = :service_coverage
  self.primary_key = :service_coverage_code
  
  
  def code_and_name
    "#{self.service_coverage_code} - #{self.name}"
  end
end
