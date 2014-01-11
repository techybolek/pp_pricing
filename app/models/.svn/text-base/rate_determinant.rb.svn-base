class RateDeterminant < Rate
  before_create :default_values
  
  default_scope where(:rate_type => "determinant")
  
  protected
    # Called before create (insert), only sets the default value
    # if it has not already been set. 
    def default_values
      # Set type as determinant
      self.rate_type ||= "determinant"
      super
    end
end