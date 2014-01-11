class RateRow < ActiveRecord::Base
  self.primary_key = :rate_row_id
  before_create :default_values
  has_many :rate_cells, :primary_key=>:rate_row_id
  belongs_to :rate_tables, :primary_key=>:rate_table_id
  
  attr_accessible :effective_status, :effective_date, :audit_user
  
  validates :effective_date, :presence => true
  validates :effective_status, :presence => true, :length => { :maximum => 6 }
  validates :audit_user, :presence => true, :length => { :maximum => 15 }
  
  def self.get(id)
    where("rate_row_id = :id
           and effective_date =
             (select max(effective_date)
               from rate_rows
               where rate_row_id = :id)",{
        :id => id
    }).first
  end
  
  def get_cells(template_id)
    RateCell.where(:rate_row_id => self.rate_row_id)
            .joins("left join template_definitions on (template_definitions.rate_id = rate_cells.rate_id and template_definitions.template_id = '#{template_id}')")
            .order("column_position ASC")
  end
  
  def get_cell(rate_id)
    RateCell.where(:rate_row_id => self.rate_row_id,
                   :rate_id => rate_id).first
  end
  
  protected
    # Called before create (insert), only sets the default value
    # if it has not already been set. 
    def default_values
      self.delete_allowed ||= true
      self.effective_status ||= 'DRAFT'
      self.effective_date ||= DateTime.now
      
      # Create a unique ID
      unique = Time.now.to_f.to_s.gsub('.','').to_i.to_s(36)
      unique += Random.rand("9".ljust(20-unique.length,"9").to_i).to_s.ljust(20-unique.length, "0")
      self.rate_row_id ||= unique
    end
end
