class RateResultsController < ApplicationController
  
  def index
    setup_sessions
    @rates = Rate.search(session[:rate_result_code], 
       session[:rate_result_name], 
       session[:rate_result_group_code], 
       "result")
       .order(session[:result_order])
       .page(params[:page])
       .per(session[:result_amount])
  end
  
  def new
    @rate = RateResult.new(:rtti_path => "String.rate1")
  end
  
  def create
    @rate = RateResult.new(params[:rate_result])
    if @rate.save
      flash[:success] = "Rate Result successfully created"
      redirect_to :rate_results
    else
      render :new
    end
  end
  
  def edit
    @rate = RateResult.find(params[:id])
  end
  
  def update
    @rate = RateResult.find(params[:id])
	 res = params[:rate_result]
	 if res.key?(:group_code)
	   logger.debug("group code populated")
    else
	   logger.debug("group code not populated forcing null")
	   res[:group_code] = nil
		logger.debug("parameters are: #{res}")
    end
    if @rate.update_attributes(params[:rate_result])
      flash[:success] = "Rate Result successfully updated"
      redirect_to :rate_results
    else
      render :edit
    end
  end

  def destroy
    count = TemplateDefinition.for_rate( params[:id]).count
    if count > 0
       flash[:error] = "The rate result is referenced in template definitions. Cannot delete"
    else
       RateResult.delete_all(:rate_id => params[:id])
       flash[:success] = "Rate result successfully deleted"
    end
    redirect_to :action => :index
  end

  private

    def setup_sessions
      session[:rate_result_code] = params[:result_code] || session[:rate_result_code]
      session[:rate_result_name] = params[:result_name] || session[:rate_result_name]
      session[:rate_result_group_code] = params[:result_group_code] || session[:rate_result_group_code]
      session[:result_order] = params[:order] || session[:result_order] || "rate_code asc"
      session[:result_amount] = params[:amount] || session[:result_amount] || "10"
    end
end
