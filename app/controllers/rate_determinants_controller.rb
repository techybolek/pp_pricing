class RateDeterminantsController < ApplicationController
  
  def index
    setup_sessions
    @rates = Rate.search(session[:rate_determinant_code], 
       session[:rate_determinant_name], session[:rate_determinant_group_code], "determinant")
       .order(session[:determinant_order])
       .page(params[:page])
       .per(session[:determinant_amount])
  end
  
  def new
    @rate = RateDeterminant.new(:rtti_path => "String.rate1")
  end
  
  def create
    @rate = RateDeterminant.new(params[:rate_determinant])
    if @rate.save
      flash[:success] = "Rate Determinant successfully created"
      redirect_to :rate_determinants
    else
      render :new
    end
  end
  
  def destroy
    count = TemplateDefinition.for_rate(params[:id]).count
    if count > 0
       flash[:error] = "The rate determinant is referenced in template definitions. Cannot delete"
    else
       RateDeterminant.delete_all(:rate_id => params[:id])
       flash[:success] = "Rate determinant successfully deleted"
    end
    redirect_to :action => :index
  end

  def edit
    @rate = RateDeterminant.find(params[:id])
  end
  
  def update
    @rate = RateDeterminant.find(params[:id])
	 det = params[:rate_determinant]
	 if det.key?(:group_code)
	   logger.debug("group code populated")
    else
	   logger.debug("group code not populated forcing null")
	   det[:group_code] = nil
		logger.debug("parameters are: #{det}")
    end
    if @rate.update_attributes(det)
      flash[:success] = "Rate Determinant successfully updated"
      redirect_to :rate_determinants
    else
      render :edit
    end
  end

  private

    def setup_sessions
      session[:rate_determinant_code] = params[:determinant_code] || session[:rate_determinant_code]
      session[:rate_determinant_name] = params[:determinant_name] || session[:rate_determinant_name]
      session[:rate_determinant_group_code] = params[:determinant_group_code] || session[:rate_determinant_group_code]
      session[:determinant_order] = params[:order] || session[:determinant_order] || "rate_code asc"
      session[:determinant_amount] = params[:amount] || session[:determinant_amount] || "10"
    end
end
