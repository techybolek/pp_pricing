ENV['TZ'] = 'UTC'
Date::DATE_FORMATS[:default] = "%m-%d-%Y"
Time::DATE_FORMATS[:default] = "%m-%d-%Y %H:%M"


ActiveSupport.on_load(:active_record) do
  ActiveRecord::ConnectionAdapters::OracleEnhancedAdapter.class_eval do
    self.string_to_date_format = "%m-%d-%Y"
    self.string_to_time_format = "%m-%d-%Y %H:%M:%S"
    self.emulate_booleans_from_strings = true
  end
end
