class InitRateTables < ActiveRecord::Migration
  def up
    # Templates
    create_table :templates, :id => false do |t|
      t.string  :template_id,
                :null => false,
                :limit => 20
      t.string  :template_name,
                :null => false,
                :limit => 20
      t.date    :effective_date,
                :null => false
      t.string  :effective_status,
                :null => false,
                :limit => 6
      t.string  :template_code,
                :null => false,
                :limit => 10
    end
    
    # Template Definitions
    create_table :template_definitions, :id => false do |t|
      t.string  :template_id,
                :null => false,
                :limit => 20
      t.string  :rate_id,
                :null => false,
                :limit => 20
      t.integer :column_position,
                :null => false
    end
    
    # Rates
    create_table :rates, :id => false, :primary_key => :rate_id do |t|
      t.string  :rate_id,
                :unique => true,
                :null => false,
                :limit => 20
      t.string  :rate_code,
                :unique => true,
                :null => false,
                :limit => 10
      t.string  :group_code,
                :limit => 10
      t.string  :data_type,
                :null => false,
                :limit => 10
      t.boolean :min_charge_applies
      t.integer :precision
      t.string  :rtti_path,
                :limit => 100
      t.string  :title,
                :null => false,
                :limit => 50
      t.string  :billing_code,
                :limit => 10
      t.string  :criteria,
                :limit => 100
      t.string  :evaluation_order,
                :limit => 10
      t.boolean :nullable,
                :null => false
      t.string  :rate_type,
                :limit => 15
    end
    
    # Rate Tables
    create_table :rate_tables, :id => false do |t|
      t.string  :rate_table_id,
                :null => false,
                :limit => 20
      t.date    :effective_date,
                :null => false
      t.string  :effective_status,
                :null => false,
                :limit => 6
      #t.string  :rate_table_status,
      #          :null => false,
      #          :limit => 16
      t.string  :template_id,
                :null => false,
                :limit => 20
      t.string  :error_message,
                :limit => 255
      t.string  :audit_user,
                :null => false,
                :limit => 15
      t.string  :title,
                :null => false,
                :limit => 50
    end
    
    # Rate Rows
    create_table :rate_rows, :id => false do |t|
      t.string  :rate_row_id,
                :null => false,
                :limit => 20
      t.string  :rate_table_id,
                :null => false,
                :limit => 20
      t.string  :completer,
                :limit => 15
      t.boolean :delete_allowed,
                :null => false
      t.string  :error_message,
                :limit => 255
      t.date    :effective_date,
                :null => false
      t.string  :effective_status,
                :null => false,
                :limit => 6
      t.string  :audit_user,
                :null => false,
                :limit => 15
    end
    
    # Rate Cells
    create_table :rate_cells, :id => false, :primary_key => :rate_cell_id do |t|
      t.string  :rate_cell_id,
                :null => false,
                :limit => 20,
                :unique => true
      t.string  :rate_id,
                :null => false,
                :limit => 20
      t.string  :rate_row_id,
                :null => false,
                :limit => 20
      t.string  :rate_table_id,
                :null => false,
                :limit => 20
      t.string  :value,
                :limit => 60
    end
    
    # Overridden Rates
    create_table :overridden_rates, :id => false, :primary_key => :overridden_rate_id do |t|
      t.string  :overridden_rate_id,
                :null => false,
                :limit => 20,
                :unique => true
      t.string  :rate_cell_id,
                :null => false,
                :limit => 20
      t.string  :commitment_id,
                :null => false,
                :limit => 16
      t.string  :customer_number,
                :limit => 20
      t.string  :value,
                :limit => 60
    end
    
    # Edit TMA table
    add_column(:tariff_model_area, :rate_table_id, :string, :limit => 120)
  end

  def down
    drop_table :templates
    drop_table :template_definitions
    #drop_table :translations
    drop_table :rates
    drop_table :rate_tables
    drop_table :rate_rows
    drop_table :rate_cells
    drop_table :overridden_rates
    remove_column(:tariff_model_area, :rate_table_id)
  end
end
