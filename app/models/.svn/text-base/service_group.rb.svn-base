class ServiceGroup < ActiveRecord::Base
  self.table_name = :service_group
  
  def self.for_service_coverage(service_coverage_code)
    select("service_group.*")
      .joins("left outer join service_coverage_service_group scsg
                on service_group.service_group_code = scsg.service_group_code")
      .where("scsg.service_coverage_code = :service_coverage_code
              and service_group.effective_date =
                (select max(effective_date)
                  from service_group
                  where service_group_code = :service_coverage_code
                    and effective_status = 'ACTIVE')",{
           :service_coverage_code => service_coverage_code
       })
  end
  
  def range_words(low, high)
    if low == 0
      words = "Less than or = #{high}"
    elsif high == 0
      words = "Greater than #{low}"
    else
      words = "Greater than #{low} & Less than or = #{high}"
    end
    return words.html_safe
  end
end