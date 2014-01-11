class RateResult < Rate
  before_create :default_values
  default_scope where(:rate_type => "result")
  
  validates :precision, :numericality => { :only_integer => true }, :if => Proc.new {self.data_type == "Decimal"}
  
  protected
    # Called before create (insert), only sets the default value
    # if it has not already been set. 
    def default_values
      # Set type as determinant
      self.rate_type ||= "result"
      super
    end
end
