class TariffZonesController < ApplicationController
  
  def index
    setup_sessions
    @tzs = TariffZone.search({:tariff_zone_code => session[:tariff_zone_code],
              :effective_date => session[:effective_date],
              :originating_point => session[:originating_point],
              :terminating_point => session[:terminating_point],
              :tariff_model_area_code => session[:tariff_model_area_code],
              :tariff_model_area_name => session[:tariff_model_area_name],
              :test_mode => session[:test_mode],
              :change_group_id => session[:change_group_id]})
           .order(session[:tariff_zone_order])
           .page(params[:page])
           .per(session[:tariff_zone_amount])
    @change_groups = ChangeGroup.pluck(:change_group_id)
  end
  
  def show
    @tz = TariffZone.find(params[:id])
  end
  
  private
      
    def setup_sessions
      session[:tariff_zone_code]       = params[:tariff_zone_code] || session[:tariff_zone_code]
      session[:effective_date]         = params[:effective_date] || session[:effective_date]
      session[:originating_point]      = params[:originating_point] || session[:originating_point]
      session[:terminating_point]      = params[:terminating_point] || session[:terminating_point]
      session[:tariff_model_area_code] = params[:tariff_model_area_code] || session[:tariff_model_area_code]
      session[:tariff_model_area_name] = params[:tariff_model_area_name] || session[:tariff_model_area_name]
      session[:test_mode]              = params[:test_mode] || session[:test_mode]
      session[:change_group_id]        = params[:change_group_id] || session[:change_group_id]
      session[:tariff_zone_order]      = params[:order] || session[:tariff_zone_order] || "tz.tariff_zone_code asc"
      session[:tariff_zone_amount]     = params[:amount] || session[:tariff_zone_amount] || "10"
    end
  
end