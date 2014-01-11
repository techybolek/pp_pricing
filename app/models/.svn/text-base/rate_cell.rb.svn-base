class RateCell < ActiveRecord::Base
  self.primary_key = :rate_cell_id
  before_create :default_values
  belongs_to :rate_rows, :primary_key => :rate_row_id
  belongs_to :rates, :primary_key => :rate_id
  
  attr_accessible :value
  
  validates :value, :length => { :maximum => 60 }
  validates :rate_id, :presence => true
  validates :rate_row_id, :presence => true
  validate :validate_nullable
  validate :validate_type
  
  def validate_nullable
    if self.value.nil? || self.value.empty?
      rate = Rate.find(self.rate_id)
      errors.add(rate.title, "Is a required field") unless rate.nullable
    end
  end
  
  def validate_type
    rate = Rate.find(self.rate_id)
    case rate.data_type
    when "String"
      errors.add(rate.title, "Not a valid string") unless self.value.respond_to?(:to_s)
    when "Decimal"
      errors.add(rate.title, "Not a valid decimal") unless self.value.to_f.to_s =~ /^\d+\.\d+$/
    when "Integer"
      errors.add(rate.title, "Not a valid integer") unless self.value.to_i.to_s =~ /^\d+$/
    when "Boolean"
      errors.add(rate.title, "Not a valid integer") unless self.value.to_lower == "false" ||
                                                           self.value.to_lower == "true"
    when "DateTime"
      begin
        # Expects format '26-08-1986' - %d-%m-%Y
        DateTime.parse(self.value)
      rescue ArgumentError => e
        errors.add(rate.title, "Not a valid DateTime")
      end
    else
      logger.error "No data-type validation to run for data-type:#{rate.data_type}"
    end
  end
  
  def position(template_id)
    TemplateDefinitions.pluck(:column_position).where(:rate_id => self.rate_id, :template_id => self.template_id)
  end
  
  def group_code_description(group_code)
    GeneralCodeItem.where(:group_code => group_code, :value => value).pluck(:short_description).first
  end
  
  protected
    # Called before create (insert), only sets the default value
    # if it has not already been set. 
    def default_values
      # Create a unique ID
      unique = Time.now.to_f.to_s.gsub('.','').to_i.to_s(36)
      unique += Random.rand("9".ljust(20-unique.length,"9").to_i).to_s.ljust(20-unique.length, "0")
      self.rate_cell_id ||= unique
    end
end
