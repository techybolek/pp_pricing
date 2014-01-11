class RateTable < ActiveRecord::Base
  self.primary_key = :rate_table_id
  before_create :default_values
  has_many :rate_rows, :primary_key => :rate_table_id
  has_many :rate_cells, :through => :rate_rows
  belongs_to :template_definitions, :primary_key => :template_id
  belongs_to :templates, :primary_key => :template_id
  
  attr_accessible :effective_date, :effective_status, :rate_table_status, :template_id, :title
  
  validates :effective_date, :presence => true
  validates :effective_status, :presence => true, :length => { :maximum => 6 }
  validates :template_id, :presence => true, :length => { :maximum => 20 }
  validates :error_message, :length => { :maximum => 255 }
  validates :audit_user, :presence => true, :length => { :maximum => 15 }
  validates :title, :presence => true, :length => { :maximum => 50 }
  
  def self.get(id)
    where("rate_table_id = :id
           and effective_date =
             (select max(effective_date)
               from rate_tables
               where rate_table_id = :id)",{
        :id => id
    }).first
  end
  
  def self.search(title, status, template_name, template_code)
    with_templates
    .where("title like :title
           and rate_tables.effective_status like :effective_status
           and template_name like :template_name
           and template_code like :template_code",{
        :title            => search_term(title),
        :effective_status => search_term(status),
        :template_name    => search_term(template_name),
        :template_code    => search_term(template_code)
    })
  end
  
  def self.with_templates
    select("rate_tables.*, templates.template_code, templates.template_name").
    joins("join templates on rate_tables.template_id = templates.template_id
            and templates.effective_status = 'ACTIVE'
            and templates.effective_date =
              (select max(effective_date) from templates
                 where templates.template_id = rate_tables.template_id
                 and templates.effective_status = 'ACTIVE')")
  end

  def self.active
    where(effective_status = 'ACTIVE')
  end
  
  def rates
    Rate.for_template(self.template_id)
  end
  
  def avaliable_templates
    Template.select("distinct template_id, template_name, template_code").active
  end
  
  def template
    Template.where(:template_id => self.template_id).active.newest_active
  end
  
  def rows_with_common_rates(table_name, template_name, template_code, status)
    RateRow.select("rr.rate_row_id")
    .from("rate_tables rt
            join templates t
              on rt.template_id = t.template_id
            join rate_rows rr
              on rt.rate_table_id = rr.rate_table_id
            join rate_cells rc
              on rr.rate_row_id = rc.rate_row_id
                and rt.rate_table_id = rr.rate_table_id
            join template_definitions td
              on rt.template_id = td.template_id
                and rc.rate_id = td.rate_id
            join rates r
              on rc.rate_id = r.rate_id")
    .where("r.rate_id in
              (select rate_id
                from template_definitions td2
                  join rate_tables rt2
                    on td2.template_id = rt2.template_id
                where td2.template_id = rt2.template_id
                  and rt2.rate_table_id = :rate_table_id)
            and r.rate_type != 'billing_name'
            and upper(t.template_name) like :template_name
            and upper(t.template_code) like :template_code
            and upper(rt.title) like :table_name
            and upper(rt.effective_status) like :status", {
        :rate_table_id => self.rate_table_id,
        :template_name => RateTable.search_term(template_name),
        :template_code => RateTable.search_term(template_code),
        :table_name => RateTable.search_term(table_name),
        :status => RateTable.search_term(status)
    })
    .group("rr.rate_row_id")
  end
  
  protected
    
    def self.search_term(term)
      "%#{term}%".gsub(/\*+/,'%').gsub(/%+/,'%').upcase
    end
    
    # Called before create (insert), only sets the default value
    # if it has not already been set. 
    def default_values
      self.effective_status ||= 'DRAFT'
      self.effective_date ||= DateTime.now
      
      # Create a unique ID
      unique = Time.now.to_f.to_s.gsub('.','').to_i.to_s(36)
      unique += Random.rand("9".ljust(20-unique.length,"9").to_i).to_s.ljust(20-unique.length, "0")
      self.rate_table_id ||= unique
    end
end
