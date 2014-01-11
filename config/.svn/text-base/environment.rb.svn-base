# Load the rails application
require File.expand_path('../application', __FILE__)

require 'java'
require 'rubygems'
require 'authenticated_system'
require 'api_cmd'

java_import 'java.lang.System'
java_import 'java.lang.ClassLoader'
java_import 'java.util.Properties'
java_import 'java.net.URL'

props = Properties.new
url = Java::JavaLang::Thread.currentThread().getContextClassLoader().getResource("pp_pricing.properties")
if url.nil?
  puts "CANNOT FIND 'pp_pricing.properties'!"
  raise "CANNOT FIND 'pp_pricing.properties'!"
end
props.load(url.openStream())

DB_HOST = props.getProperty("DB_HOST")
DB_PORT = props.getProperty("DB_PORT")
DB_NAME = props.getProperty("DB_NAME")
DB_USERNAME = props.getProperty("DB_USERNAME")
DB_PASSWORD = props.getProperty("DB_PASSWORD")
DB_SCHEMA = props.getProperty("DB_SCHEMA")
WKHTMLTOPDF = props.getProperty("WKHTMLTOPDF")

#WFX Variables
WFX_URL = props.getProperty("WFX_URL")
WFX_AUTH_USER = props.getProperty("WFX_AUTH_USER")
WFX_AUTH_PASSWORD = props.getProperty("WFX_AUTH_PASSWORD")

# Initialize the rails application
APP_CONFIG = YAML.load_file(Rails.root.join('config', 'config.yml'))[Rails.env]
PpPricing::Application.initialize!

SOAP_URL =  "https://login.salesforce.com/services/Soap/c/28.0"
SOAP_USER = "tromanow@hotmail.com"
SOAP_PASSWORD = "CGI_SPG_123GR1mNSdwfqosY8wwgxZQ1D1qH"

