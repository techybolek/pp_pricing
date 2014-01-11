class Algorithm < ActiveRecord::Base
  self.table_name = :algorithm
  self.primary_key = :algorithm_id

  before_create :default_values
  attr_accessible :name, :descriptive_text, :billing_name_1, :billing_name_2

  validates :condition_name, :presence => true, :length => { :maximum => 16 }
  validates :condition_text, :presence => true, :length => { :maximum => 512 }
  validates :description, :presence => true, :length => { :maximum => 60 }


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
