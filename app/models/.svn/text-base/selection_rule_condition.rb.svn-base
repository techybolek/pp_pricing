class SelectionRuleCondition < ActiveRecord::Base
  require 'securerandom'
  require 'ostruct'
  self.table_name = :selection_rule_condition
  self.primary_key = :condition_id

  before_create :default_values
  attr_accessible :condition_name, :condition_text, :description
  #belongs_to :algorithm_selection_rule

  validates :condition_name, :presence => true, :length => { :maximum => 16 }
  validates :condition_text, :presence => true, :length => { :maximum => 512 }
  validates :description, :presence => true, :length => { :maximum => 60 }
  
  @event_details

  def self.for_condition_id(condition_id)
    find(condition_id)
  end
  
  def self.event_details(condition_id, condition_string)
    events = condition_string.scan(/\([^)]*\)|\S+\s+(?:==|!=|<>|<|>|<=|>=|is)\s+\S+/)
    self.parse_events(events, condition_id)
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
      self.audit_update_date_time ||= DateTime.now
      self.effective_status ||= 'ACTIVE'
      self.effective_date ||= DateTime.now
    end
    
    def self.parse_events(events, condition_id)
      event_details = []
      order_string = ""
      original_operator = select("cce.comparison_operator_value_rd")
                              .from("char_condition_expression cce")
                              .where("cce.sr_condition_id = :condition_id", {:condition_id => condition_id})
      if original_operator.size > 0
        original_operator = original_operator.first.comparison_operator_value_rd
      else
        original_operator = ""
      end
      events.each_with_index do |event, i|
        event_detail = OpenStruct.new
        event_detail.order = (i + 97).chr # set order
        logic_operator = select("co.operator_value_rd") # grab "and"/"or"
                             .from("condition_operator co")
                             .where("co.sr_condition_id = :condition_id", {:condition_id => condition_id}).first
        logic_operator = logic_operator.operator_value_rd unless logic_operator.nil?
        pieces = event.scan(/[\S]+/) # split event into pieces
        pieces[0] = pieces[0].gsub(/^\(/, '') # remove leading parentheses
        condition_expression = select("*") # table which is accessed for several attributes
                                   .from("priceable_characteristic pc")
                                   .where("pc.rtti_path = :path", {:path => pieces[0]}).first
        if !condition_expression.nil?
          event_detail.type = condition_expression.characteristic_type_value_rd # set type
          event_detail.name = condition_expression.name # set name
        else
          event_detail.type = '(unknown)'
          event_detail.name = pieces[0] # the proper name couldn't be found so use the rtti_path
        end
        operator = pieces[1]
        event_detail.operator = operator # set operator
        value_string = ""
        group_code = condition_expression.value_group_rd unless condition_expression.nil?
        
        # build order string
        if(i != 0)
          order_string += logic_operator unless logic_operator.nil?
          order_string += " "
        end
        order_string += event_detail.order + " "
        
        # build value string
        pieces.each_with_index do |item, j|
          position = j % 4
          if(position == 2) # parse value
            value = item
            value = value.gsub(/["\)]/, '')
            value = self.parse_value(value, group_code)
            value_string += value + ' '
          elsif(position == 3) # parse and/or
            if(operator != original_operator && item == "and")
              item = "or"
            elsif(operator != original_operator && item == "or")
              item = "and"
            end
            value_string += item + ' '
          end
        end
        event_detail.values = value_string # set value
        event_details << event_detail # add populated row
      end
      if event_details.size == 0 # If there were no events
        event_details << OpenStruct.new
      end
      event_details[0].order_string = order_string # set order string
      return event_details
    end
    
    def self.parse_value(value, group_code)
      group_item = GeneralCodeItem.where(:group_code => group_code, :value => value).first
      if group_item.nil?
        return value
      else
        value = group_item.description
        return value
      end
    end

end
