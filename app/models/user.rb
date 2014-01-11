class User
  attr_reader :user_name, :password, :super_user

  def initialize(args={})
    args.each do |key, value|
      instance_variable_set("@#{key}", value) unless value.nil?
    end
  end
  
  def self.authenticate(user_name, password)
    # Only allows a few users
    allowed_users = ["pgiuser1", "pgiuser2", "pgiuser3", "pgiuser4", "pgiuser5",
                     "pgiuser6", "pgiuser7", "pgiuser8", "pgiuser9", "pgiuser10", "pgiadmin",
                     "tapadmin"]
    if allowed_users.index(user_name).nil?
      return nil
    end

    client = Savon.client(
       wsdl: WFX_URL + "?wsdl",
       basic_auth: [WFX_AUTH_USER, WFX_AUTH_PASSWORD],
       endpoint: WFX_URL)

    begin
      resp =  client.call(:authenticate, message: { principalId: user_name, password: password })
      ActiveRecord::Base.logger.debug(resp.to_array)
      success = resp.to_array(:authenticate_response, :authenticate_response_return, :authenticate_return_value)
  
      if success[0] == true
        ActiveRecord::Base.logger.debug("login successful")
  
        super_user = determineSuperUser(client, user_name)
        user=self.new(:user_name => user_name, :password => password, :super_user=>super_user)
        return user
      else
        ActiveRecord::Base.logger.debug("login failed")
        return nil
      end
    rescue Errno::ECONNREFUSED => e
      ActiveRecord::Base.logger.error("Login Failed - Cannont connect to security server")
      return nil
    end
  end

private

  def self.determineSuperUser(client, user_name)
    resp =  client.call(:authorize, message: { principalId: user_name, AclId: "013e37281133104600331f90000000ff"})
    ActiveRecord::Base.logger.debug(resp.to_array)

    success = resp.to_array(:authorize_response, :authorize_response_return, :authorize_return_value)
    

    ActiveRecord::Base.logger.debug("authorized: #{success}")
    return success[0]
  end 
end
