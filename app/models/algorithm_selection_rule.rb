class AlgorithmSelectionRule < ActiveRecord::Base
  self.table_name = :algorithm_selection_rule
  self.primary_key = :selection_rule_id

  #has_many :selection_rule_conditions
  #belongs_to :price_plan
  #accepts_nested_attributes_for :selection_rule_conditions

  def self.tree(root_rule)
    AlgorithmSelectionRule.find_by_sql("SELECT unique asr.*, src.*, a.*, src.name as condition_name, a.name as algorithm_name,
            src.descriptive_text as condition_description, a.descriptive_text as algorithm_description
            FROM algorithm_selection_rule asr
               left outer join selection_rule_condition src
                 on asr.condition_id = src.condition_id
               left outer join algorithm a
                 on asr.algorithm_id = a.algorithm_id
               START WITH asr.selection_rule_id = '#{root_rule}'
                 connect by asr.selection_rule_id in (prior asr.false_rule_id, prior asr.true_rule_id)")
  end

  def self.get_rule_info(rule_id)
    select("asr.*, src.*, a.*, src.name as condition_name, a.name as algorithm_name,
            src.descriptive_text as condition_description, a.descriptive_text as algorithm_description")
    .from("algorithm_selection_rule asr
           left outer join selection_rule_condition src
             on asr.condition_id = src.condition_id
           left outer join algorithm a
             on asr.algorithm_id = a.algorithm_id")
    .where("asr.selection_rule_id = :rule_id", {:rule_id => rule_id}).first
  end

  def process_steps
    ProcessStep.for_selection_rule(algorithm_id)
  end
  
  def condition_details
    SelectionRuleCondition.for_condition_id(condition_id)
  end

  def name
    self.condition_name || self.algorithm_name
  end
  
  def description
    self.condition_description || self.algorithm_description
  end
end
