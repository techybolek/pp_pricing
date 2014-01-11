class ServicesController < ApplicationController
  
  def index
    setup_sessions
    @suppliers = Provider.join_service.uniq.select("p.name, p.provider_code")
    @services = Service.search({
      :provider_code => session[:provider_code],
      :postal_code => session[:postal_code],
      :product_code => session[:product_code],
      :product_name => session[:product_name],
      :associated_service_code => session[:associated_service_code],
      :associated_service_name => session[:associated_service_name],
      :service_characteristic_code => session[:service_characteristic_code],
      :service_characteristic_name => session[:service_characteristic_name],
      :service_code => session[:service_code],
      :service_name => session[:service_name],
      :technical_service_value => session[:technical_service_value],
      :service_test_mode_ind => session[:service_test_mode_ind],
      :service_change_group_id => session[:service_change_group_id]
    }).order(session[:service_order]
    ).page(params[:page]
    ).per(session[:service_amount])
  end
  
  def edit
    # if version param is not supplied, fetch the newest version
    params[:version] ||= Service.where(:service_code => params[:id]).maximum("service_version_code")
    
    @service = Service.get(params[:id], params[:version])
  end
  
  private
    
    def setup_sessions
      session[:provider_code] = params[:provider_code] || session[:provider_code] || ''
      session[:postal_code] = params[:postal_code] || session[:postal_code] || ''
      session[:product_code] = params[:product_code] || session[:product_code] || ''
      session[:product_name] = params[:product_name] || session[:product_name] || ''
      session[:associated_service_code] = params[:associated_service_code] || session[:associated_service_code] || ''
      session[:associated_service_name] = params[:associated_service_name] || session[:associated_service_name] || ''
      session[:service_characteristic_code] = params[:service_characteristic_code] || session[:service_characteristic_code] || ''
      session[:service_characteristic_name] = params[:service_characteristic_name] || session[:service_characteristic_name] || ''
      
      session[:service_code] = params[:service_code] || session[:service_code] || ''
      session[:service_name] = params[:service_name] || session[:service_name] || ''
      session[:technical_service_value] = params[:technical_service_value] || session[:technical_service_value] || ''
      session[:service_test_mode_ind] = params[:service_test_mode_ind] || session[:service_test_mode_ind] || ''
      session[:service_change_group_id] = params[:service_change_group_id] || session[:service_change_group_id] || ''
      
      session[:service_order] = params[:order] || session[:service_order] || "service.service_code"
      session[:service_amount] = params[:amount] || session[:service_amount] || "10"
    end
end
