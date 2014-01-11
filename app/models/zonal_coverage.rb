class ZonalCoverage < ActiveRecord::Base
  self.table_name = :zonal_coverage
  self.primary_key = :zonal_coverage_code
  
  def self.search(terms = {})
    terms.each do |key, term|
      terms[key] = build_wildcards(term)
    end
    
    if(terms[:change_group_id] != '%')
      change_group_id = " and upper(zc.change_group_id) like :change_group_id"
    else
      change_group_id = ""
    end
    
    select("zc.zonal_coverage_code, zc.name, zc.test_mode_ind, zc.descriptive_text, zc.change_group_id")
    .from("zonal_coverage zc
            join tariff_model_area tma
              on tma.zonal_coverage_code = zc.zonal_coverage_code
            join zonal_coverage_tariff_zone zctz
              on zc.zonal_coverage_code = zctz.zonal_coverage_code")
    .where("upper(zc.zonal_coverage_code) like :zonal_coverage_code
            and upper(zc.name) like :zonal_coverage_name
            and upper(zctz.tariff_zone_code) like :tariff_zone_code
            and upper(tma.tariff_model_area_code) like :tariff_model_area_code
            and upper(tma.name) like :tariff_model_area_name
            and upper(zc.test_mode_ind) like :test_mode" + change_group_id, terms)
    .group("zc.zonal_coverage_code, zc.name, zc.test_mode_ind, zc.descriptive_text, zc.change_group_id")
  end
  
  def tariff_zones
    TariffZone.for_zonal_coverage(zonal_coverage_code)
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
  
  
  def code_and_name
    "#{self.zonal_coverage_code} - #{self.name}"
  end
  
protected
    def self.build_wildcards(term)
      "%#{term}%".gsub(/\*+/,'%').gsub(/%+/,'%').upcase
    end
end
