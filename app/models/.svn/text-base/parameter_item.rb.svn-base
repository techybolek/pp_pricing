class ParameterItem < ActiveRecord::Base
  self.table_name = :parameter_item
  
  def self.adjunct_mode?
    adjunct = where(
      group_code: 'INST_APPLN'
    ).order(
      "effective_date desc"
    ).pluck(
      "upper(value)"
    ).first
    
    return adjunct == 'ADJUNCT'
  end

end
