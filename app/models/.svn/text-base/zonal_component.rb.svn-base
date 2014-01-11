class ZonalComponent < ActiveRecord::Base
  self.table_name = :zonal_component
  
  def self.for_tariff_zone(tariff_zone_code)
    select("zcom.originating_point, zcom.terminating_point")
    .from("tariff_zone tz
            join zonal_component zcom
              on tz.tariff_zone_version_id = zcom.tariff_zone_version_id")
    .where("tz.tariff_zone_code = :tariff_zone_code", {:tariff_zone_code => tariff_zone_code})
  end
end