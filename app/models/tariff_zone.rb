class TariffZone < ActiveRecord::Base
  self.table_name = :tariff_zone
  self.primary_key = :tariff_zone_version_id
  
  def self.search(terms = {})
    terms.each do |key, term|
      terms[key] = build_wildcards(term)
    end
    
    where_query = "" 
    where_query += " and upper(tz.change_group_id) like :change_group_id" if terms[:change_group_id] != '%'
    
    select("tz.tariff_zone_code, tz.name, tz.descriptive_text, tz.tariff_zone_version_id, tz.test_mode_ind")
    .from("tariff_zone tz
            join zonal_component zc
              on tz.tariff_zone_version_id = zc.tariff_zone_version_id
            join tariff_model_entry tme
              on tz.tariff_zone_code = tme.tariff_zone_code
            join tariff_model_area tma
              on tme.tariff_model_area_version_id = tma.tariff_model_area_version_id")
    .where("upper(tz.tariff_zone_code) like :tariff_zone_code
            and upper(TO_CHAR(tz.effective_date, 'MM-DD-YYYY')) like :effective_date
            and upper(zc.originating_point) like :originating_point
            and upper(zc.terminating_point) like :terminating_point
            and upper(tma.tariff_model_area_code) like :tariff_model_area_code
            and upper(tma.name) like :tariff_model_area_name
            and upper(tz.test_mode_ind) like :test_mode" + where_query, terms)
    .group("tz.tariff_zone_code, tz.name, tz.descriptive_text, tz.tariff_zone_version_id, tz.test_mode_ind")
  end
  
  def self.for_zonal_coverage(zonal_coverage_code)
    select("tz.tariff_zone_code, tz.name, tz.tariff_zone_version_id, tz.descriptive_text")
    .from("zonal_coverage zc
            join zonal_coverage_tariff_zone zctz
              on zc.zonal_coverage_code = zctz.zonal_coverage_code
            join tariff_zone tz
              on zctz.tariff_zone_code = tz.tariff_zone_code")
    .where("zc.zonal_coverage_code = :zonal_coverage_code
             and effective_date = (select max(effective_date)
                                  from tariff_zone
                                    where tariff_zone_code = tz.tariff_zone_code
                                      and effective_status = 'ACTIVE')", {:zonal_coverage_code => zonal_coverage_code})
    .order("tz.tariff_zone_code asc")
  end
  
  def zonal_components
    ZonalComponent.for_tariff_zone(tariff_zone_code)
  end
  
  def test_mode_word
    if(test_mode_ind == 'Y')
      'Yes'
    elsif(test_mode_ind == 'N')
      'No'
    else
      'Other'
    end
  end
  
protected
    def self.build_wildcards(term)
      "%#{term}%".gsub(/\*+/,'%').gsub(/%+/,'%').upcase
    end
end