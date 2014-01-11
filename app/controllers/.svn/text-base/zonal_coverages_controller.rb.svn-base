class ZonalCoveragesController < ApplicationController
  
  def index
    setup_sessions
    @zcs = ZonalCoverage.search({:zonal_coverage_code => session[:zonal_coverage_code],
              :zonal_coverage_name => session[:zonal_coverage_name],
              :tariff_zone_code => session[:tariff_zone_code],
              :tariff_model_area_code => session[:tariff_model_area_code],
              :tariff_model_area_name => session[:tariff_model_area_name],
              :test_mode => session[:test_mode],
              :change_group_id => session[:change_group_id]})
           .order(session[:zonal_coverage_order])
           .page(params[:page])
           .per(session[:zonal_coverage_amount])
    @change_groups = ChangeGroup.pluck(:change_group_id)
  end
  
  def show
    @zc = ZonalCoverage.find(params[:id])
  end
  
  private
      
    def setup_sessions
      session[:zonal_coverage_code]    = params[:zonal_coverage_code] || session[:zonal_coverage_code]
      session[:zonal_coverage_name]    = params[:zonal_coverage_name] || session[:zonal_coverage_name]
      session[:tariff_zone_code]       = params[:tariff_zone_code] || session[:tariff_zone_code]
      session[:tariff_model_area_code] = params[:tariff_model_area_code] || session[:tariff_model_area_code]
      session[:tariff_model_area_name] = params[:tariff_model_area_name] || session[:tariff_model_area_name]
      session[:test_mode]              = params[:test_mode] || session[:test_mode]
      session[:change_group_id]        = params[:change_group_id] || session[:change_group_id]
      session[:zonal_coverage_order]   = params[:order] || session[:zonal_coverage_order] || "zc.zonal_coverage_code asc"
      session[:zonal_coverage_amount]  = params[:amount] || session[:zonal_coverage_amount] || "10"
    end
  
end