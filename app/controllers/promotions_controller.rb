class PromotionsController < ApplicationController
 
  def index
    setup_sessions
    
    @promotions = Promotion.search(
      promotion_code: session[:promotion_code],
      promotion_name: session[:promotion_name],
      promotion_status: session[:promotion_status],
      promotion_test_mode_ind: session[:promotion_test_mode_ind],
      change_group_id: session[:change_group_id],
      product_code: session[:product_code],
      product_name: session[:product_name],
      pricing_structure_code: session[:pricing_structure_code],
      price_plan_code: session[:price_plan_code],
      price_plan_name: session[:price_plan_name],
      rate_plan_code: session[:rate_plan_code],
      rate_plan_name: session[:rate_plan_name]
    ).order(
      session[:promotion_order]
    ).page(
      params[:page]
    ).per(
      session[:promotion_amount]
    )
  end
  
  def edit
    @promotion = Promotion.find(params[:id])
  end
  
  private
    def setup_sessions
      session[:promotion_code] = params[:promotion_code] || session[:promotion_code] || ''
      session[:promotion_name] = params[:promotion_name] || session[:promotion_name] || ''
      session[:promotion_status] = params[:promotion_status] || session[:promotion_status] || ''
      session[:promotion_test_mode_ind] = params[:promotion_test_mode_ind] || session[:promotion_test_mode_ind] || ''
      session[:change_group_id] = params[:change_group_id] || session[:change_group_id] || ''
      session[:product_code] = params[:product_code] || session[:product_code] || ''
      session[:product_name] = params[:product_name] || session[:product_name] || ''
      session[:pricing_structure_code] = params[:pricing_structure_code] || session[:pricing_structure_code] || ''
      session[:price_plan_code] = params[:price_plan_code] || session[:price_plan_code] || ''
      session[:price_plan_name] = params[:price_plan_name] || session[:price_plan_name] || ''
      session[:rate_plan_code] = params[:rate_plan_code] || session[:rate_plan_code] || ''
      session[:rate_plan_name] = params[:rate_plan_name] || session[:rate_plan_name] || ''
      
      session[:promotion_order] = params[:order] || session[:promotion_order] || "promotion_code asc"
      session[:promotion_amount] = params[:amount] || session[:promotion_amount] || "10"
    end
end
