class ProcessStep < ActiveRecord::Base
  require 'securerandom'
  self.table_name = :process_step
  self.primary_key = :process_step_id

  before_create :default_values
  attr_accessible :name, :descriptive_text, :billing_name_1, :billing_name_2
  
  def self.for_selection_rule(algorithm_id)
    select("ps.*, c.*, tma.*, tma.name as tariff_model_area_name, c.descriptive_text as calculation_descriptive_text, tma.descriptive_text as tma_descriptive_text")
    .from("process_step ps
             join calculation c
               on ps.calculation_id = c.calculation_id
             join tariff_model_area tma
               on ps.tariff_model_area_code = tma.tariff_modeL_area_code")
    .where("tma.tariff_model_area_version_id =
              (select distinct tariff_model_area_version_id from tariff_model_area
                where tma.tariff_model_area_code = tariff_model_area_code
                  and effective_date =
                    (select max(effective_date) from tariff_model_area
                      where tariff_model_area_code = tma.tariff_model_area_code)
                  and ROWNUM <= 1)
               and ps.algorithm_id = :algorithm_id", {:algorithm_id => algorithm_id})
    .order(:process_step_order)
  end
  
  def self.for_selection_rules(algorithm_ids)
    select("ps.*, c.*, tma.*, tma.name as tariff_model_area_name, c.descriptive_text as calculation_descriptive_text, tma.descriptive_text as tma_descriptive_text")
    .from("process_step ps
             join calculation c
               on ps.calculation_id = c.calculation_id
             join tariff_model_area tma
               on ps.tariff_model_area_code = tma.tariff_modeL_area_code")
    .where("tma.tariff_model_area_version_id =
              (select distinct tariff_model_area_version_id from tariff_model_area
                where tma.tariff_model_area_code = tariff_model_area_code
                  and effective_date =
                    (select max(effective_date) from tariff_model_area
                      where tariff_model_area_code = tma.tariff_model_area_code)
                  and ROWNUM <= 1)
               and ps.algorithm_id in (:algorithm_ids)", {:algorithm_ids => algorithm_ids})
    .order(:process_step_order)
  end
  
  def attributes
    SummaryGroup.for_summary_group_id(summary_group_id)
  end
  
  def explicit_links
    ProcessStep.for_process_step(process_step_id)
  end
  
  def self.for_process_step(process_step_id)
    select("ps.process_step_order, a.name as algorithm_name, c.calculation_name, el.link_kind")
    .from("explicit_link el
             join process_step ps
               on el.dest_process_step_id = ps.process_step_id
             join calculation c
               on ps.calculation_id = c.calculation_id
             join algorithm a
               on ps.algorithm_id = a.algorithm_id")
    .where("el.source_process_step_id = :process_step_id", { :process_step_id => process_step_id })
  end

protected
    # Called before create (insert), only sets the default value
    # if it has not already been set. 
    def default_values
      # Create a unique ID
      unique = Time.now.to_f.to_s.gsub('.','').to_i.to_s(36)
      unique += Random.rand("9".ljust(16-unique.length,"9").to_i).to_s
      self.condition_id ||= unique
      
      # Handle other defaults
      self.update_number ||= 1
      self.audit_update_date_time = DateTime.now
      self.effective_status = 'ACTIVE'
      self.effective_date = DateTime.now
    end

end
