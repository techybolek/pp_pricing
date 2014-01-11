class TariffTime < ActiveRecord::Base
  self.table_name = :tariff_time
  
  def self.for_tariff_week(tariff_week_code)
    select("tariff_time.*")
      .joins("left outer join tariff_week
                on tariff_time.tariff_week_version_id = tariff_week.tariff_week_version_id")
      .where("tariff_week.tariff_week_code = :tariff_week_code
              and tariff_week.effective_date =
                (select max(effective_date)
                  from tariff_week
                  where tariff_week_code = :tariff_week_code
                    and effective_status = 'ACTIVE')",{
           :tariff_week_code => tariff_week_code
       })
  end
end