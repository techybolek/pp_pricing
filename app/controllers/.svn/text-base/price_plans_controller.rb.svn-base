class PricePlansController < ApplicationController
  @@format = "%m-%d-%Y"

  def index
    setup_sessions
    @change_groups = ChangeGroup.pluck(:change_group_id)
    @suppliers = Provider.join_price_plan.uniq.pluck("p.name")
    @price_plans = PricePlan.search(session.clone)
       .order(session[:price_plan_order])
       .page(params[:page])
       .per(session[:price_plan_amount])
  end
  
  def new
    @price_plan = PricePlan.new
    @price_plan.effective_date = DateTime.now
  end
  
  def create
    @price_plan = PricePlan.new(params[:price_plan])
    @price_plan.effective_date = extract_date
    if @price_plan.save
      flash[:success] = "Price Plan successfully created"
      redirect_to :price_plans
    else
      render :new
    end
  end
  
  def destroy
    PricePlan.delete_all(:price_plan_version_id => params[:id])
    flash[:success] = "Price Plan successfully deleted"
    redirect_to :action => :index
  end

  def edit
    @price_plan = PricePlan.find(params[:id])
    @rule = AlgorithmSelectionRule.get_rule_info(@price_plan.root_selection_rule_id)
  end
  
  def show
    @price_plan = PricePlan.find(params[:id])
    @rule = AlgorithmSelectionRule.get_rule_info(@price_plan.root_selection_rule_id)
  end
  
  def update
    @price_plan = PricePlan.find(params[:id])
    p = params[:price_plan]
    p[:effective_date] = extract_date
    if @price_plan.update_attributes(p)
      flash[:success] = "Price Plan successfully updated"
      redirect_to :price_plans
    else
      render :edit
    end
  end

  private
    def extract_date
      eds = params[:price_plan][:effective_date]
      logger.debug(eds)
      #zone = "Mountain Time (US & Canada)"
      zone = Rails.application.config.time_zone
      eff_date = DateTime.strptime(eds + " " + zone, @@format + " %Z")
    end

    def setup_sessions
      session[:price_plan_code] = params[:price_plan_code] || session[:price_plan_code]
      session[:price_plan_name] = params[:price_plan_name] || session[:price_plan_name]
      session[:price_plan_supplier_name] = params[:price_plan_supplier_name] || session[:price_plan_supplier_name]
      session[:test_mode] = params[:test_mode] || session[:test_mode]
      session[:change_group_id] = params[:change_group_id] || session[:change_group_id]
      session[:price_plan_service_name] = params[:price_plan_service_name] || session[:price_plan_service_name]
      session[:price_plan_service_code] = params[:price_plan_service_code] || session[:price_plan_service_code]
      session[:price_plan_tma_code] = params[:price_plan_tma_code] || session[:price_plan_tma_code]
      session[:price_plan_order] = params[:order] || session[:price_plan_order] || "price_plan_code asc"
      session[:price_plan_amount] = params[:amount] || session[:price_plan_amount] || "10"
    end
end
