class ServiceCharacteristicsController < ApplicationController
  
  def index
    setup_sessions
    @characteristics = ServiceCharacteristic.search(
      name: session[:service_characteristic_name],
      service_char_code: session[:service_characteristic_code],
      datatype_value: session[:service_characteristic_data_type]
    ).order(
      session[:service_characteristic_order]
    ).page(
      params[:page]
    ).per(
      session[:service_characteristic_amount]
    )
  end
  
  def edit
    @characteristic = ServiceCharacteristic.find(params[:id])
  end
  
  private
    
    def setup_sessions
      session[:service_characteristic_code] = params[:service_characteristic_code] || session[:service_characteristic_code]
      session[:service_characteristic_name] = params[:service_characteristic_name] || session[:service_characteristic_name]
      session[:service_characteristic_data_type] = params[:service_characteristic_data_type] || session[:service_characteristic_data_type]

      session[:service_characteristic_order] = params[:order] || session[:service_characteristic_order] || "service_char_code asc"
      session[:service_characteristic_amount] = params[:amount] || session[:service_characteristic_amount] || "10"
    end
end
