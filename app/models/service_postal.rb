class ServicePostal < ActiveRecord::Base
  self.table_name = :service_postal
  
  def self.for_service(service_code, version_code)
    where(service_code: service_code, service_version_code: version_code)
  end
end