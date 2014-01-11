class RateRowsController < ApplicationController
  
  def index
    setup_sessions
    @table = RateTable.get(params[:rate_table_id])
    @rows = @table.rows_with_common_rates(session[:rate_table_name],
                                          session[:template_name],
                                          session[:template_code],
                                          session[:rate_table_status])
        .page(params[:page])
        .per(session[:rate_rows_amount])
  end
  
  
  private
  
    def setup_sessions
      session[:rate_rows_amount] = params[:amount] || session[:rate_rows_amount] || "10"
      session[:rate_table_status] = params[:rate_table_status] || session[:rate_table_status]
      session[:rate_table_name] = params[:rate_table_name] || session[:rate_table_name]
      session[:template_name] = params[:template_name] || session[:template_name]
      session[:template_code] = params[:template_code] || session[:template_code]
    end
end