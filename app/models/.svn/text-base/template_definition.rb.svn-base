class TemplateDefinition < ActiveRecord::Base
  self.primary_key = nil
  belongs_to :templates
  belongs_to :rate, :primary_key => :rate_id
  before_create :default_values
  default_scope order('column_position asc')
  attr_accessible :template_id, :rate_id, :column_position
  
  def number_of_columns
    TemplateDefinition.where(:template_id => self.template_id).count(:template_id)
  end

  def self.for_template(template_id)
    where(:template_id => template_id)
  end

  def self.for_rate(rate_id)
    where(:rate_id => rate_id)
  end
  
  protected
    # Called before create (insert), only sets the default value
    # if it has not already been set. 
    def default_values
      self.column_position = number_of_columns
    end
end
