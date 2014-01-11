class Rate < ActiveRecord::Base
  self.primary_key = :rate_id
  before_create :default_values
  attr_accessible :rate_code, :control_type, :group_code, :data_type,
                  :min_charge_applies, :precision, :rtti_path, :translation_code,
                  :billing_code, :width, :default_allowed, :criteria, :evaluation_order,
                  :multi_selection_allowed, :rate_type, :title
  
  validates :rate_code, :presence => true, :length => { :maximum => 10 }
  validates :data_type, :inclusion => { :in => ["String", "Decimal", "Integer", "Boolean", "DateTime"] }, :if => lambda { |rate| rate.group_code.nil? || rate.group_code.empty? }
  validates :rtti_path, :presence => true, :length => { :maximum => 100 }
  validates :title, :presence => true, :length => { :maximum => 50 }
  validates :evaluation_order, :inclusion => { :in => ["Ascending", "Descending"] }
  
  def self.determinants
    where(:rate_type => "determinant")
  end

  def self.not_in(template)
    where(:rate_id.eq(TemplateDefinition.arel_table))
  end
  
  def self.results
    where(:rate_type => "result")
  end
  
  def self.for_template(template_id)
    joins("join template_definitions on template_definitions.rate_id = rates.rate_id")
    .where("template_id = :template_id",{
      :template_id => template_id
    })
    .order("column_position ASC")
  end
  
  def self.search(rate_code, rate_name, group_code, rate_type)
      where("upper(rate_code) like :rate_code
             and upper(title) like :rate_name
             and NVL(upper(group_code), ' ') like :group_code
             and rate_type = :rate_type",{ 
                :rate_code => search_term(rate_code),
                :rate_name => search_term(rate_name),
                :group_code => search_term(group_code),
                :rate_type => rate_type
       })
  end
  
  def group_codes
    GeneralCodeGroup.pluck(:group_code)
  end
  
  def group_code=(group_code)
    write_attribute(:group_code, group_code) if group_code != ""
  end
  
  def select_options
    GeneralCodeItem.where(:group_code => self.group_code).uniq.pluck(:short_description)
  end
  
  protected
    def self.search_term(term)
      "%#{term}%".gsub(/\*+/,'%').gsub(/%+/,'%').upcase
    end
    
    # Called before create (insert), only sets the default value
    # if it has not already been set. 
    def default_values
      # Set type as determinant
      self.rtti_path ||= "type.title"
      
      # If group code is selected, it will default to string
      self.data_type ||= "String"
      
      # Create a unique ID
      unique = Time.now.to_f.to_s.gsub('.','').to_i.to_s(36)
      unique += Random.rand("9".ljust(20-unique.length,"9").to_i).to_s.ljust(20-unique.length, "0")
      self.rate_id ||= unique
    end
end
