class SensitivityDomainCondition < ActiveRecord::Base
  self.table_name = :sensitivity_domain_condition
  self.primary_key = :condition_id
  
  def self.for_sensitivity(sensitivity_code)
    select("sensitivity_domain_condition.*")
      .joins("left outer join sensitivity
                on sensitivity_domain_condition.sensitivity_version_id = sensitivity.sensitivity_version_id")
      .where("sensitivity.sensitivity_code = :sensitivity_code
              and sensitivity.effective_date =
                (select max(effective_date)
                  from sensitivity
                  where sensitivity_code = :sensitivity_code
                    and effective_status = 'ACTIVE')",{
           :sensitivity_code => sensitivity_code
       })
  end
end