class Tool

  def self.doUpload(products)
   client = Savon.client(
      wsdl: APP_CONFIG["SOAP_WSDL"],
      endpoint: SOAP_URL)
   resp =  client.call(:login, message: { username: SOAP_USER, password: SOAP_PASSWORD })
   logger = ActiveRecord::Base.logger
   logger.debug resp
   success = resp.to_array(:login_response, :result)
   ActiveRecord::Base.logger.debug success
   ActiveRecord::Base.logger.debug success.inspect
   session_url = success[0][:server_url]
   ActiveRecord::Base.logger.debug "session url is #{session_url}"
   sid = success[0][:session_id]
   ActiveRecord::Base.logger.debug "session id is #{sid}"

   session = Savon.client(
     wsdl: APP_CONFIG["SOAP_WSDL"],
     endpoint: session_url)

   head1 = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
    xmlns:urn="urn:enterprise.soap.sforce.com"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:urn1="urn:sobject.enterprise.soap.sforce.com">
   <soapenv:Header>
      <urn:SessionHeader>
         <urn:sessionId>'

   head2 = '</urn:sessionId>
      </urn:SessionHeader>
   </soapenv:Header>
   <soapenv:Body>'

   header = head1 + sid + head2

   trail = '</soapenv:Body> </soapenv:Envelope>'

 
   resp = session.call(:query, xml: header + '<urn:query><urn:queryString>select productCode, description from product2</urn:queryString></urn:query>' + trail)

   logger.debug "response from query is: #{resp.inspect}"

   result = resp.to_array(:query_response, :result)
   logger.debug "result is: #{result.inspect}"
   logger.debug "result[0] is: #{result[0].inspect}"
   records = result[0][:records]
   logger.debug "retrieved from salesforce: #{records.inspect}"

   sf_rec_map = {}
   case result[0][:size]
   when "0"
   when ""
   when nil
   when "1"
     record = records
     unless record[:description].nil?
       description = record[:description]
       logger.debug "description is: #{record[:description]}"
       code = record[:product_code]
       sf_rec_map[code] = record
       lookup = Product.where(:product_code => code).first
       if lookup.nil?
         newproduct = Product.new
         newproduct.product_code = code
         newproduct.name = description
         newproduct.provider_code = 'PR006'
         logger.debug "inserting record: #{newproduct.inspect}"
         newproduct.save
       end
     end
   else
     records.each do |record|
       ActiveRecord::Base.logger.debug "record is: #{record.inspect}"
       unless record[:description].nil?
         description = record[:description]
         logger.debug "description is: #{record[:description]}"
         code = record[:product_code]
         sf_rec_map[code] = record
         lookup = Product.where(:product_code => code).first
         if lookup.nil?
           newproduct = Product.new
           newproduct.product_code = code
           newproduct.name = description
           newproduct.provider_code = 'PR006'
           logger.debug "inserting record: #{newproduct.inspect}"
           newproduct.save
         end
       end
     end
   end
   

   logger.debug "record map is: #{sf_rec_map.inspect}"
   sobj = ""
   products.each do |pr|
     logger.debug "product is #{pr.inspect}"
     sf_rec = sf_rec_map[pr.product_code]
     logger.debug "salesforce match result: #{sf_rec}"
     if sf_rec.nil?
       sobj = sobj +
         '<urn:sObjects xsi:type="urnl:Product2"><Name>' + pr.name + '</Name>' +
         '<Description>' + pr.name + '</Description>' +
         '<ProductCode>' + pr.product_code + '</ProductCode>' +
         '</urn:sObjects>'
     end
   end

   logger.debug "uploading to salesforce: #{sobj}"
 
   resp = session.call(:create, xml: header + '<urn:create>' + sobj + '</urn:create>' + trail)
 end
 end
