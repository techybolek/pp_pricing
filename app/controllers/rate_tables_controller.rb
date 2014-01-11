class RateTablesController < ApplicationController
  
  def index
    setup_sessions
    @tables = RateTable.search(session[:rate_table_name],
                 session[:rate_table_status],
                 session[:usage_template_name],
                 session[:usage_template_code])
              .order(session[:rate_table_order])
              .page(params[:page])
              .per(session[:rate_table_amount])
  end
  
  def show
    @table = RateTable.get(params[:id] || params[:rate_table_id])
    @new_rows = RateRow.where(:rate_row_id => params[:rate_rows])
  end
  
  def new
    @table = RateTable.new
  end
  
  def update
    table = RateTable.get(params[:rate_table_id])
    new_row_ids = {}
    errors = []
    
    # If there are any errors, no changes should be saved
    ActiveRecord::Base.transaction do
      # Save Table-Level changes
      if !table.update_attributes(params[:rate_table])
        errors.concat(table.errors.to_a)
      end
      
      # Delete Removed Rows
      RateRow.transaction do
        params[:delete_rows] ||= {}
        params[:delete_rows].each do |row_id|
          RateRow.delete_all(:rate_row_id => row_id)
          RateCell.delete_all(:rate_row_id => row_id)
        end
      end
      
      # Update Existing Rows
      RateRow.transaction do
        params[:existing_rows] ||= {}
        params[:existing_rows].each do |row_id, values|
          row = RateRow.get(row_id)
          if row.save
            values.each do |rate_id, value|
              cell = row.get_cell(rate_id)
              if !cell.update_attributes(:value => value)
                errors.concat(cell.errors.to_a)
              end
            end
          else
            errors.concat(row.errors.to_a)
          end
        end
        if !errors.empty?
          # Don't throw an error until all validations are run to be sure
          # we have collected all the errror first
          raise ActiveRecord::Rollback, "Existing Rate Rows failed validation"
        end
      end
      
      # Create New Rows
      RateRow.transaction do
        params[:new_rows] ||= {}
        params[:new_rows].each do |row_num, values|
          new_row = RateRow.new(:audit_user => session[:user].user_name,
                      :effective_status => 'DRAFT',
                      :effective_date => DateTime.now)
          new_row.rate_table_id = table.rate_table_id
          if new_row.save
            new_row_ids[row_num] = new_row.rate_row_id
            # Create Rate Cells
            rates = Rate.for_template(table.template_id)
            rates.each do |rate|
              rate_cell = RateCell.new
              rate_cell.rate_row_id = new_row.rate_row_id
              rate_cell.rate_id = rate.rate_id
              rate_cell.rate_table_id = table.rate_table_id
              rate_cell.value = values[rate.rate_id]
              if !rate_cell.save
                errors.concat(rate_cell.errors.to_a)
              end
            end
          else
            errors.concat(new_row.errors.to_a)
          end
        end
        if !errors.empty?
          # Don't throw an error until all validations are run to be sure
          # we have collected all the errror first
          raise ActiveRecord::Rollback, "Rate Rows failed validation"
        end
      end
      
      # If there are errors at this point, go ahead and quit without 
      # checking for duplicate rows
      raise ActiveRecord::Rollback, "There were errors updating the rate table" if errors.any?
      
      # Make sure there are no duplicate rows
      rows = table.rate_rows
      normalized_rows = []
      rows.each do |row|
        cells = row.get_cells(table.template_id)
        normalized_row = ''
        cells.each do |cell|
          normalized_row += "#{cell.value},"
        end
        if normalized_rows.include?(normalized_row)
          # this is an expensive search, quit on first error
          errors << "One or more rows are duplicates, each row much be unique"
          raise ActiveRecord::Rollback, "Rate table has duplicate rows"
        else
          normalized_rows << normalized_row
        end
      end
    end
    
    if errors.empty?
      render json: {success: true, newIds: new_row_ids}, status: :ok
    else
      render json: errors, status: :unprocessable_entity
    end
  end
  
  def create
    @table = RateTable.new(params[:rate_table])
    @table.effective_date = DateTime.now
    @table.effective_status = 'DRAFT'
    @table.audit_user = session[:user].user_name
    if @table.save
      flash[:success] = "Rate Table successfully created"
      redirect_to @table
    else
      render :new
    end
  end
  
  def destroy
    RateTable.transaction do
      RateCell.delete_all(:rate_table_id=>params[:id])
      RateRow.delete_all(:rate_table_id=>params[:id])
      RateTable.delete_all(:rate_table_id=>params[:id])
      flash[:success] = "Rate table successfully deleted"
    end
    
    redirect_to :action => :index
  end
  
    private
      
      def setup_sessions
        session[:usage_template_name] = params[:template_name] || session[:usage_template_name]
        session[:usage_template_code] = params[:template_code] || session[:usage_template_code]
        session[:rate_table_name]     = params[:rate_table_name] || session[:rate_table_name]
        session[:rate_table_status]   = params[:rate_table_status] || session[:rate_table_status]
        session[:rate_table_order]    = params[:order] || session[:rate_table_order] || "title asc"
        session[:rate_table_amount]   = params[:amount] || session[:rate_table_amount] || "10"
      end
end
