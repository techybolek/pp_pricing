class Band < ActiveRecord::Base
  self.table_name = :band
  
  def self.for_tariff_tier_taper(tariff_tier_taper_code)
    select("band.*")
      .joins("left outer join tariff_tier_taper
                on band.tariff_tier_taper_version_id = tariff_tier_taper.tariff_tier_taper_version_id")
      .where("tariff_tier_taper.tariff_tier_taper_code = :tariff_tier_taper_code
              and tariff_tier_taper.effective_date =
                (select max(effective_date)
                  from tariff_tier_taper
                  where tariff_tier_taper_code = :tariff_tier_taper_code
                    and effective_status = 'ACTIVE')",{
           :tariff_tier_taper_code => tariff_tier_taper_code
       }).order(:band_sequence)
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