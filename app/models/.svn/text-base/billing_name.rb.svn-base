class BillingName < Rate
  before_create :default_values
  default_scope where(:rate_type => "billing_name")

  def self.getBillingTypeId
   bt = self.all
   logger.debug("bt inspect #{bt}")
   bt.each do |rate|
     return rate.rate_id
   end
   logger.debug("returning nil")
   return nil
  end


protected
    # Called before create (insert), only sets the default value
    # if it has not already been set. 
    def default_values
      # Set type as determinant
      logger.debug("really creating billing name...")
      super
    end
end
