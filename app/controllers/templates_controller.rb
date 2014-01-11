#require 'ostruct'
class TemplatesController < ApplicationController
  @@format = "%m-%d-%Y"
  
  def index
    setup_sessions
    @templates = Template.search(session[:usage_template_name], session[:usage_template_code])
       .order(session[:template_order])
       .page(params[:page])
       .per(session[:template_amount])
    if params.key?(:ajax)
        logger.debug("index#ajax, redirecting")
       result = OpenStruct.new({:theurl => templates_path})
         render js: "window.location.pathname=#{templates_path.to_json}"
         #render :json => result
    end
  end
  
  def new
    logger.debug("new action")
    @determinants = Rate.determinants
    @results = Rate.results
    @template = Template.new
    @effective_date = DateTime.now.strftime(@@format)
    logger.debug(@effective_date.inspect);
    #template.effective_date = DateTime.now
    logger.debug(@template.effective_date.inspect);
    @template.effective_status = "DRAFT"
    logger.debug("end new action")
  end
  
  def create
    logger.debug("create action")
    @template = Template.new(params[:template])
    @template.effective_date = extract_date
    if @template.save
      if params[:rate_ids]
        params[:rate_ids].each do |rate|
          logger.debug("rate is #{rate}")
          if rate.empty?
            raise "Error: rate appears to be null!"
          else
            TemplateDefinition.new(:template_id => @template.template_id,
             :rate_id => rate).save
          end
        end
      end
      render js: "window.location.pathname=#{template_path(@template).to_json}"
    else
      logger.debug("create failed")
      logger.error("Failed creating template: " + @template.errors.to_a.to_s)
      @determinants = Rate.determinants
      @results = Rate.results
      error ="Error save"
      render js: error.to_json
    end
  end
  
  def destroy
    TemplateDefinition.delete_all(:template_id=>params[:id])
    Template.delete_all(:template_id=>params[:id])
    flash[:success] = "Template successfully deleted"
    redirect_to :action => :index
  end
  
  def update_with_rates
    logger.debug("add rates begin #{params}")
    @template = Template.get(params[:template_id])
    #@template.effective_date = extract_date
    p = params["template"]
    p[:effective_date] = extract_date
    if @template.update_attributes(p)
      TemplateDefinition.delete_all(:template_id=>params[:template_id])
      if params[:rate_ids]
        params[:rate_ids].each do |rate|
          logger.debug("rate is #{rate}")
          if rate.empty?
            raise "Error: rate appears to be null!"
          else
            TemplateDefinition.new(:template_id => params[:template_id],
                                :rate_id => rate).save
          end
        end
      end
    else
      logger.error(@template.errors.to_a.to_s)
    end

    unless BillingName.all.length > 0
      logger.debug("creating billing name...")
      BillingName.create!(:rate_code => "BILINGNAME", :data_type => "String", :rtti_path => "NONE", :title => "Billing Name",
        :evaluation_order => "Ascending" )
      logger.debug("...createed")
    end
    #bn = BillingName.new
    #bn.save
    #logger.debug(bn.errors.inspect.to_s)
    TemplateDefinition.new(:template_id => params[:template_id],
                     :rate_id => BillingName.getBillingTypeId).save
    #redirect_to :action => :show, :id=> params[:template_id]
    logger.debug("add rates end")
    show
  end

  def approve
   logger.debug("approve begin #{params}")
   @template = Template.get(params[:template_id])
   @template.approve

   #redirect_to :action => :show, :id=> params[:template_id]
   logger.debug("add rates end")
   show
  end


  def show
    logger.debug("showing...")
    id = nil
    # add_rates sends template_id while show sends id
    if params[:template_id]
      id = params[:template_id]
    else
      id = params[:id]
    end
    @template = Template.get(id)
    @determinants = Rate.determinants
    @results = Rate.results
    @effective_date = @template.effective_date.to_date.strftime(@@format);
    if params.key?(:ajax)
      logger.debug("ajax still on!")
      render :partial => "show", :layout => false
    end
  end
  
  private

    def setup_sessions
      session[:usage_template_name] = params[:template_name] || session[:usage_template_name]
      session[:usage_template_code] = params[:template_code] || session[:usage_template_code]
      session[:template_order] = params[:order] || session[:template_order] || "template_name asc"
      session[:template_amount] = params[:amount] || session[:template_amount] || "10"
    end

    def extract_date
      eds = params[:template][:effective_date]
      logger.debug(eds)
      #zone = "Mountain Time (US & Canada)"
      zone = Rails.application.config.time_zone
      eff_date = DateTime.strptime(eds + " " + zone, @@format + " %Z")
    end

end
