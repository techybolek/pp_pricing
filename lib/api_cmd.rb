# Add error helper methods to Nokogiri
class Nokogiri::XML::Node
  # If request_id is supplied, the TyTransResponse of the specific ID will be checked for error.
  # If not supplied, the root TyWorkResponse will be checked for error.
  def is_error?(request_id=nil)
    error = false
    if !request_id.nil?
      error = true if at_xpath("//TyTransResponse[@ID='#{request_id}'][@ReturnCode='false']")
    else
      error = true if at_xpath("/TyWorkResponse[@ReturnCode='false']")
    end
    return error
  end
  
  # If request_id is supplied, the TyTransResponse of the specific ID will be checked for success.
  # If not supplied, the root TyWorkResponse will be checked for success.
  def is_success?(request_id=nil)
    success = false
    if !request_id.nil?
      success = true if at_xpath("//TyTransResponse[@ID='#{request_id}'][@ReturnCode='true']")
    else
      success = true if at_xpath("/TyWorkResponse[@ReturnCode='true']")
    end
    return success
  end
end

class ApiCmd
  # Sends an XML API call to ErpXMLInterfaceServer and returns the result.
  # Raises a RuntimeError if the Corba connection to the server fails.
  def self.send(cmd)
    java_import 'java.lang.System'
    java_import 'java.util.Properties'
    java_import 'com.cgi.tapestry.corbautil.CorbaClient'
    
    props = System.getProperties
    props.put("corbaHost", CORBA_HOST)
    props.put("corbaPort", CORBA_PORT)
    props.put("apiServer", API_SERVER)
    
    Rails.logger.info "Sending XML: " + cmd.to_s.sub(/Password="[^"]*"/, 'Password="[FILTERED]"')
    
    #excutes corba call utilizing corbautil.jar
    response = CorbaClient.executeCommand(cmd, props)
    
    #parse response to check return code
    doc = Nokogiri::XML(response)
    if doc.root.nil?
      Rails.logger.error "Could not connect to XML server. Host (#{CORBA_HOST}), Port (#{CORBA_PORT}), Server (#{API_SERVER})"
      raise "Could not connect to XML server"
    end
    Rails.logger.info "Received XML: " + doc.to_s.sub(/Password="[^"]*"/, 'Password="[FILTERED]"')
    return doc
  end
  
  def self.login(username, password)
    builder = Nokogiri::XML::Builder.new do |xml|
      xml.TyWorkRequest("ID"=>"tapadmin", "Locale"=>"en_US") {
        xml.CommandList {
          xml.AclSecurityCmd("ID"=>"Security Login", "UpdateUserID"=>username) {
            xml.AclSecurityFacade("PrincipalID"=> username || '',
                                  "Password"=> password || '',
                                  "Action"=>"LOGIN")
          } # AclSecurityCmd
        } # CommandList 
      } # TyWorkRequest
    end
    
    send(builder.to_xml)
  end
end
