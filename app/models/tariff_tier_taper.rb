class TariffTierTaper < ActiveRecord::Base
  self.table_name = :tariff_tier_taper
  self.primary_key = :tariff_tier_taper_version_id
  
  def self.search(terms = {})
    terms.each do |key, term|
      terms[key] = build_wildcards(term)
    end
    
    if(terms[:change_group_id] != '%')
      change_group_id = " and upper(ttt.change_group_id) like :change_group_id"
    else
      change_group_id = ""
    end
    
    select("ttt.tariff_tier_taper_code, ttt.name, ttt.effective_date, ttt.test_mode_ind, ttt.descriptive_text, ttt.tariff_tier_taper_version_id")
    .from("tariff_tier_taper ttt
            left outer join tariff_model_area tma
              on tma.tariff_tier_taper_code = ttt.tariff_tier_taper_code
                 and upper(NVL(tma.tariff_model_area_code, '')) like #{sanitize(terms[:tariff_model_area_code])}
                 and upper(NVL(tma.name, '')) like #{sanitize(terms[:tariff_model_area_name])}")
    .where("upper(ttt.tariff_tier_taper_code) like :tariff_tier_taper_code
            and upper(ttt.name) like :tariff_tier_taper_name
            and upper(ttt.test_mode_ind) like :test_mode_ind" + change_group_id, terms)
    .group("ttt.tariff_tier_taper_code, ttt.name, ttt.effective_date, ttt.test_mode_ind, ttt.descriptive_text, ttt.tariff_tier_taper_version_id")
  end
  
  def bands
    Band.where(:tariff_tier_taper_version_id => tariff_tier_taper_version_id)
  end
  
  def test_mode_word
    if(test_mode_ind == 'Y')
      'Yes'
    elsif(test_mode_ind == 'N')
      'No'
    else
      test_mode_ind
    end
  end
  
  def code_and_name
    "#{self.tariff_tier_taper_code} - #{self.name}"
  end
  
  protected
    def self.build_wildcards(term)
      "%#{term}%".gsub(/\*+/,'%').gsub(/%+/,'%').upcase
    end
end