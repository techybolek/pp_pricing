class TariffModelAreasController < ApplicationController
  
  def index
    setup_sessions
    @tmas = TariffModelArea.search(
              :tma_code => session[:tma_code],
              :tma_name => session[:tma_name],
              :measure_unit => session[:measure_unit],
              :calculation_id => session[:calculation_id],
              :test_mode => session[:test_mode],
              :rate_plan => session[:rate_plan],
              :change_group => session[:change_group]
    ).order(session[:tma_order]
    ).page(params[:page]
    ).per(session[:tma_amount])
  end
  
  def new
    params[:tariff_model_area] ||= {:effective_status => 'DRAFT',
                                    :effective_date => DateTime.now}
    @tma = TariffModelArea.new(params[:tariff_model_area])
  end
  
  def edit
    @tma = TariffModelArea.find(params[:id])
  end
  
  def update
    errors = []
    tma = TariffModelArea.find(params[:id])
    tma.assign_attributes(params[:tariff_model_area])
    tma.audit_update_user_id = session[:user].user_name
    tma.audit_update_date_time = DateTime.now
    
    if !tma.valid?
      errors.concat(tma.errors.to_a)
    end
    
    if errors.empty?
      # If there are any errors, no changes should be saved
      ActiveRecord::Base.transaction do
        
        # Update Calculation Options
        if tma.calculation_id_changed? && params[:calculation_options]
          errors.concat create_calculation_options(tma, params[:calculation_options].first)
        elsif params[:calculation_options]
          params[:calculation_options].first.each do |option_id, value|
            # Update a value on the Calculation Options tab
            CalculationOptionValue.where(
              :parent_id => tma.tariff_model_area_version_id,
              :tariff_model_area_version_id => tma.tariff_model_area_version_id,
              :calculation_option_id => option_id
            ).update_all(:calculation_option_value => value || '0')
          end
        else
          delete_calculation_options(tma)
        end
        
        # Update TMEs
        if tma.is_generated_tmes? && params[:tmes]
          errors.concat create_tmes(tma, params[:tmes])
        elsif params[:tmes]
          params[:tmes].each_with_index do |tme, index|
            tme = JSON.parse(tme)
            
            # Update billing name
            actual_tme = TariffModelEntry.find(tme["tariff_model_entry_id"])
            actual_tme.update_attributes(:billing_name_1 => tme["billing_name_1"])
            errors.concat actual_tme.errors.to_a
            
            tme.select{|key, value| key =~ /^calculation_option_/}.each do |option, value|
              CalculationOptionValue.where(
                         :parent_id => tme["tariff_model_entry_id"],
                         :tariff_model_area_version_id => tma.tariff_model_area_version_id,
                         :calculation_option_id => option[/[^_]*$/, 0],
                         :option_level_indicator => 'T'
              ).update_all(:calculation_option_value => value || '0')
            end
          end
        else
          delete_tmes(tma)
        end
        
        # Don't throw an error until all validations are run to be sure
        # we have collected all the errror to show the user
        raise ActiveRecord::Rollback, "TMA failed validations" if errors.any?
        
        tma.save!
      end # ActiveRecord::Base.transaction
    end # errors.empty?
      
    if errors.empty?
      render json: {success: true}, status: :ok
    else
      render json: errors, status: :unprocessable_entity
    end
  end
  
  def approve
    tma = TariffModelArea.find(params[:tariff_model_area_id])
    tma.update_attributes({:effective_status => 'ACTIVE'})
    
    redirect_to :action => :edit, :id => params[:tariff_model_area_id]
  end
  
  def revert
    tma = TariffModelArea.find(params[:tariff_model_area_id])
    tma.update_attributes({:effective_status => 'DRAFT'})
    
    redirect_to :action => :edit, :id => params[:tariff_model_area_id]
  end
  
  def destroy
    tma = TariffModelArea.find(params[:id])
    
    ActiveRecord::Base.transaction do
      delete_tmes(tma)
      delete_calculation_options(tma)
      tma.destroy
    end
    
    redirect_to :action => :index
  end
  
  def create
    errors = []
    tma = TariffModelArea.new(params[:tariff_model_area])
    tma.audit_update_user_id = session[:user].user_name
    
    if !tma.valid?
      errors.concat tma.errors.to_a
    end
    
    if errors.empty?
      # If there are any errors, no changes should be saved
      ActiveRecord::Base.transaction do
        tma.save!
        
        if params[:calculation_options]
          errors.concat create_calculation_options(tma, params[:calculation_options].first)
        end
        
        if params[:tmes]
          errors.concat create_tmes(tma, params[:tmes])
        end
        
        # Don't throw an error until all validations are run to be sure
        # we have collected all the errror to show the user
        raise ActiveRecord::Rollback, "TMA failed validations" if errors.any?
      end # ActiveRecord::Base.transaction
    end
    
    if errors.empty?
      render json: {success: true, editUrl: edit_tariff_model_area_path(tma)}, status: :ok
    else
      render json: errors, status: :unprocessable_entity
    end
  end
  
  def calculation_options
    @tma = TariffModelArea.new(params[:tariff_model_area])
    unless @tma.tariff_model_area_version_id.empty?
      @tma = TariffModelArea.find(@tma.tariff_model_area_version_id)
      @tma.assign_attributes(params[:tariff_model_area])
    end
    
    render :partial => "calculation_options", :layout => false
  end
  
  def tmes
    @tma = TariffModelArea.new(params[:tariff_model_area])
    unless @tma.tariff_model_area_version_id.empty?
      @tma = TariffModelArea.find(@tma.tariff_model_area_version_id)
      @tma.assign_attributes(params[:tariff_model_area])
    end
    
    render :partial => "tmes", :layout => false
  end
  
  private
    def setup_sessions
      session[:tma_code] = params[:tma_code] || session[:tma_code]
      session[:tma_name] = params[:tma_name] || session[:tma_name]
      session[:measure_unit] = params[:measure_unit] || session[:measure_unit]
      session[:calculation_id] = params[:calculation_id] || session[:calculation_id]
      session[:test_mode] = params[:test_mode] || session[:test_mode]
      session[:rate_plan] = params[:rate_plan] || session[:rate_plan]
      session[:change_group] = params[:change_group] || session[:change_group]
      session[:tma_order] = params[:order] || session[:tma_order] || "tariff_model_area_code asc"
      session[:tma_amount] = params[:amount] || session[:tma_amount] || "10"
    end
    
    def create_tmes(tma, new_tmes)
      errors = []
      
      # If a single tme is invalid,
      # we need to roll back the entire operation
      ActiveRecord::Base.transaction do
        
        delete_tmes(tma)
        
        # Each submitted TME
        new_tmes.each_with_index do |new_tme, index|
          new_tme = JSON.parse(new_tme)
          
          # Create the TME Entry
          actual_tme = TariffModelEntry.new(
            :tariff_zone_code => new_tme["tariff_zone_code"],
            :tariff_time_code => new_tme["tariff_time_code"],
            :sdc_code => new_tme["sdc_code"],
            :band_sequence => new_tme["band_sequence"],
            :service_group_code => new_tme["service_group_code"],
            :billing_name_1 => new_tme["billing_name_1"],
            :tariff_model_area_version_id => tma.tariff_model_area_version_id,
            :audit_update_user_id => session[:user].user_name,
            :grid_row_number => index
          )
          
          if !actual_tme.save
            errors.concat(actual_tme.errors.to_a)
          end
          
          # Create the Calculation Option Value entries
          new_tme.select{|key, value| key =~ /^calculation_option_/}.each do |option, value|
            cov = CalculationOptionValue.new(
                       :parent_id => actual_tme.tariff_model_entry_id,
                       :tariff_model_area_version_id => tma.tariff_model_area_version_id,
                       :calculation_option_id => option[/[^_]*$/, 0],
                       :calculation_id => tma.calculation_id,
                       :calculation_option_value => value || '0',
                       :option_level_indicator => 'T',
                       :grid_row_number => index,
                       :audit_update_user_id => session[:user].user_name
            )
            
            if !cov.save
              errors.concat(cov.errors.to_a)
            end
          end # new_tme.select{|key, value| key =~ /^calculation_option_/}.each
        end # new_tmes.each_with_index
        
        raise ActiveRecord::Rollback, "TME failed validations" if errors.any?
      end # ActiveRecord::Base.transaction
      return errors
    end
    
    # Delete any existing Calculation Options linked to the TMA
    # and create new ones with the give calculations
    def create_calculation_options(tma, calculations)
      errors = []
      
      # If a single calculation option is invalid,
      # we need to roll back the entire operation
      CalculationOptionValue.transaction do
        delete_calculation_options(tma)
        
        calculations.each do |option_id, value|
          calculation_option = CalculationOption.where(
            :calculation_id => tma.calculation_id,
            :calculation_option_id => option_id
          ).first
          
          new_option = CalculationOptionValue.new(
            :parent_id => tma.tariff_model_area_version_id,
            :tariff_model_area_version_id => tma.tariff_model_area_version_id,
            :calculation_option_id => option_id,
            :calculation_option_value => value || '0',
            :calculation_id => tma.calculation_id,
            :option_level_indicator => calculation_option.option_level_indicator,
            :audit_update_user_id => session[:user].user_name
          )
          
          if !new_option.save
            errors.concat(new_option.errors.to_a)
          end
        end # calculations.each
        
        raise ActiveRecord::Rollback, "CalculationOptionValue failed validations" if errors.any?
      end # CalculationOptionValue.transaction
      
      return errors
    end
    
    def delete_calculation_options(tma)
      CalculationOptionValue.where(
        :parent_id => tma.tariff_model_area_version_id,
        :tariff_model_area_version_id => tma.tariff_model_area_version_id
      ).delete_all
    end
    
    def delete_tmes(tma)
      TariffModelEntry.where(
        :tariff_model_area_version_id => tma.tariff_model_area_version_id
      ).delete_all
      
      # Delete all calculation options for TMEs tab
      CalculationOptionValue.where(
        :tariff_model_area_version_id => tma.tariff_model_area_version_id,
        :option_level_indicator => 'T'
      ).delete_all
    end
end
