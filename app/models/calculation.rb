class Calculation < ActiveRecord::Base
  self.table_name = :calculation
  self.primary_key = :calculation_id


  def self.getOptions(calcid, tmaid, otype)
    select("distinct co.calculation_option_name as name, co.descriptive_text as description, cov.calculation_option_value as value").from("calculation_option co, calculation_option_value cov").
    where("co.calculation_id = :cid and co.calculation_option_id = cov.calculation_option_id
      and cov.tariff_model_area_version_id = :tmaid
      and co.option_level_indicator = :oind", { :cid => calcid, :tmaid => tmaid, :oind => otype })
  end

  def self.getOptionNames(type, calculation_id)
    select("calculation_option_name, calculation_option_id").from("calculation_option co").
      where("co.calculation_id = :cid and co.option_level_indicator = :ind", { :cid => calculation_id, :ind => type })
  end


  def self.getValue(tmeid, calc_id, calc_option_id)
    logger.debug("getvalue #{tmeid} #{calc_id} #{calc_option_id}")
    recs = select("cov.calculation_option_value").from("calculation_option_value cov").
    where("parent_id = :tmeid and calculation_id = :calc_id and calculation_option_id = :calc_option_id",
      { :tmeid => tmeid, :calc_id => calc_id, :calc_option_id => calc_option_id })
    logger.debug("records: #{recs}")
    logger.debug(recs.inspect)
    recs.each do |r|
      return r.calculation_option_value
    end
    return "no option value"
  end
end
