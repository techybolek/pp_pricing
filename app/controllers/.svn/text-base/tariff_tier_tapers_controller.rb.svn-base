class TariffTierTapersController < ApplicationController
  
  def index
    setup_sessions
    @ttt = TariffTierTaper.search({:tariff_tier_taper_code => session[:tariff_tier_taper_code],
              :tariff_tier_taper_name => session[:tariff_tier_taper_name],
              :tariff_model_area_code => session[:tariff_model_area_code],
              :tariff_model_area_name => session[:tariff_model_area_name],
              :test_mode_ind => session[:test_mode_ind],
              :change_group_id => session[:change_group_id]})
           .order(session[:tariff_tier_taper_order])
           .page(params[:page])
           .per(session[:tariff_tier_taper_amount])
    @change_groups = ChangeGroup.pluck(:change_group_id)
  end
  
  def show
    @ttt = TariffTierTaper.find(params[:id])
  end
  
  private
      
    def setup_sessions
      session[:tariff_tier_taper_code]   = params[:tariff_tier_taper_code] || session[:tariff_tier_taper_code]
      session[:tariff_tier_taper_name]   = params[:tariff_tier_taper_name] || session[:tariff_tier_taper_name]
      session[:tariff_model_area_code]   = params[:tariff_model_area_code] || session[:tariff_model_area_code]
      session[:tariff_model_area_name]   = params[:tariff_model_area_name] || session[:tariff_model_area_name]
      session[:test_mode_ind]            = params[:test_mode_ind] || session[:test_mode_ind]
      session[:change_group_id]          = params[:change_group_id] || session[:change_group_id]
      session[:tariff_tier_taper_order]  = params[:order] || session[:tariff_tier_taper_order] || "ttt.tariff_tier_taper_code asc"
      session[:tariff_tier_taper_amount] = params[:amount] || session[:tariff_tier_taper_amount] || "10"
    end
end