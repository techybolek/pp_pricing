class ServiceJournalization < ActiveRecord::Base
  self.table_name = :service_journalization
  
  def self.for_service(service_code, service_version)
    where(
      service_code: service_code,
      service_version_code: service_version
    )
  end
end