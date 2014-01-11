class ServiceAssociation < ActiveRecord::Base
  self.table_name = :service_association
  
  def self.associations_for_service(service_code)
    find_by_sql(
      "select * from (
        (select sa.service_code, sa.associated_service_code, sa.excludes_indicator,
               sa.requires_indicator as is_required_indicator, sa.is_required_indicator as requires_indicator,
               sa.owns_indicator as is_owned_indicator, sa.is_owned_indicator as owns_indicator,
               s.descriptive_text, s.name, s.service_version_code
         from  service_association sa
           join service s
              on sa.service_code = s.service_code
                 and s.service_version_code =
                  ( select max(service_version_code) from service
                      where service.service_code = s.service_code)
         where sa.associated_service_code = #{sanitize(service_code)})
      union 
        (select sa.associated_service_code as service_code, sa.service_code as associated_service_code,  sa.excludes_indicator,
                sa.is_required_indicator, sa.requires_indicator,
                sa.is_owned_indicator, sa.owns_indicator,
                s.descriptive_text, s.name, s.service_version_code
         from  service_association sa
           join service s
            on sa.associated_service_code = s.service_code
               and s.service_version_code =
                ( select max(service_version_code) from service
                    where service.service_code = s.service_code)
         where sa.service_code = #{sanitize(service_code)})
    ) order by service_code asc")
  end
end
