class Template < ActiveRecord::Base
  self.table_name = :templates
  self.primary_key = :template_id
  
  before_create :default_values
  has_many :template_definitions, :primary_key=>:template_id
  attr_accessible :template_name, :effective_status, :template_code, :effective_date
  
  validates :template_code, :presence => true, :length => { :maximum => 10 }
  validates :template_name, :presence => true, :length => { :maximum => 20 }
  
  def self.get(id)
    where("template_id = :id
           and effective_date =
             (select max(effective_date)
               from templates
               where template_id = :id)",{
        :id => id           
    }).first
  end

  def self.search(template_name, template_code)
      where("upper(template_name) like :template_name
             and upper(template_code) like :template_code", {
          :template_name => search_term(template_name),
          :template_code => search_term(template_code)
      })
  end
  
  def approve
    update_attributes(:effective_status => "ACTIVE")
  end

  
  def self.active
    where("effective_status = 'ACTIVE'")
  end
  
  def self.newest_active
    where("effective_date =
              (select max(effective_date)
                 from #{table_name} t
                 where t.template_id = #{table_name}.template_id
                 and effective_status = 'ACTIVE')").first
  end
  
  protected
    
    def self.search_term(term)
      "%#{term}%".gsub(/\*+/,'%').gsub(/%+/,'%').upcase
    end
    
    # Called before create (insert), only sets the default value
    # if it has not already been set. 
    def default_values
	   ttime = DateTime.now
      self.effective_date ||= ttime.to_date 
      self.effective_status ||= "DRAFT"
      
      # Create a unique ID
      unique = Time.now.to_f.to_s.gsub('.','').to_i.to_s(36)
      unique += Random.rand("9".ljust(20-unique.length,"9").to_i).to_s.ljust(20-unique.length, "0")
      self.template_id ||= unique
    end
end
