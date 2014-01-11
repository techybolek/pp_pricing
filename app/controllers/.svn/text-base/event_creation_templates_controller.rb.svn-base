class EventCreationTemplatesController < ApplicationController
  def index
    setup_sessions
    
    @ects = EventCreationTemplate.search(
      session[:ect_filters].clone
    ).order(
      session[:ect_filters][:order]
    ).page(
      params[:page]
    ).per(
      session[:ect_filters][:amount]
    )
  end
  
  protected
    def setup_sessions
      session[:ect_filters] = params[:ect_filters] || session[:ect_filters] || {
        ect_code: '',
        ect_name: '',
        effective_status: '',
        usage_mode_value: '',
        test_mode_ind: '',
        change_group_id: '',
        charge_occurrence_type: '',
        amount: '10',
        search_all_versions: false
      }
      
      session[:ect_filters][:order] = params[:order] || session[:ect_filters][:order] || 'ect.code asc'
    end
end
