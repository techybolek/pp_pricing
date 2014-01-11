# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130509185636) do

  create_table "access_information", :id => false, :force => true do |t|
    t.string   "entity_id",                  :limit => 16,                                 :null => false
    t.string   "access_information_id",      :limit => 16,                                 :null => false
    t.datetime "effective_date",                                                           :null => false
    t.string   "effective_status",           :limit => 6,                                  :null => false
    t.string   "access_information_type_rd", :limit => 16,                                 :null => false
    t.string   "audit_update_user_id",       :limit => 15,                                 :null => false
    t.datetime "audit_update_date_time",                                                   :null => false
    t.integer  "update_number",              :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.string   "contact_name",               :limit => 60
    t.string   "email_address",              :limit => 129
    t.string   "fax_number",                 :limit => 32
    t.string   "phone_number",               :limit => 32
  end

  add_index "access_information", ["email_address"], :name => "accinf_ind1", :tablespace => "indexes"

  create_table "access_number", :primary_key => "access_number_id", :force => true do |t|
    t.string   "type_rd",                 :limit => 16,                                 :null => false
    t.string   "config_service_char_id",  :limit => 16,                                 :null => false
    t.string   "customer_number",         :limit => 20,                                 :null => false
    t.string   "masking_digits_rd",       :limit => 16,                                 :null => false
    t.string   "retention_period_rd",     :limit => 16,                                 :null => false
    t.string   "allow_count_mod_ind",     :limit => 1,                                  :null => false
    t.string   "audit_update_user_id",    :limit => 15,                                 :null => false
    t.datetime "audit_update_date_time",                                                :null => false
    t.integer  "update_number",           :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.integer  "ep_access_number_rd",     :limit => 4,   :precision => 4,  :scale => 0, :null => false
    t.string   "ep_access_number_string", :limit => 360
    t.string   "number_of_lines_string",  :limit => 10
    t.string   "access_number",           :limit => 360
    t.decimal  "usage_limit_amount",                     :precision => 18, :scale => 6
    t.string   "start_range_string",      :limit => 64
    t.string   "end_range_string",        :limit => 64
    t.string   "ep_end_range_string",     :limit => 64
  end

  add_index "access_number", ["access_number", "end_range_string"], :name => "er_accn_ind", :tablespace => "indexes"
  add_index "access_number", ["config_service_char_id"], :name => "accnum_configsc_ind", :tablespace => "indexes"
  add_index "access_number", ["customer_number"], :name => "cn_accn_ind", :tablespace => "indexes"
  add_index "access_number", ["start_range_string", "access_number_id"], :name => "srs_accn_i", :tablespace => "indexes"

  create_table "account", :id => false, :force => true do |t|
    t.string   "account_number",             :limit => 20,                                :null => false
    t.datetime "effective_date",                                                          :null => false
    t.string   "customer_number",            :limit => 20,                                :null => false
    t.string   "document_pattern_id",        :limit => 16,                                :null => false
    t.string   "method_of_payment_rd",       :limit => 16,                                :null => false
    t.string   "manual_suspend_indicator",   :limit => 1,                                 :null => false
    t.string   "state_rd",                   :limit => 16,                                :null => false
    t.string   "effective_status",           :limit => 6,                                 :null => false
    t.string   "currency_rd",                :limit => 16,                                :null => false
    t.string   "cycle_name",                 :limit => 30,                                :null => false
    t.string   "document_template_name",     :limit => 30,                                :null => false
    t.string   "language_rd",                :limit => 16,                                :null => false
    t.string   "mailing_id",                 :limit => 16,                                :null => false
    t.string   "payment_term_rd",            :limit => 16,                                :null => false
    t.string   "zero_charge_indicator",      :limit => 1,                                 :null => false
    t.decimal  "usage_limit",                              :precision => 18, :scale => 6, :null => false
    t.datetime "state_date",                                                              :null => false
    t.string   "output_device_rd",           :limit => 16,                                :null => false
    t.string   "special_handling_rd",        :limit => 16,                                :null => false
    t.datetime "audit_update_date_time",                                                  :null => false
    t.string   "audit_update_user_id",       :limit => 15,                                :null => false
    t.integer  "update_number",              :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "bank_account_id",            :limit => 16
    t.string   "credit_card_id",             :limit => 16
    t.string   "customer_account_id",        :limit => 35
    t.string   "description",                :limit => 60
    t.datetime "direct_debit_authoriz_date"
  end

  add_index "account", ["customer_account_id"], :name => "acct_ind3", :tablespace => "indexes"
  add_index "account", ["customer_number"], :name => "acct_cust_i", :tablespace => "indexes"
  add_index "account", ["cycle_name"], :name => "acct_ind1", :tablespace => "indexes"

  create_table "account_info", :id => false, :force => true do |t|
    t.string   "account_number",  :limit => 20,  :null => false
    t.string   "attribute_name",  :limit => 30,  :null => false
    t.datetime "start_date",                     :null => false
    t.datetime "end_date"
    t.string   "attribute_value", :limit => 360, :null => false
  end

  create_table "account_rerate_pool", :primary_key => "account_number", :force => true do |t|
  end

  create_table "account_threshold_exceeded", :id => false, :force => true do |t|
    t.string   "account_number",            :limit => 20,                                :null => false
    t.datetime "bill_period_end_date_time",                                              :null => false
    t.string   "threshold_rule_set_code",   :limit => 5,                                 :null => false
    t.string   "threshold_rule_code",       :limit => 5,                                 :null => false
    t.string   "cycle_name",                :limit => 30,                                :null => false
    t.decimal  "amount",                                  :precision => 18, :scale => 6, :null => false
    t.string   "audit_update_user_id",      :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                 :null => false
    t.integer  "update_number",             :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  create_table "account_threshold_limit", :id => false, :force => true do |t|
    t.string   "account_number",          :limit => 20,                                :null => false
    t.string   "threshold_rule_set_code", :limit => 5,                                 :null => false
    t.decimal  "amount",                                :precision => 18, :scale => 6, :null => false
    t.string   "audit_update_user_id",    :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                               :null => false
    t.integer  "update_number",           :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  create_table "accrual_run", :primary_key => "accrual_acct_table_name", :force => true do |t|
    t.string  "state_rd",           :limit => 16,                                :null => false
    t.integer "entry_count_number", :limit => 10, :precision => 10, :scale => 0, :null => false
  end

# Could not dump table "accrual_summary" because of following StandardError
#   Unknown type 'XMLTYPE' for column 'user_data_xml'

  create_table "action_rule", :id => false, :force => true do |t|
    t.string   "action_rule_name",       :limit => 30,                                 :null => false
    t.datetime "effective_date",                                                       :null => false
    t.string   "effective_status",       :limit => 6,                                  :null => false
    t.string   "condition_name",         :limit => 30,                                 :null => false
    t.string   "action_name",            :limit => 30,                                 :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                 :null => false
    t.datetime "audit_update_date_time",                                               :null => false
    t.integer  "update_number",          :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.string   "description",            :limit => 60
    t.string   "group_key_text",         :limit => 360
    t.string   "sort_key_text",          :limit => 360
  end

  create_table "active_pricacctab", :primary_key => "pricacctab_table_name", :force => true do |t|
    t.datetime "bill_period_start_date_time",                                                :null => false
    t.datetime "bill_period_end_date_time",                                                  :null => false
    t.integer  "external_input_count_value",    :limit => 4,  :precision => 4,  :scale => 0, :null => false
    t.integer  "completed_process_count_value", :limit => 4,  :precision => 4,  :scale => 0, :null => false
    t.string   "audit_update_user_id",          :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                     :null => false
    t.integer  "update_number",                 :limit => 10, :precision => 10, :scale => 0, :null => false
    t.datetime "request_start_date_time"
    t.string   "pricing_status_code",           :limit => 5
    t.string   "external_input_status_code",    :limit => 5
  end

  create_table "activity_wkfl_sel_rule", :primary_key => "activity_wkfl_sel_rule_id", :force => true do |t|
    t.string   "library_item_name",      :limit => 30,                                :null => false
    t.string   "level_rd",               :limit => 16,                                :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
    t.integer  "update_number",          :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "standard_indicator",     :limit => 1
    t.string   "logue_indicator",        :limit => 1
    t.string   "customer_category_rd",   :limit => 16
  end

  create_table "address", :id => false, :force => true do |t|
    t.string   "entity_id",                      :limit => 16,                                :null => false
    t.string   "address_id",                     :limit => 16,                                :null => false
    t.datetime "effective_date",                                                              :null => false
    t.string   "country_rd",                     :limit => 16,                                :null => false
    t.string   "effective_status",               :limit => 6,                                 :null => false
    t.string   "address_type_rd",                :limit => 16,                                :null => false
    t.string   "city_name",                      :limit => 40,                                :null => false
    t.string   "audit_update_user_id",           :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                      :null => false
    t.integer  "update_number",                  :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "address_format_indicator",       :limit => 1
    t.string   "street_number",                  :limit => 10
    t.string   "street_number_suffix",           :limit => 10
    t.string   "additional_address_description", :limit => 35
    t.string   "second_add_address_description", :limit => 35
    t.string   "city_suffix_name",               :limit => 30
    t.string   "postal_code",                    :limit => 10
    t.string   "province_name",                  :limit => 30
    t.string   "street_name",                    :limit => 40
    t.string   "post_office_box",                :limit => 10
    t.string   "region_rd",                      :limit => 16
    t.string   "carrier_route_string",           :limit => 4
  end

  add_index "address", ["address_id"], :name => "addr_ind", :tablespace => "indexes"
  add_index "address", ["postal_code"], :name => "addr_ind2", :tablespace => "indexes"

  create_table "adjunct_account", :id => false, :force => true do |t|
    t.string   "account_number",          :limit => 20,                                :null => false
    t.datetime "effective_date",                                                       :null => false
    t.string   "effective_status",        :limit => 6,                                 :null => false
    t.string   "cycle_name",              :limit => 30,                                :null => false
    t.string   "audit_update_user_id",    :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                               :null => false
    t.integer  "update_number",           :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "document_template_name",  :limit => 30
    t.string   "language_rd",             :limit => 16
    t.string   "currency_rd",             :limit => 16
    t.string   "name",                    :limit => 60
    t.string   "rating_effective_status", :limit => 6,                                 :null => false
  end

  create_table "adjunct_account_characteristic", :id => false, :force => true do |t|
    t.string   "account_number",         :limit => 20,                                  :null => false
    t.string   "characteristic_name",    :limit => 20,                                  :null => false
    t.string   "characteristic_value",   :limit => 4000,                                :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                  :null => false
    t.datetime "audit_update_date_time",                                                :null => false
    t.integer  "update_number",          :limit => 10,   :precision => 10, :scale => 0, :null => false
  end

  create_table "adjunct_configured_value", :id => false, :force => true do |t|
    t.string   "service_subscription_id",     :limit => 16,                                :null => false
    t.string   "service_characteristic_code", :limit => 5,                                 :null => false
    t.datetime "effective_date",                                                           :null => false
    t.string   "effective_status",            :limit => 6,                                 :null => false
    t.string   "audit_update_user_id",        :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                   :null => false
    t.integer  "update_number",               :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "measure_unit_code",           :limit => 5
    t.string   "configured_value",            :limit => 30
  end

  create_table "adjunct_promotion_subscription", :id => false, :force => true do |t|
    t.string   "promotion_subscription_id", :limit => 16,                                :null => false
    t.string   "service_subscription_id",   :limit => 16,                                :null => false
    t.string   "promotion_code",            :limit => 5,                                 :null => false
    t.datetime "apply_date",                                                             :null => false
    t.datetime "termination_date",                                                       :null => false
    t.string   "account_number",            :limit => 20,                                :null => false
    t.string   "audit_update_user_id",      :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                 :null => false
    t.integer  "update_number",             :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  create_table "adjunct_promotion_term_subscr", :id => false, :force => true do |t|
    t.string   "promotion_subscription_id", :limit => 16,                                :null => false
    t.string   "promotion_term_id",         :limit => 16,                                :null => false
    t.string   "promotion_term_subscr_id",  :limit => 16,                                :null => false
    t.datetime "start_date",                                                             :null => false
    t.datetime "end_date",                                                               :null => false
    t.string   "audit_update_user_id",      :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                 :null => false
    t.integer  "update_number",             :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  create_table "adjunct_serv_subscr_tax_desc", :id => false, :force => true do |t|
    t.string   "service_subscription_id",   :limit => 16,                                :null => false
    t.string   "tax_jurisdiction_state",    :limit => 2,                                 :null => false
    t.string   "tax_jurisdiction_county",   :limit => 3,                                 :null => false
    t.string   "tax_jurisdiction_city",     :limit => 4,                                 :null => false
    t.string   "tax_jurisdiction_sub",      :limit => 3,                                 :null => false
    t.string   "incorporated_code",         :limit => 1,                                 :null => false
    t.integer  "subscr_num_of_lines_value", :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "audit_update_user_id",      :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                 :null => false
    t.integer  "update_number",             :limit => 10, :precision => 10, :scale => 0, :null => false
    t.datetime "start_date",                                                             :null => false
    t.datetime "end_date"
    t.string   "tax_code_rd",               :limit => 16
  end

  create_table "adjunct_tax_exemption", :id => false, :force => true do |t|
    t.string   "account_number",            :limit => 20,                                :null => false
    t.string   "exempt_authority",          :limit => 1,                                 :null => false
    t.string   "exempt_jurisdiction",       :limit => 9,                                 :null => false
    t.string   "tax_type_value",            :limit => 2,                                 :null => false
    t.string   "customer_tax_exemption_id", :limit => 16,                                :null => false
    t.datetime "effective_date",                                                         :null => false
    t.string   "effective_status",          :limit => 6,                                 :null => false
    t.string   "audit_update_user_id",      :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                 :null => false
    t.integer  "update_number",             :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  create_table "adjustment_interface", :id => false, :force => true do |t|
    t.string   "account_number",            :limit => 20,                                 :null => false
    t.string   "adjustment_id",             :limit => 16,                                 :null => false
    t.datetime "create_date",                                                             :null => false
    t.string   "create_user_id",            :limit => 15,                                 :null => false
    t.string   "type_rd",                   :limit => 16,                                 :null => false
    t.decimal  "base_currency_amount",                     :precision => 18, :scale => 6, :null => false
    t.datetime "start_date",                                                              :null => false
    t.string   "preferred_currency_rd",     :limit => 16,                                 :null => false
    t.decimal  "preferred_currency_amount",                :precision => 18, :scale => 6, :null => false
    t.integer  "recurring_duration",        :limit => 4,   :precision => 4,  :scale => 0, :null => false
    t.string   "state_rd",                  :limit => 16,                                 :null => false
    t.string   "erp_state_rd",              :limit => 16,                                 :null => false
    t.integer  "erp_recurring_duration",    :limit => 4,   :precision => 4,  :scale => 0, :null => false
    t.datetime "erp_start_date",                                                          :null => false
    t.datetime "audit_update_date_time",                                                  :null => false
    t.string   "audit_update_user_id",      :limit => 15,                                 :null => false
    t.integer  "update_number",             :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.string   "internal_reason_text",      :limit => 360
    t.string   "description_text",          :limit => 360
    t.string   "event_id",                  :limit => 30
    t.string   "reason_code_rd",            :limit => 16
    t.string   "tax_code_rd",               :limit => 16
    t.datetime "resolution_date"
    t.string   "resolution_user_id",        :limit => 15
    t.datetime "new_start_date"
    t.integer  "invoice_sequence_number",   :limit => 10,  :precision => 10, :scale => 0
    t.string   "product_code",              :limit => 5
    t.string   "invoice_id",                :limit => 20
    t.string   "tax_jurisdiction_state",    :limit => 2
    t.string   "tax_jurisdiction_county",   :limit => 3
    t.string   "tax_jurisdiction_city",     :limit => 4
    t.string   "tax_jurisdiction_sub",      :limit => 3
    t.string   "tax_incorporated_code",     :limit => 1
    t.string   "accounting_code_string",    :limit => 20
  end

  create_table "affinity_group", :id => false, :force => true do |t|
    t.string   "customer_number",        :limit => 20,                                :null => false
    t.string   "affinity_group_rd",      :limit => 16,                                :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
    t.integer  "update_number",          :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  create_table "algorithm", :primary_key => "algorithm_id", :force => true do |t|
    t.string   "name",                   :limit => 30,                                 :null => false
    t.string   "comment_id",             :limit => 16,                                 :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                 :null => false
    t.datetime "audit_update_date_time",                                               :null => false
    t.integer  "update_number",          :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.string   "type_indicator",         :limit => 1,                                  :null => false
    t.string   "test_mode_ind",          :limit => 1
    t.string   "promotion_ind",          :limit => 1
    t.string   "rate_plan_code",         :limit => 5
    t.datetime "effective_date"
    t.string   "effective_status",       :limit => 6
    t.string   "fractionalization_ind",  :limit => 1
    t.string   "descriptive_text",       :limit => 360
    t.string   "change_group_id",        :limit => 30
    t.string   "billing_name_1",         :limit => 60
    t.string   "billing_name_2",         :limit => 60
  end

  add_index "algorithm", ["change_group_id"], :name => "alg_idx"
  add_index "algorithm", ["rate_plan_code"], :name => "alg_rpc_ind"

  create_table "algorithm_selection_rule", :primary_key => "selection_rule_id", :force => true do |t|
    t.string   "price_plan_version_id",  :limit => 16,                                :null => false
    t.string   "target_type",            :limit => 2,                                 :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
    t.integer  "update_number",          :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "algorithm_id",           :limit => 16
    t.string   "condition_id",           :limit => 16
    t.string   "true_rule_id",           :limit => 16
    t.string   "false_rule_id",          :limit => 16
  end

  add_index "algorithm_selection_rule", ["algorithm_id"], :name => "asr_alg_fk_i", :tablespace => "indexes"
  add_index "algorithm_selection_rule", ["condition_id"], :name => "asr_src_fk_i", :tablespace => "indexes"
  add_index "algorithm_selection_rule", ["price_plan_version_id"], :name => "asr_pp1_fk_i", :tablespace => "indexes"

  create_table "allowance", :id => false, :force => true do |t|
    t.string   "account_number",             :limit => 20,                                :null => false
    t.integer  "invoice_sequence_number",    :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "price_plan_subscription_id", :limit => 16,                                :null => false
    t.string   "tme_id",                     :limit => 16,                                :null => false
    t.string   "partition_group",            :limit => 30,                                :null => false
    t.datetime "partition_date_time",                                                     :null => false
    t.string   "rerate_indicator",           :limit => 1,                                 :null => false
    t.datetime "latest_qualified_date_time"
    t.datetime "rerate_as_of_date_time"
    t.integer  "remaining_allowance_number", :limit => 20, :precision => 20, :scale => 0
    t.integer  "overage_amount_number",      :limit => 20, :precision => 20, :scale => 0
    t.string   "state_rd",                   :limit => 16
  end

  create_table "api_statistic", :id => false, :force => true do |t|
    t.string   "process_name",           :limit => 30,                                :null => false
    t.string   "process_instance",       :limit => 30,                                :null => false
    t.string   "host_name",              :limit => 30,                                :null => false
    t.datetime "cycle_start_time",                                                    :null => false
    t.datetime "cycle_end_time",                                                      :null => false
    t.string   "method_name",            :limit => 60,                                :null => false
    t.string   "signature_name",         :limit => 60,                                :null => false
    t.integer  "success_count",          :limit => 10, :precision => 10, :scale => 0, :null => false
    t.integer  "error_count",            :limit => 10, :precision => 10, :scale => 0, :null => false
    t.decimal  "duration",                             :precision => 15, :scale => 3, :null => false
    t.integer  "update_number",          :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
  end

  create_table "applied_process_step", :id => false, :force => true do |t|
    t.integer "roc_timeline_relid",           :limit => 20, :precision => 20, :scale => 0, :null => false
    t.string  "rate_plan_code",               :limit => 5,                                 :null => false
    t.integer "process_step_order",           :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string  "algorithm_id",                 :limit => 16,                                :null => false
    t.string  "tariff_model_area_version_id", :limit => 16,                                :null => false
    t.decimal "final_charge",                               :precision => 18, :scale => 6, :null => false
    t.decimal "initial_charge",                             :precision => 18, :scale => 6, :null => false
    t.string  "tariff_model_area_code",       :limit => 5,                                 :null => false
    t.string  "process_step_id",              :limit => 16,                                :null => false
  end

  create_table "applied_rate_plan", :id => false, :force => true do |t|
    t.integer  "roc_timeline_relid",        :limit => 20, :precision => 20, :scale => 0, :null => false
    t.string   "rate_plan_code",            :limit => 5,                                 :null => false
    t.datetime "rate_plan_effective_date",                                               :null => false
    t.string   "promotion_subscription_id", :limit => 16
  end

  create_table "applied_tme", :id => false, :force => true do |t|
    t.integer "roc_timeline_relid",        :limit => 20, :precision => 20, :scale => 0, :null => false
    t.string  "rate_plan_code",            :limit => 5,                                 :null => false
    t.integer "process_step_order",        :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string  "tariff_model_entry_id",     :limit => 16,                                :null => false
    t.integer "rated_unit_volume",         :limit => 20, :precision => 20, :scale => 0, :null => false
    t.integer "unit_measure_enum",         :limit => 3,  :precision => 3,  :scale => 0, :null => false
    t.integer "unit_volume",               :limit => 20, :precision => 20, :scale => 0, :null => false
    t.decimal "rated_charge",                            :precision => 18, :scale => 6, :null => false
    t.string  "customer_specific_rate_id", :limit => 16
  end

  add_index "applied_tme", ["tariff_model_entry_id"], :name => "applied_tme_ind1", :tablespace => "indexes"

  create_table "backout_events_history", :id => false, :force => true do |t|
    t.string   "event_unique_id",              :limit => 30,                                :null => false
    t.datetime "insert_date_time",                                                          :null => false
    t.string   "partition_group",              :limit => 30,                                :null => false
    t.datetime "partition_date_time",                                                       :null => false
    t.string   "account_number",               :limit => 20,                                :null => false
    t.integer  "invoice_sequence_number",      :limit => 10, :precision => 10, :scale => 0, :null => false
    t.integer  "request_idnumber",             :limit => 10, :precision => 10, :scale => 0
    t.datetime "xref_start_date_time"
    t.integer  "re_rate_file_sequence_number", :limit => 10, :precision => 10, :scale => 0
  end

  create_table "band", :id => false, :force => true do |t|
    t.integer  "band_sequence",                :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "tariff_tier_taper_version_id", :limit => 16,                                :null => false
    t.decimal  "min_value",                                  :precision => 18, :scale => 6, :null => false
    t.decimal  "max_value",                                  :precision => 18, :scale => 6, :null => false
    t.string   "audit_update_user_id",         :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                    :null => false
    t.integer  "update_number",                :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "billing_name_1",               :limit => 30
    t.string   "billing_name_2",               :limit => 30
  end

  add_index "band", ["tariff_tier_taper_version_id"], :name => "ban_ttt_fk_i", :tablespace => "indexes"

  create_table "bank_account", :id => false, :force => true do |t|
    t.string   "customer_number",        :limit => 20,                                :null => false
    t.string   "bank_account_id",        :limit => 16,                                :null => false
    t.datetime "effective_date",                                                      :null => false
    t.string   "bank_account_number",    :limit => 18,                                :null => false
    t.string   "effective_status",       :limit => 6,                                 :null => false
    t.string   "owner_full_name",        :limit => 60,                                :null => false
    t.string   "bank_clearing_code",     :limit => 9,                                 :null => false
    t.string   "bank_country_code_rd",   :limit => 16,                                :null => false
    t.string   "bank_name_and_city_rd",  :limit => 64,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.integer  "update_number",          :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  add_index "bank_account", ["bank_account_id"], :name => "bnkacct_ind2", :tablespace => "indexes"
  add_index "bank_account", ["bank_account_number"], :name => "bnkacct_ind1", :tablespace => "indexes"

  create_table "batch_pattern", :id => false, :force => true do |t|
    t.integer  "production_batch_idnumber",   :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "document_pattern_id",         :limit => 20,                                :null => false
    t.string   "invoice_template_ind",        :limit => 1,                                 :null => false
    t.string   "pricing_indicator",           :limit => 1,                                 :null => false
    t.string   "bill_verification_indicator", :limit => 1,                                 :null => false
    t.string   "account_number",              :limit => 20
    t.integer  "sequence_number",             :limit => 10, :precision => 10, :scale => 0
    t.datetime "bill_period_start_date"
  end

  add_index "batch_pattern", ["document_pattern_id"], :name => "bp_dpi_fk_i", :tablespace => "indexes"
  add_index "batch_pattern", ["production_batch_idnumber", "document_pattern_id", "account_number", "sequence_number"], :name => "bp_uk", :unique => true, :tablespace => "indexes"

  create_table "bill_period", :id => false, :force => true do |t|
    t.string   "account_number",          :limit => 20,                                :null => false
    t.integer  "sequence_number",         :limit => 10, :precision => 10, :scale => 0, :null => false
    t.datetime "start_date_time",                                                      :null => false
    t.datetime "end_date_time",                                                        :null => false
    t.string   "suppressed_indicator",    :limit => 1,                                 :null => false
    t.string   "state_code",              :limit => 5,                                 :null => false
    t.string   "class_id",                :limit => 20,                                :null => false
    t.string   "cycle_name",              :limit => 30,                                :null => false
    t.string   "approval_status",         :limit => 6,                                 :null => false
    t.string   "pricing_status",          :limit => 6,                                 :null => false
    t.integer  "sub_sequence_number",     :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "partition_group",         :limit => 30,                                :null => false
    t.string   "type_string",             :limit => 20,                                :null => false
    t.datetime "bill_date_time"
    t.integer  "production_run_idnumber", :limit => 10, :precision => 10, :scale => 0
  end

  create_table "bill_report", :primary_key => "document_id", :force => true do |t|
    t.decimal  "new_gross_charge_amount",                      :precision => 18, :scale => 6, :null => false
    t.decimal  "new_net_charge_amount",                        :precision => 18, :scale => 6, :null => false
    t.decimal  "tax_charge_amount",                            :precision => 18, :scale => 6, :null => false
    t.integer  "production_batch_idnumber",      :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "currency_rd",                    :limit => 10,                                :null => false
    t.integer  "duration_volume",                :limit => 10, :precision => 10, :scale => 0, :null => false
    t.integer  "event_number_volume",            :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "audit_update_user_id",           :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                      :null => false
    t.string   "invoice_id",                     :limit => 20
    t.string   "account_number",                 :limit => 20
    t.datetime "payment_due_date_time"
    t.integer  "start_sequence_number",          :limit => 10, :precision => 10, :scale => 0
    t.integer  "end_sequence_number",            :limit => 10, :precision => 10, :scale => 0
    t.integer  "sub_sequence_number",            :limit => 10, :precision => 10, :scale => 0
    t.datetime "start_date_time"
    t.datetime "end_date_time"
    t.string   "suppression_reason_description", :limit => 30
  end

  add_index "bill_report", ["account_number", "start_sequence_number", "end_sequence_number"], :name => "br_ind2", :tablespace => "indexes"
  add_index "bill_report", ["invoice_id"], :name => "br_uc1", :unique => true, :tablespace => "indexes"
  add_index "bill_report", ["production_batch_idnumber"], :name => "br_ind1", :tablespace => "indexes"

  create_table "billing_characteristic", :id => false, :force => true do |t|
    t.string   "billing_characteristic_name", :limit => 30,                                 :null => false
    t.string   "group_name",                  :limit => 30,                                 :null => false
    t.string   "domain_header_name",          :limit => 30,                                 :null => false
    t.string   "class_name",                  :limit => 30,                                 :null => false
    t.string   "field_text",                  :limit => 360,                                :null => false
    t.integer  "update_number",               :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.string   "audit_update_user_id",        :limit => 15,                                 :null => false
    t.datetime "audit_update_date_time",                                                    :null => false
    t.string   "object_name",                 :limit => 30
    t.string   "description",                 :limit => 60
  end

  add_index "billing_characteristic", ["domain_header_name"], :name => "bc_idx"

  create_table "billing_flexible_attribute", :id => false, :force => true do |t|
    t.string  "class_name",            :limit => 60,                                  :null => false
    t.integer "class_version",         :limit => 10,   :precision => 10, :scale => 0, :null => false
    t.string  "query_id",              :limit => 16,                                  :null => false
    t.string  "query",                 :limit => 4000,                                :null => false
    t.string  "flexible_attribute_1",  :limit => 360,                                 :null => false
    t.string  "flexible_attribute_2",  :limit => 360
    t.string  "flexible_attribute_3",  :limit => 360
    t.string  "flexible_attribute_4",  :limit => 360
    t.string  "flexible_attribute_5",  :limit => 360
    t.string  "flexible_attribute_6",  :limit => 360
    t.string  "flexible_attribute_7",  :limit => 360
    t.string  "flexible_attribute_8",  :limit => 360
    t.string  "flexible_attribute_9",  :limit => 360
    t.string  "flexible_attribute_10", :limit => 360
    t.string  "flexible_attribute_11", :limit => 360
    t.string  "flexible_attribute_12", :limit => 360
    t.string  "flexible_attribute_13", :limit => 360
    t.string  "flexible_attribute_14", :limit => 360
    t.string  "flexible_attribute_15", :limit => 360
    t.string  "flexible_attribute_16", :limit => 360
    t.string  "flexible_attribute_17", :limit => 360
    t.string  "flexible_attribute_18", :limit => 360
    t.string  "flexible_attribute_19", :limit => 360
    t.string  "flexible_attribute_20", :limit => 360
  end

  create_table "billing_flexible_attribute_map", :id => false, :force => true do |t|
    t.string  "class_name",    :limit => 30,                                 :null => false
    t.integer "class_version", :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.string  "bind_variable", :limit => 30,                                 :null => false
    t.string  "rtti_path",     :limit => 360,                                :null => false
  end

  create_table "branch", :primary_key => "branch_id", :force => true do |t|
    t.string   "branch_name",                    :limit => 30,                                  :null => false
    t.string   "is_active_indicator",            :limit => 1,                                   :null => false
    t.string   "activate_on_true_condition_ind", :limit => 1,                                   :null => false
    t.string   "audit_update_user_id",           :limit => 15,                                  :null => false
    t.datetime "audit_update_date_time",                                                        :null => false
    t.integer  "update_number",                  :limit => 10,   :precision => 10, :scale => 0, :null => false
    t.string   "parent_branch_id",               :limit => 16
    t.string   "business_activity_id",           :limit => 16
    t.string   "service_order_id",               :limit => 16
    t.string   "descriptive_text",               :limit => 360
    t.string   "note_text",                      :limit => 360
    t.string   "gui_expression",                 :limit => 2000
  end

  add_index "branch", ["business_activity_id"], :name => "bra_ba_fk_i", :tablespace => "indexes"
  add_index "branch", ["parent_branch_id"], :name => "bra_bra_fk_i", :tablespace => "indexes"
  add_index "branch", ["service_order_id"], :name => "bra_seo_fk_i", :tablespace => "indexes"

  create_table "business_activity", :primary_key => "business_activity_id", :force => true do |t|
    t.string   "root_business_activity_id",      :limit => 16,                                  :null => false
    t.string   "composite_indicator",            :limit => 1,                                   :null => false
    t.string   "expansion_indicator",            :limit => 1,                                   :null => false
    t.string   "name",                           :limit => 30,                                  :null => false
    t.string   "priority_rd",                    :limit => 16,                                  :null => false
    t.string   "schedule_constraint_type_rd",    :limit => 16,                                  :null => false
    t.string   "standard_duration_unit_rd",      :limit => 16,                                  :null => false
    t.integer  "standard_duration_value",        :limit => 4,    :precision => 4,  :scale => 0, :null => false
    t.string   "status_rd",                      :limit => 16,                                  :null => false
    t.string   "type_rd",                        :limit => 16,                                  :null => false
    t.string   "audit_update_user_id",           :limit => 15,                                  :null => false
    t.datetime "audit_update_date_time",                                                        :null => false
    t.integer  "update_number",                  :limit => 10,   :precision => 10, :scale => 0, :null => false
    t.string   "active_indicator",               :limit => 1
    t.datetime "actual_start_date_time"
    t.integer  "actual_duration_value",          :limit => 4,    :precision => 4,  :scale => 0
    t.string   "actual_duration_unit_rd",        :limit => 16
    t.datetime "actual_end_date_time"
    t.datetime "approval_date_time"
    t.string   "approval_status_rd",             :limit => 16
    t.string   "associated_io_id_string",        :limit => 50
    t.string   "branch_id",                      :limit => 16
    t.decimal  "complete_percent",                               :precision => 5,  :scale => 2
    t.string   "created_by_department_rd",       :limit => 16
    t.string   "created_by_full_name",           :limit => 60
    t.string   "created_by_phone_number",        :limit => 32
    t.datetime "creation_date_time"
    t.string   "customer_category_rd",           :limit => 16
    t.string   "customer_name",                  :limit => 60
    t.string   "customer_number",                :limit => 20
    t.string   "customer_order_id",              :limit => 30
    t.string   "derived_business_activity_id",   :limit => 16
    t.string   "description_string",             :limit => 1024
    t.datetime "earliest_end_date_time"
    t.datetime "earliest_start_date_time"
    t.string   "end_technical_dependency_ind",   :limit => 1
    t.datetime "expected_end_date_time"
    t.string   "external_id_string",             :limit => 50
    t.string   "external_system_indicator_rd",   :limit => 16
    t.string   "ext_sys_usage_mode_name",        :limit => 30
    t.integer  "gantt_chart_order_value",        :limit => 4,    :precision => 4,  :scale => 0
    t.integer  "graphical_editor_x1_value",      :limit => 4,    :precision => 4,  :scale => 0
    t.integer  "graphical_editor_x2_value",      :limit => 4,    :precision => 4,  :scale => 0
    t.integer  "graphical_editor_y1_value",      :limit => 4,    :precision => 4,  :scale => 0
    t.integer  "graphical_editor_y2_value",      :limit => 4,    :precision => 4,  :scale => 0
    t.string   "instruction_string",             :limit => 2000
    t.string   "jeopardy_code_rd",               :limit => 16
    t.datetime "latest_end_date_time"
    t.datetime "latest_start_date_time"
    t.string   "note_string",                    :limit => 1024
    t.string   "on_hold_indicator",              :limit => 1
    t.integer  "order_param_off_line_value",     :limit => 10,   :precision => 10, :scale => 0
    t.datetime "original_planned_end_date_time"
    t.datetime "original_planned_start_date"
    t.string   "parent_business_activity_id",    :limit => 16
    t.string   "past_provision_point_indicator", :limit => 1
    t.string   "project_account_assign_string",  :limit => 24
    t.string   "prologue_epilogue_indicator",    :limit => 1
    t.string   "reason_for_rejection_text",      :limit => 360
    t.string   "receiving_department_rd",        :limit => 16
    t.datetime "rejection_date_time"
    t.string   "rework_indicator",               :limit => 1
    t.string   "sap_controlling_area_string",    :limit => 4
    t.string   "sap_cost_center_string",         :limit => 10
    t.string   "sap_cost_object_type_rd",        :limit => 16
    t.string   "sap_counter_string",             :limit => 8
    t.string   "sap_line_item_string",           :limit => 6
    t.string   "sap_main_asset_number_string",   :limit => 12
    t.string   "sap_network_number_string",      :limit => 12
    t.string   "sap_order_item_number_string",   :limit => 4
    t.string   "sap_order_number_string",        :limit => 12
    t.string   "sap_plan_number_string",         :limit => 10
    t.string   "sap_sales_order_number_string",  :limit => 10
    t.string   "sap_schedule_line_string",       :limit => 4
    t.string   "sap_sub_asset_number_string",    :limit => 4
    t.datetime "schedule_constraint_date_time"
    t.string   "service_order_stp_id",           :limit => 16
    t.string   "standard_indicator",             :limit => 1
    t.string   "start_technical_dependency_ind", :limit => 1
    t.string   "travel_time_unit_rd",            :limit => 16
    t.string   "travel_time",                    :limit => 6
    t.string   "toschedule_indicator",           :limit => 1
    t.string   "workflow_template_id",           :limit => 16
    t.string   "apply_stp_sched_cstr_ind",       :limit => 1
    t.string   "undo_workflow_id",               :limit => 16
    t.string   "undo_business_activity_ind",     :limit => 1
    t.integer  "ba_instance_number",             :limit => 10,   :precision => 10, :scale => 0
    t.integer  "rollback_count",                 :limit => 10,   :precision => 10, :scale => 0
    t.integer  "max_rollback_number",            :limit => 10,   :precision => 10, :scale => 0
    t.string   "force_complete_ind",             :limit => 1
    t.integer  "restart_count",                  :limit => 10,   :precision => 10, :scale => 0
    t.datetime "restart_date_time"
    t.string   "rolled_back_ind",                :limit => 1
    t.string   "max_rollback_action",            :limit => 1
    t.integer  "revision_number",                :limit => 10,   :precision => 10, :scale => 0
    t.string   "bundled_ind",                    :limit => 1
    t.string   "sr_template_name",               :limit => 30
    t.string   "sync_point_ind",                 :limit => 1
    t.datetime "next_retry_date_time"
  end

  add_index "business_activity", ["customer_number"], :name => "ba_customer_number_ind", :tablespace => "indexes"
  add_index "business_activity", ["customer_order_id"], :name => "ba_cust_order_id_ind", :tablespace => "indexes"
  add_index "business_activity", ["derived_business_activity_id"], :name => "derived_ba_fk_ind", :tablespace => "indexes"
  add_index "business_activity", ["external_id_string"], :name => "ba_extid_ind"
  add_index "business_activity", ["parent_business_activity_id"], :name => "ba_parent_id_ind", :tablespace => "indexes"
  add_index "business_activity", ["root_business_activity_id"], :name => "ba_root_id_ind", :tablespace => "indexes"
  add_index "business_activity", ["service_order_stp_id"], :name => "ba_service_order_ind", :tablespace => "indexes"
  add_index "business_activity", ["sr_template_name"], :name => "ba_sr_template_name_ind"
  add_index "business_activity", ["status_rd", "type_rd", "external_system_indicator_rd", "sr_template_name", "ext_sys_usage_mode_name"], :name => "ba_ind1"
  add_index "business_activity", ["undo_workflow_id"], :name => "ba_undo_workflow_id_ind"
  add_index "business_activity", ["workflow_template_id"], :name => "ba_workflow_template_id_ind", :tablespace => "indexes"

  create_table "calculation", :primary_key => "calculation_id", :force => true do |t|
    t.string   "calculation_name",           :limit => 30,                                 :null => false
    t.string   "calculation_indicator",      :limit => 1,                                  :null => false
    t.string   "sensitivity_indicator",      :limit => 1,                                  :null => false
    t.string   "measure_unit_indicator",     :limit => 1,                                  :null => false
    t.string   "flow_of_charges_indicator",  :limit => 1,                                  :null => false
    t.string   "threshold_indicator",        :limit => 1,                                  :null => false
    t.string   "contrib_eligible_indicator", :limit => 1,                                  :null => false
    t.string   "flow_all_account_indicator", :limit => 1,                                  :null => false
    t.string   "summary_group_ind",          :limit => 1,                                  :null => false
    t.string   "audit_update_user_id",       :limit => 15,                                 :null => false
    t.datetime "audit_update_date_time",                                                   :null => false
    t.integer  "update_number",              :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.string   "tariff_week_indicator",      :limit => 1,                                  :null => false
    t.string   "tier_taper_indicator",       :limit => 1,                                  :null => false
    t.string   "zonal_coverage_indicator",   :limit => 1,                                  :null => false
    t.string   "service_coverage_indicator", :limit => 1,                                  :null => false
    t.string   "rate_plan_indicator",        :limit => 1,                                  :null => false
    t.string   "descriptive_text",           :limit => 360
  end

  create_table "calculation_option", :id => false, :force => true do |t|
    t.integer  "calculation_id",          :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.integer  "calculation_option_id",   :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.string   "calculation_option_name", :limit => 30,                                 :null => false
    t.string   "option_level_indicator",  :limit => 1,                                  :null => false
    t.string   "field_type",              :limit => 2,                                  :null => false
    t.string   "valid_values_group_rd",   :limit => 10,                                 :null => false
    t.string   "audit_update_user_id",    :limit => 15,                                 :null => false
    t.datetime "audit_update_date_time",                                                :null => false
    t.integer  "update_number",           :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.string   "base_value_indicator",    :limit => 1,                                  :null => false
    t.integer  "numeric_precision",       :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.string   "descriptive_text",        :limit => 360
    t.string   "default_rtti_path",       :limit => 360
  end

  add_index "calculation_option", ["calculation_id"], :name => "cao_idx"

  create_table "calculation_option_value", :id => false, :force => true do |t|
    t.string   "parent_id",                    :limit => 16,                                 :null => false
    t.integer  "calculation_option_id",        :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.integer  "calculation_id",               :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.string   "calculation_option_value",     :limit => 360,                                :null => false
    t.string   "option_level_indicator",       :limit => 1,                                  :null => false
    t.integer  "grid_row_number",              :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.string   "tariff_model_area_version_id", :limit => 16,                                 :null => false
    t.string   "audit_update_user_id",         :limit => 15,                                 :null => false
    t.datetime "audit_update_date_time",                                                     :null => false
    t.integer  "update_number",                :limit => 10,  :precision => 10, :scale => 0, :null => false
  end

  add_index "calculation_option_value", ["calculation_option_id", "calculation_id"], :name => "coi_idx"
  add_index "calculation_option_value", ["calculation_option_value"], :name => "cov_idx"
  add_index "calculation_option_value", ["grid_row_number", "calculation_option_id"], :name => "cov_ind1", :tablespace => "indexes"

  create_table "calculation_rates", :id => false, :force => true do |t|
    t.integer "calculation_id",        :limit => 10, :precision => 10, :scale => 0, :null => false
    t.integer "calculation_option_id", :limit => 10, :precision => 10, :scale => 0
  end

  create_table "calendar_engine_instance", :primary_key => "calendar_engine_instance_id", :force => true do |t|
    t.string   "status_rd",              :limit => 16,                                  :null => false
    t.string   "instance_name_path",     :limit => 1024,                                :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                  :null => false
    t.datetime "audit_update_date_time",                                                :null => false
    t.integer  "update_number",          :limit => 10,   :precision => 10, :scale => 0, :null => false
    t.datetime "start_date_time"
    t.datetime "end_date_time"
  end

  create_table "calendar_engine_resource_pool", :id => false, :force => true do |t|
    t.string   "calendar_engine_instance_id", :limit => 16,                                :null => false
    t.string   "regional_location_name",      :limit => 30,                                :null => false
    t.string   "role_name",                   :limit => 30,                                :null => false
    t.string   "audit_update_user_id",        :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                   :null => false
    t.integer  "update_number",               :limit => 10, :precision => 10, :scale => 0, :null => false
    t.datetime "last_generation_date_time"
  end

  add_index "calendar_engine_resource_pool", ["calendar_engine_instance_id"], :name => "cer_idx"

  create_table "calendar_rule", :primary_key => "calendar_rule_id", :force => true do |t|
    t.string   "calendar_rule_type_id",  :limit => 16,                                  :null => false
    t.datetime "end_date_time",                                                         :null => false
    t.datetime "start_date_time",                                                       :null => false
    t.string   "name",                   :limit => 30,                                  :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                  :null => false
    t.datetime "audit_update_date_time",                                                :null => false
    t.integer  "update_number",          :limit => 10,   :precision => 10, :scale => 0, :null => false
    t.string   "employee_number",        :limit => 30
    t.string   "regional_location_name", :limit => 30
    t.string   "role_name",              :limit => 30
    t.string   "description_string",     :limit => 1024
  end

  add_index "calendar_rule", ["calendar_rule_type_id"], :name => "cal_idx"
  add_index "calendar_rule", ["employee_number"], :name => "cr_idx"
  add_index "calendar_rule", ["regional_location_name"], :name => "car_idx"
  add_index "calendar_rule", ["role_name"], :name => "calr_idx"

  create_table "calendar_rule_pattern", :primary_key => "calendar_rule_pattern_id", :force => true do |t|
    t.string   "calendar_rule_id",         :limit => 16,                                :null => false
    t.string   "frequency_period_rd",      :limit => 16,                                :null => false
    t.integer  "frequency_interval_value", :limit => 4,  :precision => 4,  :scale => 0, :null => false
    t.string   "end_time",                 :limit => 6,                                 :null => false
    t.datetime "occurrence_date_time",                                                  :null => false
    t.string   "start_time",               :limit => 6,                                 :null => false
    t.string   "audit_update_user_id",     :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                :null => false
    t.integer  "update_number",            :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  add_index "calendar_rule_pattern", ["calendar_rule_id"], :name => "crp_idx"

  create_table "calendar_rule_type", :primary_key => "calendar_rule_type_id", :force => true do |t|
    t.string   "include_in_capacity_indicator", :limit => 1,                                   :null => false
    t.integer  "precedence_value",              :limit => 10,   :precision => 10, :scale => 0, :null => false
    t.string   "name",                          :limit => 30,                                  :null => false
    t.string   "audit_update_user_id",          :limit => 15,                                  :null => false
    t.datetime "audit_update_date_time",                                                       :null => false
    t.integer  "update_number",                 :limit => 10,   :precision => 10, :scale => 0, :null => false
    t.string   "description_string",            :limit => 1024
  end

  create_table "cbm_document_statistic", :id => false, :force => true do |t|
    t.datetime "process_end_date_time",                                                :null => false
    t.string   "process_name",            :limit => 30,                                :null => false
    t.string   "instance_name",           :limit => 30,                                :null => false
    t.string   "document_type_name",      :limit => 30,                                :null => false
    t.integer  "total_in_documents",      :limit => 10, :precision => 10, :scale => 0, :null => false
    t.integer  "total_out_documents",     :limit => 10, :precision => 10, :scale => 0, :null => false
    t.integer  "total_deleted_documents", :limit => 10, :precision => 10, :scale => 0, :null => false
    t.decimal  "total_in_invoice_gross",                :precision => 18, :scale => 6, :null => false
    t.decimal  "total_out_invoice_gross",               :precision => 18, :scale => 6, :null => false
    t.decimal  "total_in_invoice_net",                  :precision => 18, :scale => 6, :null => false
    t.decimal  "total_out_invoice_net",                 :precision => 18, :scale => 6, :null => false
    t.decimal  "total_in_invoice_tax",                  :precision => 18, :scale => 6, :null => false
    t.decimal  "total_out_invoice_tax",                 :precision => 18, :scale => 6, :null => false
  end

  create_table "cbm_statistic", :id => false, :force => true do |t|
    t.string   "process_name",                 :limit => 30,                                :null => false
    t.string   "instance_name",                :limit => 30,                                :null => false
    t.datetime "process_end_date_time",                                                     :null => false
    t.datetime "process_start_date_time",                                                   :null => false
    t.integer  "production_run_idnumber",      :limit => 10, :precision => 10, :scale => 0, :null => false
    t.integer  "production_batch_idnumber",    :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "job_type",                     :limit => 2,                                 :null => false
    t.integer  "xref_version_number",          :limit => 4,  :precision => 4,  :scale => 0, :null => false
    t.string   "message_name",                 :limit => 30,                                :null => false
    t.integer  "total_in_mailings",            :limit => 10, :precision => 10, :scale => 0
    t.integer  "total_out_mailings",           :limit => 10, :precision => 10, :scale => 0
    t.integer  "total_in_misc_events",         :limit => 10, :precision => 10, :scale => 0
    t.integer  "total_out_misc_events",        :limit => 10, :precision => 10, :scale => 0
    t.integer  "total_accounts_to_pricing",    :limit => 10, :precision => 10, :scale => 0
    t.integer  "total_accounts_priced",        :limit => 10, :precision => 10, :scale => 0
    t.integer  "total_accounts_errored",       :limit => 10, :precision => 10, :scale => 0
    t.integer  "total_in_envelopes",           :limit => 10, :precision => 10, :scale => 0
    t.integer  "total_out_envelopes",          :limit => 10, :precision => 10, :scale => 0
    t.integer  "total_deleted_envelopes",      :limit => 10, :precision => 10, :scale => 0
    t.integer  "total_in_sample_envs",         :limit => 10, :precision => 10, :scale => 0
    t.integer  "total_out_sample_envs",        :limit => 10, :precision => 10, :scale => 0
    t.integer  "total_deleted_sample_envs",    :limit => 10, :precision => 10, :scale => 0
    t.integer  "total_in_slot_inserts",        :limit => 10, :precision => 10, :scale => 0
    t.integer  "total_out_slot_inserts",       :limit => 10, :precision => 10, :scale => 0
    t.integer  "total_deleted_slot_inserts",   :limit => 10, :precision => 10, :scale => 0
    t.integer  "total_in_usage_events",        :limit => 10, :precision => 10, :scale => 0
    t.integer  "total_out_usage_events",       :limit => 10, :precision => 10, :scale => 0
    t.integer  "total_in_summary_events",      :limit => 10, :precision => 10, :scale => 0
    t.integer  "total_out_summary_events",     :limit => 10, :precision => 10, :scale => 0
    t.integer  "total_in_rec_charge_events",   :limit => 10, :precision => 10, :scale => 0
    t.integer  "total_out_rec_charge_events",  :limit => 10, :precision => 10, :scale => 0
    t.integer  "total_in_one_time_events",     :limit => 10, :precision => 10, :scale => 0
    t.integer  "total_out_one_time_events",    :limit => 10, :precision => 10, :scale => 0
    t.integer  "total_in_general_adj_events",  :limit => 10, :precision => 10, :scale => 0
    t.integer  "total_in_financial_events",    :limit => 10, :precision => 10, :scale => 0
    t.integer  "total_out_financial_events",   :limit => 10, :precision => 10, :scale => 0
    t.integer  "total_out_general_adj_events", :limit => 10, :precision => 10, :scale => 0
    t.integer  "total_envelopes_marked_vr",    :limit => 10, :precision => 10, :scale => 0
    t.integer  "total_accounts_to_rerate",     :limit => 10, :precision => 10, :scale => 0
  end

  create_table "ccm_batch_statistic", :id => false, :force => true do |t|
    t.datetime "process_start_date_time",                                               :null => false
    t.datetime "process_end_date_time",                                                 :null => false
    t.string   "instance_name",           :limit => 32,                                 :null => false
    t.string   "message_class",           :limit => 64,                                 :null => false
    t.string   "processor_name",          :limit => 128,                                :null => false
    t.string   "filename",                :limit => 100
    t.string   "job_type",                :limit => 2
    t.integer  "file_sequence_number",    :limit => 10,  :precision => 10, :scale => 0
    t.integer  "total_in",                :limit => 10,  :precision => 10, :scale => 0
    t.integer  "total_workout",           :limit => 10,  :precision => 10, :scale => 0
    t.integer  "total_error",             :limit => 10,  :precision => 10, :scale => 0
    t.integer  "total_filter",            :limit => 10,  :precision => 10, :scale => 0
    t.string   "max_error_severity",      :limit => 6
    t.string   "producer_description",    :limit => 30
    t.string   "message_class_type",      :limit => 64
    t.string   "application_name",        :limit => 128
  end

  create_table "cdo_file_statistic", :id => false, :force => true do |t|
    t.string   "process_name",          :limit => 30,                                :null => false
    t.string   "instance_name",         :limit => 30,                                :null => false
    t.datetime "process_end_date_time",                                              :null => false
    t.string   "output_format_name",    :limit => 30,                                :null => false
    t.integer  "total_in_files",        :limit => 10, :precision => 10, :scale => 0, :null => false
    t.integer  "total_out_files",       :limit => 10, :precision => 10, :scale => 0, :null => false
    t.integer  "total_deleted_files",   :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  create_table "central_registry", :id => false, :force => true do |t|
    t.string   "group_name",             :limit => 30,                                  :null => false
    t.string   "key_string",             :limit => 1024,                                :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                  :null => false
    t.datetime "audit_update_date_time",                                                :null => false
    t.integer  "update_number",          :limit => 10,   :precision => 10, :scale => 0, :null => false
    t.string   "value_string",           :limit => 360
  end

  create_table "change_group", :primary_key => "change_group_id", :force => true do |t|
    t.string   "status_rd",              :limit => 16,                                :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
    t.integer  "update_number",          :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  create_table "char_condition_expression", :primary_key => "condition_expression_id", :force => true do |t|
    t.string   "priceable_characteristic_id",  :limit => 16,                                :null => false
    t.string   "comparison_operator_value_rd", :limit => 16,                                :null => false
    t.string   "characteristic_type",          :limit => 2,                                 :null => false
    t.integer  "component_order_value",        :limit => 4,  :precision => 4,  :scale => 0, :null => false
    t.string   "audit_update_user_id",         :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                    :null => false
    t.integer  "update_number",                :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "sr_condition_id",              :limit => 16
    t.string   "sd_condition_id",              :limit => 16
  end

  add_index "char_condition_expression", ["priceable_characteristic_id"], :name => "cce_pc_fk_i", :tablespace => "indexes"
  add_index "char_condition_expression", ["sd_condition_id"], :name => "cc_idx"
  add_index "char_condition_expression", ["sr_condition_id"], :name => "cce_src_fk_i", :tablespace => "indexes"

  create_table "characteristic_constraint", :primary_key => "characteristic_constraint_id", :force => true do |t|
    t.string   "characteristic_constraint_name", :limit => 30,                                                   :null => false
    t.string   "expression_string",              :limit => 2000,                                                 :null => false
    t.string   "service_code",                   :limit => 5,                                                    :null => false
    t.string   "service_version_code",           :limit => 5,                                                    :null => false
    t.integer  "update_number",                  :limit => 10,   :precision => 10, :scale => 0,                  :null => false
    t.string   "audit_update_user_id",           :limit => 15,                                                   :null => false
    t.datetime "audit_update_date_time",                                                                         :null => false
    t.string   "usage_mode_rd",                  :limit => 16,                                                   :null => false
    t.string   "error_code",                     :limit => 16
    t.string   "descriptive_text",               :limit => 360
    t.string   "active_ind",                     :limit => 1,                                   :default => "Y"
  end

  add_index "characteristic_constraint", ["error_code"], :name => "cct_idx"

  create_table "characteristic_value", :primary_key => "characteristic_value_id", :force => true do |t|
    t.string   "service_char_code",      :limit => 5,                                 :null => false
    t.string   "value_type_ind",         :limit => 1,                                 :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
    t.integer  "update_number",          :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "measure_unit_code",      :limit => 5
    t.string   "d_value",                :limit => 30
    t.string   "c_minimum_value",        :limit => 30
    t.string   "c_maximum_value",        :limit => 30
    t.string   "c_default_value",        :limit => 30
  end

  add_index "characteristic_value", ["measure_unit_code"], :name => "cv_mu_fk1_i", :tablespace => "indexes"
  add_index "characteristic_value", ["service_char_code"], :name => "cv_sc_fk_i", :tablespace => "indexes"

  create_table "child_validation_action", :id => false, :force => true do |t|
    t.integer  "child_class_id",         :limit => 10, :precision => 10, :scale => 0, :null => false
    t.integer  "action_number_value",    :limit => 4,  :precision => 4,  :scale => 0, :null => false
    t.string   "parent_group_id",        :limit => 16,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.integer  "update_number",          :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "child_group_id",         :limit => 16
    t.string   "controlled_action_id",   :limit => 16
  end

  create_table "child_validation_field", :id => false, :force => true do |t|
    t.string   "child_group_id",         :limit => 16,                                :null => false
    t.string   "child_field_name",       :limit => 30,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.integer  "update_number",          :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  create_table "cin_command_log", :id => false, :force => true do |t|
    t.integer  "customer_transaction_id", :limit => 22, :precision => 22, :scale => 0, :null => false
    t.string   "session_id",              :limit => 20,                                :null => false
    t.string   "audit_update_user_id",    :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                               :null => false
    t.string   "source_name",             :limit => 30
  end

  create_table "common_report", :primary_key => "report_id", :force => true do |t|
    t.string   "report_name",              :limit => 60,                                :null => false
    t.string   "controlled_action_id",     :limit => 16,                                :null => false
    t.string   "sub_view_id",              :limit => 20,                                :null => false
    t.string   "report_group_type",        :limit => 5,                                 :null => false
    t.string   "sas_exe_name",             :limit => 30,                                :null => false
    t.string   "sas_exe_command",          :limit => 30,                                :null => false
    t.string   "document_orientation_ind", :limit => 1,                                 :null => false
    t.string   "audit_update_user_id",     :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                :null => false
    t.integer  "update_number",            :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  create_table "condition", :id => false, :force => true do |t|
    t.string   "condition_name",         :limit => 30,                                  :null => false
    t.datetime "effective_date",                                                        :null => false
    t.string   "effective_status",       :limit => 6,                                   :null => false
    t.string   "condition_text",         :limit => 1024,                                :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                  :null => false
    t.datetime "audit_update_date_time",                                                :null => false
    t.integer  "update_number",          :limit => 10,   :precision => 10, :scale => 0, :null => false
    t.string   "description",            :limit => 60
  end

  create_table "condition_operator", :primary_key => "condition_operator_id", :force => true do |t|
    t.string   "operator_value_rd",      :limit => 16,                                :null => false
    t.integer  "component_order_value",  :limit => 4,  :precision => 4,  :scale => 0, :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
    t.integer  "update_number",          :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "sr_condition_id",        :limit => 16
    t.string   "sd_condition_id",        :limit => 16
  end

  add_index "condition_operator", ["sd_condition_id"], :name => "cop_sdc_fk_i", :tablespace => "indexes"
  add_index "condition_operator", ["sr_condition_id"], :name => "cop_src_fk_i", :tablespace => "indexes"

  create_table "config_error_template", :primary_key => "error_code", :force => true do |t|
    t.string   "error_name",             :limit => 30,                                                   :null => false
    t.string   "description",            :limit => 360,                                                  :null => false
    t.string   "severity",               :limit => 30,                                                   :null => false
    t.string   "type_ind",               :limit => 1,                                                    :null => false
    t.string   "auto_correct_ind",       :limit => 1,                                                    :null => false
    t.string   "on_hold_ind",            :limit => 1,                                                    :null => false
    t.string   "error_text",             :limit => 1024,                                                 :null => false
    t.string   "in_progress_ind",        :limit => 1,                                                    :null => false
    t.string   "default_ind",            :limit => 1,                                                    :null => false
    t.string   "reject_so_ind",          :limit => 1,                                                    :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                                   :null => false
    t.datetime "audit_update_date_time",                                                                 :null => false
    t.integer  "update_number",          :limit => 10,   :precision => 10, :scale => 0,                  :null => false
    t.binary   "auto_correct_script"
    t.integer  "revision_number",        :limit => 10,   :precision => 10, :scale => 0
    t.string   "active_ind",             :limit => 1,                                   :default => "Y"
  end

  create_table "config_serv_char_interface_map", :primary_key => "ccm_config_serv_char_id", :force => true do |t|
    t.string   "ccm_service_ticket_position_id", :limit => 16,                                :null => false
    t.string   "data_type_rd",                   :limit => 16,                                :null => false
    t.string   "mandatory_for_provisioning",     :limit => 1,                                 :null => false
    t.string   "effective_status",               :limit => 6,                                 :null => false
    t.string   "psm_removed_indicator",          :limit => 1,                                 :null => false
    t.string   "op_config_serv_char_id",         :limit => 16,                                :null => false
    t.datetime "ccm_config_serv_char_eff_dt",                                                 :null => false
    t.string   "ccm_service_subscription_id",    :limit => 16,                                :null => false
    t.string   "ccm_service_characteristic_cd",  :limit => 5,                                 :null => false
    t.string   "audit_update_user_id",           :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                      :null => false
    t.integer  "update_number",                  :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "address_id",                     :limit => 16
    t.string   "configured_value_id",            :limit => 16
  end

  add_index "config_serv_char_interface_map", ["ccm_service_subscription_id", "ccm_service_characteristic_cd"], :name => "cscim_ind3", :tablespace => "indexes"
  add_index "config_serv_char_interface_map", ["ccm_service_ticket_position_id", "ccm_config_serv_char_eff_dt", "ccm_service_characteristic_cd"], :name => "cscim_ind2", :tablespace => "indexes"
  add_index "config_serv_char_interface_map", ["op_config_serv_char_id", "ccm_config_serv_char_eff_dt"], :name => "cscim_ind1", :tablespace => "indexes"

  create_table "config_service_characteristic", :id => false, :force => true do |t|
    t.string   "config_service_char_id",         :limit => 16,                                :null => false
    t.datetime "effective_date",                                                              :null => false
    t.string   "service_subscription_id",        :limit => 16,                                :null => false
    t.string   "service_ticket_position_id",     :limit => 16,                                :null => false
    t.string   "effective_status",               :limit => 6,                                 :null => false
    t.string   "data_type_rd",                   :limit => 16,                                :null => false
    t.string   "mandatory_for_provisioning",     :limit => 1,                                 :null => false
    t.string   "set_by_customer_rep_ind",        :limit => 1,                                 :null => false
    t.string   "service_characteristic_code",    :limit => 5,                                 :null => false
    t.string   "audit_update_user_id",           :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                      :null => false
    t.integer  "update_number",                  :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "address_id",                     :limit => 16
    t.string   "associated_config_serv_char_id", :limit => 16
    t.datetime "completion_date"
    t.string   "priceable_characteristic_id",    :limit => 16
  end

  add_index "config_service_characteristic", ["address_id"], :name => "csc_indx2"
  add_index "config_service_characteristic", ["config_service_char_id", "effective_date"], :name => "csc_indx1", :unique => true
  add_index "config_service_characteristic", ["service_ticket_position_id"], :name => "csc_indx3"

  create_table "configuration_error", :primary_key => "config_error_id", :force => true do |t|
    t.string   "error_code",             :limit => 16,                                  :null => false
    t.string   "status",                 :limit => 6,                                   :null => false
    t.string   "originating_id",         :limit => 16,                                  :null => false
    t.string   "type_ind",               :limit => 1,                                   :null => false
    t.datetime "generation_date",                                                       :null => false
    t.string   "on_hold_ind",            :limit => 1,                                   :null => false
    t.string   "error_text",             :limit => 1024,                                :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                  :null => false
    t.datetime "audit_update_date_time",                                                :null => false
    t.integer  "update_number",          :limit => 10,   :precision => 10, :scale => 0, :null => false
    t.string   "service_order_stp_id",   :limit => 16
    t.string   "external_system_name",   :limit => 30
    t.datetime "resolution_date"
    t.string   "comment_text",           :limit => 1024
  end

  add_index "configuration_error", ["error_code"], :name => "cet_index4", :tablespace => "indexes"
  add_index "configuration_error", ["external_system_name"], :name => "cet_index3", :tablespace => "indexes"
  add_index "configuration_error", ["originating_id", "error_code"], :name => "ce_index1", :tablespace => "indexes"
  add_index "configuration_error", ["service_order_stp_id"], :name => "cet_index2", :tablespace => "indexes"

  create_table "configured_value", :primary_key => "configured_value_id", :force => true do |t|
    t.string   "config_service_char_id",  :limit => 16,                                  :null => false
    t.decimal  "configured_value_number",                 :precision => 18, :scale => 6, :null => false
    t.string   "value_type_indicator",    :limit => 1,                                   :null => false
    t.datetime "audit_update_date_time",                                                 :null => false
    t.string   "audit_update_user_id",    :limit => 15,                                  :null => false
    t.integer  "update_number",           :limit => 10,   :precision => 10, :scale => 0, :null => false
    t.string   "measurement_unit_code",   :limit => 5
    t.string   "configured_value_string", :limit => 1024
  end

  add_index "configured_value", ["config_service_char_id"], :name => "configv_ind1", :tablespace => "indexes"

  create_table "contact", :primary_key => "contact_id", :force => true do |t|
    t.string   "customer_number",              :limit => 20,                                  :null => false
    t.string   "contact_type_rd",              :limit => 16,                                  :null => false
    t.string   "author_name",                  :limit => 60,                                  :null => false
    t.datetime "date_time",                                                                   :null => false
    t.string   "audit_update_user_id",         :limit => 15,                                  :null => false
    t.datetime "audit_update_date_time",                                                      :null => false
    t.integer  "update_number",                :limit => 10,   :precision => 10, :scale => 0, :null => false
    t.string   "associated_contact_id",        :limit => 16
    t.string   "caller_name",                  :limit => 60
    t.string   "caller_phone_number",          :limit => 32
    t.string   "long_description_text",        :limit => 2048
    t.string   "short_description",            :limit => 30
    t.string   "trouble_ticket_id",            :limit => 20
    t.string   "trouble_ticket_type_rd",       :limit => 16
    t.string   "trouble_ticket_requested_ind", :limit => 1
    t.string   "trouble_ticket_status_rd",     :limit => 16
  end

  add_index "contact", ["associated_contact_id"], :name => "cntact_fk_i", :tablespace => "indexes"
  add_index "contact", ["customer_number", "associated_contact_id"], :name => "cntact_i", :tablespace => "indexes"

  create_table "contact_role", :id => false, :force => true do |t|
    t.string   "supported_object_id",           :limit => 20,                                :null => false
    t.string   "supported_object_type_rd",      :limit => 16,                                :null => false
    t.string   "contact_role_type_rd",          :limit => 16,                                :null => false
    t.string   "entity_id",                     :limit => 16,                                :null => false
    t.datetime "effective_date",                                                             :null => false
    t.string   "customer_number",               :limit => 20,                                :null => false
    t.string   "effective_status",              :limit => 6,                                 :null => false
    t.string   "audit_update_user_id",          :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                     :null => false
    t.integer  "update_number",                 :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "contact_role_position_name",    :limit => 30
    t.string   "primary_access_information_id", :limit => 16
    t.string   "primary_address_id",            :limit => 16
    t.string   "comment_id",                    :limit => 16
  end

  add_index "contact_role", ["customer_number"], :name => "contr_cust_ind", :tablespace => "indexes"

  create_table "contract_customer", :id => false, :force => true do |t|
    t.string   "contract_number",           :limit => 12,                                :null => false
    t.string   "customer_number",           :limit => 20,                                :null => false
    t.datetime "effective_date",                                                         :null => false
    t.string   "owning_customer_indicator", :limit => 1,                                 :null => false
    t.string   "contract_type_indicator",   :limit => 1,                                 :null => false
    t.string   "effective_status",          :limit => 6,                                 :null => false
    t.string   "audit_update_user_id",      :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                 :null => false
    t.integer  "update_number",             :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  add_index "contract_customer", ["customer_number"], :name => "cntrct_cust_cust_ind", :tablespace => "indexes"

  create_table "contract_predefined_legal", :id => false, :force => true do |t|
    t.string   "predefined_legal_condition_id", :limit => 16,                                :null => false
    t.string   "contract_number",               :limit => 12,                                :null => false
    t.datetime "effective_date",                                                             :null => false
    t.string   "effective_status",              :limit => 6,                                 :null => false
    t.string   "audit_update_user_id",          :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                     :null => false
    t.integer  "update_number",                 :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  create_table "contract_rule", :primary_key => "contract_code", :force => true do |t|
    t.string   "name",                   :limit => 60,                                 :null => false
    t.datetime "activation_date",                                                      :null => false
    t.string   "status",                 :limit => 6,                                  :null => false
    t.string   "test_mode_ind",          :limit => 1,                                  :null => false
    t.string   "product_code",           :limit => 5
    t.string   "product_version_code",   :limit => 5
    t.string   "pricing_structure_code", :limit => 5
    t.string   "service_code",           :limit => 5
    t.integer  "duration_value",         :limit => 4,   :precision => 4,  :scale => 0, :null => false
    t.string   "duration_unit",          :limit => 16,                                 :null => false
    t.string   "automatic_create_ind",   :limit => 1,                                  :null => false
    t.string   "automatic_start_ind",    :limit => 1,                                  :null => false
    t.datetime "audit_update_date_time",                                               :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                 :null => false
    t.integer  "update_number",          :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.string   "billing_name_1",         :limit => 60,                                 :null => false
    t.string   "billing_name_2",         :limit => 60
    t.string   "descriptive_text",       :limit => 360
    t.datetime "discontinue_date"
    t.string   "change_group_id",        :limit => 30
  end

  add_index "contract_rule", ["pricing_structure_code", "product_version_code", "product_code"], :name => "crl_idx"
  add_index "contract_rule", ["product_code"], :name => "cr2_idx"

  create_table "contributing_item", :id => false, :force => true do |t|
    t.string   "contributing_item_id",          :limit => 20,                                :null => false
    t.string   "type_rd",                       :limit => 16,                                :null => false
    t.string   "price_plan_subscription_id",    :limit => 16,                                :null => false
    t.datetime "effective_date",                                                             :null => false
    t.string   "effective_status",              :limit => 6,                                 :null => false
    t.string   "hierarchy_inclusion_indicator", :limit => 1,                                 :null => false
    t.string   "active_price_plan_indicator",   :limit => 1,                                 :null => false
    t.string   "contributing_item_number",      :limit => 16,                                :null => false
    t.string   "audit_update_user_id",          :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                     :null => false
    t.integer  "update_number",                 :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "transaction_id",                :limit => 16
  end

  add_index "contributing_item", ["price_plan_subscription_id"], :name => "ci_ppsub_ind", :tablespace => "indexes"

  create_table "core_event_definition", :primary_key => "base_type_name", :force => true do |t|
    t.integer  "event_class_id",          :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "event_type_ind",          :limit => 1,                                 :null => false
    t.string   "flexible_event_ind",      :limit => 1,                                 :null => false
    t.string   "name",                    :limit => 30,                                :null => false
    t.string   "related_event_name",      :limit => 60,                                :null => false
    t.string   "audit_update_user_id",    :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                               :null => false
    t.integer  "update_number",           :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "default_guiding_path_rd", :limit => 16
    t.string   "default_rate_path_rd",    :limit => 16
    t.string   "default_taxing_path_rd",  :limit => 16
    t.string   "rating_table_name",       :limit => 30
  end

  add_index "core_event_definition", ["name"], :name => "ced_ind1", :tablespace => "indexes"

  create_table "credit_card", :id => false, :force => true do |t|
    t.string   "customer_number",        :limit => 20,                                :null => false
    t.string   "credit_card_id",         :limit => 16,                                :null => false
    t.datetime "effective_date",                                                      :null => false
    t.string   "credit_card_number",     :limit => 25,                                :null => false
    t.string   "effective_status",       :limit => 6,                                 :null => false
    t.string   "owner_full_name",        :limit => 60,                                :null => false
    t.string   "type_rd",                :limit => 16,                                :null => false
    t.datetime "expiration_date",                                                     :null => false
    t.string   "credit_card_country_rd", :limit => 16,                                :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
    t.integer  "update_number",          :limit => 10, :precision => 10, :scale => 0, :null => false
    t.datetime "begin_date"
  end

  add_index "credit_card", ["credit_card_id"], :name => "credcrd_ind2", :tablespace => "indexes"
  add_index "credit_card", ["credit_card_number"], :name => "credcrd_ind1", :tablespace => "indexes"

  create_table "cross_reference_group", :primary_key => "group_code", :force => true do |t|
    t.string   "description",            :limit => 60,                                :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
    t.integer  "update_number",          :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "modifiable_value",       :limit => 16
    t.string   "ref_data_type_value",    :limit => 16
  end

  create_table "cross_reference_item", :id => false, :force => true do |t|
    t.string   "primary_value",          :limit => 16,                                :null => false
    t.string   "group_code",             :limit => 10,                                :null => false
    t.string   "secondary_value",        :limit => 16,                                :null => false
    t.datetime "effective_date",                                                      :null => false
    t.string   "effective_status",       :limit => 6,                                 :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
    t.integer  "update_number",          :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "modifiable_value",       :limit => 16
    t.string   "ref_data_type_value",    :limit => 16
  end

  create_table "csecomment", :id => false, :force => true do |t|
    t.string   "comment_id",             :limit => 22,                                  :null => false
    t.datetime "creation_date_time",                                                    :null => false
    t.string   "comment_type_rd",        :limit => 16,                                  :null => false
    t.string   "author_user_id",         :limit => 15,                                  :null => false
    t.string   "short_description",      :limit => 30,                                  :null => false
    t.string   "long_description_text",  :limit => 2048,                                :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                  :null => false
    t.datetime "audit_update_date_time",                                                :null => false
    t.integer  "update_number",          :limit => 10,   :precision => 10, :scale => 0, :null => false
  end

  create_table "currency_ratio", :id => false, :force => true do |t|
    t.string   "from_currency_name",     :limit => 30,                                :null => false
    t.string   "to_currency_name",       :limit => 30,                                :null => false
    t.datetime "effective_date",                                                      :null => false
    t.string   "effective_status",       :limit => 6,                                 :null => false
    t.decimal  "ratio",                                :precision => 18, :scale => 6, :null => false
    t.string   "ratio_type",             :limit => 2,                                 :null => false
    t.integer  "update_number",          :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
    t.string   "description",            :limit => 60
  end

  create_table "custom_legal_condition", :id => false, :force => true do |t|
    t.string   "custom_legal_condition_id", :limit => 16,                                 :null => false
    t.datetime "effective_date",                                                          :null => false
    t.string   "effective_status",          :limit => 6,                                  :null => false
    t.string   "contract_number",           :limit => 12,                                 :null => false
    t.string   "audit_update_user_id",      :limit => 15,                                 :null => false
    t.datetime "audit_update_date_time",                                                  :null => false
    t.integer  "update_number",             :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.string   "name",                      :limit => 30
    t.string   "description_text",          :limit => 360
  end

  create_table "customer", :id => false, :force => true do |t|
    t.string   "customer_number",                :limit => 20,                                 :null => false
    t.datetime "effective_date",                                                               :null => false
    t.string   "effective_status",               :limit => 6,                                  :null => false
    t.string   "personal_data_indicator",        :limit => 1,                                  :null => false
    t.string   "state_rd",                       :limit => 16,                                 :null => false
    t.string   "tax_exempt_indicator",           :limit => 1,                                  :null => false
    t.string   "reference_indicator",            :limit => 1,                                  :null => false
    t.datetime "state_date",                                                                   :null => false
    t.string   "customer_data_indicator",        :limit => 1,                                  :null => false
    t.string   "prospect_indicator",             :limit => 1,                                  :null => false
    t.string   "service_customer_indicator",     :limit => 1,                                  :null => false
    t.string   "security_customer_group_string", :limit => 60
    t.string   "credit_check_result_state_rd",   :limit => 16,                                 :null => false
    t.string   "encryption_key",                 :limit => 16,                                 :null => false
    t.string   "usage_data_indicator",           :limit => 1,                                  :null => false
    t.string   "audit_update_user_id",           :limit => 15,                                 :null => false
    t.datetime "audit_update_date_time",                                                       :null => false
    t.integer  "update_number",                  :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.string   "retention_period_rd",            :limit => 16
    t.string   "payment_term_rd",                :limit => 16
    t.string   "user_password",                  :limit => 120
    t.string   "associated_customer_number",     :limit => 20
    t.string   "category_rd",                    :limit => 16
    t.string   "classification_rd",              :limit => 16
    t.string   "tax_identification_number",      :limit => 20
    t.string   "document_language_rd",           :limit => 16
    t.string   "payment_method_rd",              :limit => 16
    t.decimal  "usage_limit_amount",                            :precision => 18, :scale => 6
    t.string   "risk_category_rd",               :limit => 16
    t.string   "credit_check_result_indicator",  :limit => 1
    t.string   "invoice_currency_rd",            :limit => 16
    t.string   "masking_digits_rd",              :limit => 16
    t.string   "customer_group_rd",              :limit => 16
    t.string   "customer_internal_ref_number",   :limit => 35
    t.datetime "first_activation_date"
    t.string   "match_code_id",                  :limit => 20
    t.datetime "service_inception_date"
    t.string   "cycle_name",                     :limit => 30
    t.string   "region_rd",                      :limit => 16
    t.string   "user_defined_customer_1_string", :limit => 20
    t.string   "user_defined_customer_2_string", :limit => 20
    t.string   "user_defined_customer_3_string", :limit => 20
    t.string   "user_defined_customer_4_string", :limit => 20
    t.string   "resale_flag_ind",                :limit => 1
  end

  add_index "customer", ["associated_customer_number"], :name => "cust_cust_fk_i", :tablespace => "indexes"
  add_index "customer", ["customer_internal_ref_number"], :name => "cust_ind4", :tablespace => "indexes"
  add_index "customer", ["match_code_id", "customer_number"], :name => "customer_mc_index", :tablespace => "indexes"
  add_index "customer", ["user_defined_customer_1_string"], :name => "cust_ind3", :tablespace => "indexes"

  create_table "customer_correspondence", :primary_key => "customer_correspondence_id", :force => true do |t|
    t.string   "output_device_rd",       :limit => 16,                                  :null => false
    t.datetime "request_date",                                                          :null => false
    t.string   "subject_description",    :limit => 30,                                  :null => false
    t.string   "text",                   :limit => 1600,                                :null => false
    t.string   "language_rd",            :limit => 16,                                  :null => false
    t.string   "customer_number",        :limit => 20,                                  :null => false
    t.string   "mailing_id",             :limit => 16,                                  :null => false
    t.string   "document_template_name", :limit => 30,                                  :null => false
    t.string   "extracted_ind",          :limit => 1,                                   :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                  :null => false
    t.datetime "audit_update_date_time",                                                :null => false
    t.integer  "update_number",          :limit => 10,   :precision => 10, :scale => 0, :null => false
    t.string   "currency_rd",            :limit => 16
    t.string   "priority_rd",            :limit => 16
  end

  add_index "customer_correspondence", ["customer_number"], :name => "cc_ind1", :tablespace => "indexes"

  create_table "customer_manual_activation", :primary_key => "customer_number", :force => true do |t|
    t.datetime "activation_date",                                                     :null => false
    t.string   "state_rd",               :limit => 16,                                :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
    t.integer  "update_number",          :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  create_table "customer_message", :primary_key => "customer_message_id", :force => true do |t|
    t.string   "supported_object_type_rd", :limit => 16,                                 :null => false
    t.string   "supported_object_id",      :limit => 16,                                 :null => false
    t.datetime "request_date",                                                           :null => false
    t.string   "text",                     :limit => 360,                                :null => false
    t.datetime "audit_update_date_time",                                                 :null => false
    t.string   "audit_update_user_id",     :limit => 15,                                 :null => false
    t.integer  "update_number",            :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.string   "cycle_name",               :limit => 30
    t.datetime "cycle_due_date"
  end

  create_table "customer_order", :primary_key => "customer_order_id", :force => true do |t|
    t.string   "customer_number",               :limit => 20,                                  :null => false
    t.string   "bill_activation_indicator",     :limit => 1,                                   :null => false
    t.datetime "create_date",                                                                  :null => false
    t.string   "created_by_name",               :limit => 60,                                  :null => false
    t.string   "created_by_phone_number",       :limit => 32,                                  :null => false
    t.string   "created_by_department",         :limit => 360,                                 :null => false
    t.string   "state_rd",                      :limit => 16,                                  :null => false
    t.datetime "state_date",                                                                   :null => false
    t.string   "type_rd",                       :limit => 16,                                  :null => false
    t.string   "priority_rd",                   :limit => 16,                                  :null => false
    t.string   "reservation_order_indicator",   :limit => 1,                                   :null => false
    t.datetime "firm_order_commitment_date",                                                   :null => false
    t.string   "audit_update_user_id",          :limit => 15,                                  :null => false
    t.datetime "audit_update_date_time",                                                       :null => false
    t.integer  "update_number",                 :limit => 10,   :precision => 10, :scale => 0, :null => false
    t.string   "description",                   :limit => 60
    t.string   "mailing_id",                    :limit => 16
    t.string   "region_rd",                     :limit => 16
    t.string   "customer_tracking_id",          :limit => 10
    t.string   "sales_organization_id",         :limit => 20
    t.string   "confirmation_output_device",    :limit => 10
    t.datetime "confirmation_date"
    t.string   "confirmation_subject",          :limit => 120
    t.string   "document_template_name",        :limit => 30
    t.string   "lan_path_file_string",          :limit => 1024
    t.string   "rejected_reason_description",   :limit => 360
    t.string   "language_rd",                   :limit => 16
    t.string   "sales_representative_name",     :limit => 60
    t.string   "sales_representative_dept",     :limit => 360
    t.string   "sales_representative_phone_no", :limit => 32
    t.string   "consultant_name",               :limit => 60
    t.string   "consultant_department",         :limit => 360
    t.string   "consultant_phone_number",       :limit => 32
    t.string   "provider_tracking_number",      :limit => 10
  end

  add_index "customer_order", ["customer_number"], :name => "custord_cust_ind", :tablespace => "indexes"
  add_index "customer_order", ["customer_tracking_id"], :name => "custord_ind1", :tablespace => "indexes"
  add_index "customer_order", ["mailing_id"], :name => "custord_mail_ind", :tablespace => "indexes"
  add_index "customer_order", ["provider_tracking_number"], :name => "custord_ind2", :tablespace => "indexes"
  add_index "customer_order", ["state_rd"], :name => "custord_ind3"

  create_table "customer_order_dependency", :id => false, :force => true do |t|
    t.string   "customer_order_id",      :limit => 10,                                :null => false
    t.string   "customer_order_dep_id",  :limit => 10,                                :null => false
    t.string   "manual_indicator",       :limit => 1,                                 :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
    t.integer  "update_number",          :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  add_index "customer_order_dependency", ["customer_order_id"], :name => "cod_idx"

  create_table "customer_specific_rate", :id => false, :force => true do |t|
    t.string   "tariff_model_entry_id",        :limit => 16,                                :null => false
    t.string   "contract_customer_number",     :limit => 20,                                :null => false
    t.datetime "effective_date",                                                            :null => false
    t.string   "effective_status",             :limit => 6,                                 :null => false
    t.string   "customer_specific_rate_id",    :limit => 16,                                :null => false
    t.string   "rate_value",                   :limit => 30,                                :null => false
    t.integer  "grid_row_number",              :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "tariff_model_area_version_id", :limit => 16,                                :null => false
    t.string   "audit_update_user_id",         :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                    :null => false
    t.integer  "update_number",                :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "test_mode_ind",                :limit => 1,                                 :null => false
    t.string   "change_group_id",              :limit => 30
    t.string   "bogus",                        :limit => 16
    t.string   "billing_name_1",               :limit => 60
  end

  add_index "customer_specific_rate", ["change_group_id"], :name => "csr_idx"
  add_index "customer_specific_rate", ["customer_specific_rate_id"], :name => "cs_uk", :unique => true, :tablespace => "indexes"
  add_index "customer_specific_rate", ["effective_date", "contract_customer_number"], :name => "cs_ind1", :tablespace => "indexes"
  add_index "customer_specific_rate", ["grid_row_number", "contract_customer_number", "effective_date"], :name => "cs_ind2", :tablespace => "indexes"

  create_table "customer_tax_exemption", :id => false, :force => true do |t|
    t.string   "customer_number",           :limit => 20,                                :null => false
    t.string   "exempt_authority",          :limit => 1,                                 :null => false
    t.string   "exempt_jurisdiction",       :limit => 9,                                 :null => false
    t.string   "tax_type_value",            :limit => 2,                                 :null => false
    t.datetime "effective_date",                                                         :null => false
    t.string   "customer_tax_exemption_id", :limit => 16,                                :null => false
    t.string   "effective_status",          :limit => 6,                                 :null => false
    t.string   "audit_update_user_id",      :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                 :null => false
    t.integer  "update_number",             :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  create_table "customized_message", :primary_key => "customer_message_id", :force => true do |t|
    t.integer  "production_run_idnumber", :limit => 10, :precision => 10, :scale => 0, :null => false
    t.datetime "cycle_due_date",                                                       :null => false
    t.string   "cycle_name",              :limit => 30
  end

  add_index "customized_message", ["production_run_idnumber", "customer_message_id"], :name => "czmsg_ind", :tablespace => "indexes"

  create_table "cycle", :id => false, :force => true do |t|
    t.string   "cycle_name",                  :limit => 30,                                                  :null => false
    t.datetime "effective_date",                                                                             :null => false
    t.string   "effective_status",            :limit => 6,                                                   :null => false
    t.string   "cycle_type",                  :limit => 2,                                                   :null => false
    t.datetime "due_date_time",                                                                              :null => false
    t.string   "holiday_indicator",           :limit => 1,                                                   :null => false
    t.string   "lock_indicator",              :limit => 1,                                                   :null => false
    t.string   "bill_verification_indicator", :limit => 1,                                                   :null => false
    t.string   "cycle_group_rd",              :limit => 16,                                                  :null => false
    t.string   "audit_update_user_id",        :limit => 15,                                                  :null => false
    t.datetime "audit_update_date_time",                                                                     :null => false
    t.integer  "update_number",               :limit => 10,  :precision => 10, :scale => 0,                  :null => false
    t.string   "exclude_detail_usage_ind",    :limit => 1,                                  :default => "T", :null => false
    t.integer  "target_cycle_due_day_number", :limit => 2,   :precision => 2,  :scale => 0,                  :null => false
    t.string   "description_string",          :limit => 600
    t.string   "customer_category_rd",        :limit => 16
    t.string   "customer_classification_rd",  :limit => 16
    t.string   "invoice_cycle_name",          :limit => 30
    t.integer  "pricing_delay",               :limit => 10,  :precision => 10, :scale => 0
    t.integer  "min_batch_size",              :limit => 10,  :precision => 10, :scale => 0
    t.string   "period_code",                 :limit => 5
    t.integer  "interval",                    :limit => 10,  :precision => 10, :scale => 0
    t.integer  "print_delay",                 :limit => 10,  :precision => 10, :scale => 0
    t.datetime "rerun_delay"
    t.datetime "rerun_due_date"
  end

  create_table "default_cml_script", :id => false, :force => true do |t|
    t.text     "cml_content"
    t.integer  "revision_number",        :limit => 10, :precision => 10, :scale => 0
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
  end

  create_table "dependency", :id => false, :force => true do |t|
    t.string   "previous_business_activity_id", :limit => 16,                                :null => false
    t.string   "next_business_activity_id",     :limit => 16,                                :null => false
    t.string   "previous_activity_root_id",     :limit => 16,                                :null => false
    t.string   "next_activity_root_id",         :limit => 16,                                :null => false
    t.string   "type",                          :limit => 16,                                :null => false
    t.string   "status",                        :limit => 16,                                :null => false
    t.string   "mandatory_indicator",           :limit => 1,                                 :null => false
    t.string   "lagging_indicator",             :limit => 1,                                 :null => false
    t.string   "audit_update_user_id",          :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                     :null => false
    t.integer  "update_number",                 :limit => 10, :precision => 10, :scale => 0, :null => false
    t.integer  "lag_time",                      :limit => 10, :precision => 10, :scale => 0
    t.string   "lag_time_unit",                 :limit => 10
    t.datetime "satisfaction_date_time"
  end

  add_index "dependency", ["next_activity_root_id"], :name => "dep_nextact_ind", :tablespace => "indexes"
  add_index "dependency", ["next_business_activity_id"], :name => "dep_nextba_ind", :tablespace => "indexes"
  add_index "dependency", ["previous_activity_root_id"], :name => "dep_prevact_ind", :tablespace => "indexes"

  create_table "detail_event_key", :id => false, :force => true do |t|
    t.datetime "start_date_time",                                                  :null => false
    t.string   "served_number",       :limit => 63,                                :null => false
    t.string   "other_number",        :limit => 63,                                :null => false
    t.integer  "units",               :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "event_id",            :limit => 20,                                :null => false
    t.string   "partition_group",     :limit => 30,                                :null => false
    t.datetime "partition_date_time",                                              :null => false
    t.string   "ne_identifier",       :limit => 10,                                :null => false
  end

  create_table "display_role", :id => false, :force => true do |t|
    t.string   "supported_object_id",      :limit => 20,                                :null => false
    t.string   "supported_object_type_rd", :limit => 16,                                :null => false
    t.string   "entity_id",                :limit => 16,                                :null => false
    t.datetime "effective_date",                                                        :null => false
    t.string   "customer_number",          :limit => 20,                                :null => false
    t.string   "effective_status",         :limit => 6,                                 :null => false
    t.string   "audit_update_user_id",     :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                :null => false
    t.integer  "update_number",            :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "address_id",               :limit => 16
    t.string   "access_information_id",    :limit => 16
  end

  create_table "document", :primary_key => "document_id", :force => true do |t|
    t.string   "mailing_id",                  :limit => 16,                                 :null => false
    t.datetime "print_date_time",                                                           :null => false
    t.string   "envelope_id",                 :limit => 16,                                 :null => false
    t.integer  "production_batch_idnumber",   :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.integer  "document_sort_value",         :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.integer  "reprint_count_value",         :limit => 4,   :precision => 4,  :scale => 0, :null => false
    t.string   "document_type_rd",            :limit => 16,                                 :null => false
    t.string   "output_type_rd",              :limit => 16,                                 :null => false
    t.string   "audit_update_user_id",        :limit => 15,                                 :null => false
    t.datetime "audit_update_date_time",                                                    :null => false
    t.string   "supported_object_type_rd",    :limit => 16
    t.datetime "supported_effective_date"
    t.string   "supported_second_value_name", :limit => 30
    t.string   "language_rd",                 :limit => 16
    t.string   "supported_object_id",         :limit => 20
    t.integer  "image_page_value",            :limit => 10,  :precision => 10, :scale => 0
    t.string   "special_handling_rd",         :limit => 16
    t.string   "template_filename",           :limit => 100
    t.string   "document_template_name",      :limit => 120
  end

  add_index "document", ["mailing_id", "print_date_time", "envelope_id"], :name => "doc_en_fk_i", :tablespace => "indexes"
  add_index "document", ["production_batch_idnumber"], :name => "doc_pb_fk_i", :tablespace => "indexes"
  add_index "document", ["supported_object_id"], :name => "doc_ind1", :tablespace => "indexes"

  create_table "document_file", :primary_key => "file_path", :force => true do |t|
    t.string   "document_id",               :limit => 20,                                :null => false
    t.integer  "production_batch_idnumber", :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "maintenance_indicator",     :limit => 1,                                 :null => false
    t.string   "audit_update_user_id",      :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                 :null => false
    t.integer  "copy_value",                :limit => 4,  :precision => 4,  :scale => 0
  end

  add_index "document_file", ["document_id"], :name => "df_docid_fk_i", :tablespace => "indexes"
  add_index "document_file", ["production_batch_idnumber", "maintenance_indicator"], :name => "df_doc_fk_i", :tablespace => "indexes"

  create_table "document_pattern", :id => false, :force => true do |t|
    t.string   "document_pattern_id",      :limit => 16,                                :null => false
    t.datetime "effective_date",                                                        :null => false
    t.string   "effective_status",         :limit => 6,                                 :null => false
    t.string   "mailing_id",               :limit => 16,                                :null => false
    t.string   "cycle_name",               :limit => 30,                                :null => false
    t.string   "document_template_name",   :limit => 30,                                :null => false
    t.string   "currency_rd",              :limit => 16,                                :null => false
    t.string   "hierarchy_indicator",      :limit => 1,                                 :null => false
    t.string   "language_rd",              :limit => 16,                                :null => false
    t.string   "output_device_rd",         :limit => 16,                                :null => false
    t.string   "supported_object_id",      :limit => 20,                                :null => false
    t.string   "supported_object_type_rd", :limit => 16,                                :null => false
    t.string   "zero_suppress_indicator",  :limit => 1,                                 :null => false
    t.string   "special_handling_rd",      :limit => 16,                                :null => false
    t.string   "audit_update_user_id",     :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                :null => false
    t.integer  "update_number",            :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  add_index "document_pattern", ["supported_object_id", "supported_object_type_rd"], :name => "dp_ind_1", :tablespace => "indexes"

  create_table "document_recipient", :id => false, :force => true do |t|
    t.string   "mailing_id",             :limit => 16,                                :null => false
    t.string   "document_recipient_id",  :limit => 16,                                :null => false
    t.datetime "effective_date",                                                      :null => false
    t.string   "customer_number",        :limit => 20,                                :null => false
    t.string   "entity_id",              :limit => 16,                                :null => false
    t.integer  "number_of_copies",       :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "effective_status",       :limit => 6,                                 :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
    t.integer  "update_number",          :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "access_information_id",  :limit => 16
    t.string   "address_id",             :limit => 16
  end

  add_index "document_recipient", ["access_information_id"], :name => "docr_accinf_ind", :tablespace => "indexes"
  add_index "document_recipient", ["address_id"], :name => "docr_addr_ind", :tablespace => "indexes"
  add_index "document_recipient", ["customer_number"], :name => "docr_cust_ind", :tablespace => "indexes"
  add_index "document_recipient", ["entity_id"], :name => "docr_entity_ind", :tablespace => "indexes"

  create_table "document_sequence_number", :id => false, :force => true do |t|
    t.string   "name",                   :limit => 30,                                :null => false
    t.integer  "start_value",            :limit => 10, :precision => 10, :scale => 0, :null => false
    t.integer  "length_value",           :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "allocated_indicator",    :limit => 1,                                 :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
    t.string   "allocator_id",           :limit => 20
  end

  create_table "document_sort", :id => false, :force => true do |t|
    t.string   "document_id",                    :limit => 20,                                  :null => false
    t.string   "file_path",                      :limit => 1024,                                :null => false
    t.string   "envelope_id",                    :limit => 16,                                  :null => false
    t.datetime "print_date_time",                                                               :null => false
    t.string   "mailing_id",                     :limit => 16,                                  :null => false
    t.integer  "production_run_idnumber",        :limit => 10,   :precision => 10, :scale => 0, :null => false
    t.integer  "production_batch_idnumber",      :limit => 10,   :precision => 10, :scale => 0, :null => false
    t.integer  "sort_order_sequence_number",     :limit => 10,   :precision => 10, :scale => 0, :null => false
    t.string   "output_type_rd",                 :limit => 16,                                  :null => false
    t.string   "audit_update_user_id",           :limit => 15,                                  :null => false
    t.datetime "audit_update_date_time",                                                        :null => false
    t.integer  "copy_value",                     :limit => 4,    :precision => 4,  :scale => 0
    t.string   "doc_file_info_original_ind",     :limit => 1
    t.string   "group_key_text",                 :limit => 360
    t.string   "account_customer_number",        :limit => 20
    t.string   "top_in_hierarchy_customer_num",  :limit => 20
    t.integer  "image_page_value",               :limit => 10,   :precision => 10, :scale => 0
    t.decimal  "document_weight_number",                         :precision => 18, :scale => 6
    t.string   "mailing_customer_number",        :limit => 20
    t.string   "recipient_id",                   :limit => 20,                                  :null => false
    t.integer  "number_of_copies",               :limit => 10,   :precision => 10, :scale => 0
    t.string   "primary_indicator",              :limit => 1
    t.string   "action_rule_name",               :limit => 30
    t.string   "document_class_name",            :limit => 30
    t.string   "invoice_id",                     :limit => 20
    t.string   "account_number",                 :limit => 20
    t.datetime "bill_period_start_date_time"
    t.datetime "bil_period_end_date_time"
    t.string   "currency_rd",                    :limit => 16
    t.string   "doc_pattern_customer_number",    :limit => 20
    t.string   "language_rd",                    :limit => 16
    t.string   "simplex_only_indicator",         :limit => 1
    t.string   "special_handling_code",          :limit => 16
    t.string   "deletion_allowed_indicator",     :limit => 1
    t.string   "template_filename",              :limit => 100
    t.string   "sort_key_text",                  :limit => 360
    t.string   "customer_category_rd",           :limit => 16
    t.string   "marketing_information_ind",      :limit => 1
    t.string   "printer_destination_rd",         :limit => 16
    t.string   "duplex_capable_indicator",       :limit => 1
    t.string   "city_name",                      :limit => 40
    t.string   "city_suffix_name",               :limit => 30
    t.string   "contact_name",                   :limit => 60
    t.string   "country_rd",                     :limit => 16
    t.string   "email_address",                  :limit => 129
    t.string   "entity_type",                    :limit => 2
    t.string   "forename",                       :limit => 30
    t.string   "nobility_prefix_description",    :limit => 30
    t.string   "organization_suffix_name",       :limit => 30
    t.string   "organization_type_rd",           :limit => 16
    t.string   "phone_number",                   :limit => 32
    t.string   "postal_code",                    :limit => 10
    t.string   "post_office_box",                :limit => 10
    t.string   "province_name",                  :limit => 30
    t.string   "salutation_description",         :limit => 30
    t.string   "additional_address_description", :limit => 60
    t.string   "second_add_address_description", :limit => 60
    t.string   "street_name",                    :limit => 40
    t.string   "street_number",                  :limit => 10
    t.string   "street_number_suffix",           :limit => 10
    t.string   "surname",                        :limit => 60
    t.string   "surname_prefix_description",     :limit => 30
    t.string   "title_code",                     :limit => 16
    t.string   "table_of_contents_indicator",    :limit => 1
    t.string   "carrier_route_string",           :limit => 4
    t.string   "document_type_rd",               :limit => 16
    t.string   "output_type_category_rd",        :limit => 16
    t.decimal  "gross_total_amount",                             :precision => 18, :scale => 6
    t.decimal  "net_total_amount",                               :precision => 18, :scale => 6
    t.decimal  "tax_charge_total_amount",                        :precision => 18, :scale => 6
  end

  add_index "document_sort", ["action_rule_name", "production_run_idnumber", "production_batch_idnumber"], :name => "dsrt_ue1", :tablespace => "indexes"

  create_table "document_template", :id => false, :force => true do |t|
    t.string   "document_template_name",     :limit => 30,                                 :null => false
    t.datetime "document_template_eff_dt",                                                 :null => false
    t.string   "effective_status",           :limit => 6,                                  :null => false
    t.string   "template_filename",          :limit => 100,                                :null => false
    t.string   "document_status",            :limit => 6,                                  :null => false
    t.string   "document_type_name",         :limit => 30,                                 :null => false
    t.string   "deletion_allowed_indicator", :limit => 1,                                  :null => false
    t.string   "output_format_name",         :limit => 30,                                 :null => false
    t.string   "audit_update_user_id",       :limit => 15,                                 :null => false
    t.datetime "audit_update_date_time",                                                   :null => false
    t.string   "include_parent_indicator",   :limit => 1,                                  :null => false
    t.integer  "update_number",              :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.string   "sample_template_filename",   :limit => 100
    t.string   "description_string",         :limit => 600
    t.string   "simplex_only_indicator",     :limit => 1
  end

  create_table "domain_detail", :id => false, :force => true do |t|
    t.string   "domain_header_name",     :limit => 30,                                :null => false
    t.string   "domain_value_string",    :limit => 30,                                :null => false
    t.string   "domain_indicator",       :limit => 1,                                 :null => false
    t.integer  "update_number",          :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
  end

  create_table "domain_header", :primary_key => "domain_header_name", :force => true do |t|
    t.string   "mask_name",              :limit => 60,                                :null => false
    t.string   "type_name",              :limit => 30,                                :null => false
    t.string   "datatype_name",          :limit => 30,                                :null => false
    t.integer  "update_number",          :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
  end

  create_table "dunning_process_stopover", :primary_key => "dunning_process_stopover_id", :force => true do |t|
    t.string   "invoice_id",             :limit => 20,                                 :null => false
    t.datetime "invoice_print_date",                                                   :null => false
    t.datetime "start_date",                                                           :null => false
    t.string   "account_number",         :limit => 20,                                 :null => false
    t.string   "reason",                 :limit => 360,                                :null => false
    t.datetime "resume_date",                                                          :null => false
    t.decimal  "invoice_amount",                        :precision => 18, :scale => 6, :null => false
    t.string   "currency_rd",            :limit => 16,                                 :null => false
    t.datetime "audit_update_date_time",                                               :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                 :null => false
    t.integer  "update_number",          :limit => 10,  :precision => 10, :scale => 0, :null => false
  end

  create_table "ecp_inserter_statistic", :id => false, :force => true do |t|
    t.string   "input_filename",     :limit => 100,                                :null => false
    t.datetime "process_start_date",                                               :null => false
    t.datetime "process_end_date",                                                 :null => false
    t.string   "ecp_filename",       :limit => 100,                                :null => false
    t.integer  "ecp_events",         :limit => 10,  :precision => 10, :scale => 0, :null => false
  end

  create_table "ect_customized_rate", :id => false, :force => true do |t|
    t.string   "event_creation_template_id", :limit => 16,                                :null => false
    t.string   "ect_customized_rate_id",     :limit => 16,                                :null => false
    t.string   "related_object_id_string",   :limit => 30,                                :null => false
    t.datetime "effective_date",                                                          :null => false
    t.string   "effective_status",           :limit => 6,                                 :null => false
    t.decimal  "customized_rate_real",                     :precision => 18, :scale => 6, :null => false
    t.string   "rate_type_rd",               :limit => 16,                                :null => false
    t.string   "relation_type_rd",           :limit => 16,                                :null => false
    t.string   "test_mode_ind",              :limit => 1,                                 :null => false
    t.string   "audit_update_user_id",       :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                  :null => false
    t.integer  "update_number",              :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "change_group_id",            :limit => 30
  end

  add_index "ect_customized_rate", ["change_group_id"], :name => "ect_idx"
  add_index "ect_customized_rate", ["ect_customized_rate_id", "effective_status", "effective_date"], :name => "ecr_ind1", :tablespace => "indexes"
  add_index "ect_customized_rate", ["event_creation_template_id", "related_object_id_string", "effective_date", "effective_status"], :name => "ecr_ind2", :unique => true, :tablespace => "indexes"
  add_index "ect_customized_rate", ["related_object_id_string"], :name => "ecr_ind3", :tablespace => "indexes"

  create_table "entity", :primary_key => "entity_id", :force => true do |t|
    t.string   "name",                          :limit => 60,                                 :null => false
    t.string   "salutation_description",        :limit => 30,                                 :null => false
    t.string   "entity_type",                   :limit => 2,                                  :null => false
    t.datetime "termination_date",                                                            :null => false
    t.raw      "nlssort_name_raw",              :limit => 500,                                :null => false
    t.string   "nlsupper_name",                 :limit => 60,                                 :null => false
    t.string   "audit_update_user_id",          :limit => 15,                                 :null => false
    t.datetime "audit_update_date_time",                                                      :null => false
    t.integer  "update_number",                 :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.string   "organization_type_rd",          :limit => 16
    t.string   "domestic_organization_ind",     :limit => 1
    t.raw      "nlssort_forename_raw",          :limit => 500
    t.string   "nlsupper_forename",             :limit => 30
    t.string   "customer_number",               :limit => 20
    t.string   "incorporation_number_id",       :limit => 20
    t.string   "industrial_sector_rd",          :limit => 16
    t.string   "incorporation_type_rd",         :limit => 16
    t.string   "incorporation_city_name",       :limit => 30
    t.string   "primary_access_information_id", :limit => 16
    t.string   "primary_address_id",            :limit => 16
    t.string   "organization_suffix_name",      :limit => 30
    t.string   "id_card_country_rd",            :limit => 16
    t.datetime "id_card_expiration_date"
    t.string   "id_card_type_rd",               :limit => 16
    t.string   "surname_prefix_description",    :limit => 30
    t.string   "forename",                      :limit => 30
    t.string   "title_description",             :limit => 30
    t.string   "nobility_prefix_description",   :limit => 30
    t.string   "marital_status_rd",             :limit => 16
    t.string   "profession_name",               :limit => 30
    t.datetime "birth_date"
    t.string   "id_card_number",                :limit => 20
    t.string   "spoken_language_rd",            :limit => 16
  end

  add_index "entity", ["SOUNDEX(\"NAME\")", "SOUNDEX(\"FORENAME\")"], :name => "entity_ind5", :tablespace => "indexes"
  add_index "entity", ["customer_number"], :name => "entity_cust_number_ind", :unique => true, :tablespace => "indexes"
  add_index "entity", ["entity_type", "nlssort_name_raw", "nlssort_forename_raw", "entity_id"], :name => "entity_tnfe_ind", :unique => true, :tablespace => "indexes"
  add_index "entity", ["nlssort_name_raw", "nlssort_forename_raw", "entity_id"], :name => "entity_cust_nfe_ind", :tablespace => "indexes"
  add_index "entity", ["nlsupper_name", "nlsupper_forename"], :name => "entity_nls_nf_ind", :tablespace => "indexes"

  create_table "entity_destination", :id => false, :force => true do |t|
    t.string   "file_type_name",         :limit => 30, :null => false
    t.string   "external_entity_name",   :limit => 30, :null => false
    t.string   "audit_update_user_id",   :limit => 15, :null => false
    t.datetime "audit_update_date_time",               :null => false
  end

  create_table "envelope", :id => false, :force => true do |t|
    t.string   "mailing_id",                :limit => 16,                                :null => false
    t.datetime "print_date_time",                                                        :null => false
    t.string   "envelope_id",               :limit => 16,                                :null => false
    t.string   "customer_number",           :limit => 20,                                :null => false
    t.integer  "production_batch_idnumber", :limit => 10, :precision => 10, :scale => 0, :null => false
    t.integer  "production_run_idnumber",   :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "recipient_id",              :limit => 20,                                :null => false
    t.string   "audit_update_user_id",      :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                 :null => false
  end

  add_index "envelope", ["production_batch_idnumber"], :name => "en_ind2", :tablespace => "indexes"

  create_table "envelope_insert", :id => false, :force => true do |t|
    t.string   "mailing_id",                :limit => 16,                                :null => false
    t.datetime "print_date_time",                                                        :null => false
    t.string   "envelope_id",               :limit => 16,                                :null => false
    t.string   "insert_name",               :limit => 30,                                :null => false
    t.integer  "production_batch_idnumber", :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "audit_update_user_id",      :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                 :null => false
    t.integer  "insert_weight_value",       :limit => 10, :precision => 10, :scale => 0
    t.string   "slot",                      :limit => 30
  end

  add_index "envelope_insert", ["production_batch_idnumber"], :name => "ei_prb_fk", :tablespace => "indexes"

  create_table "ep_cc_synch", :primary_key => "filename", :force => true do |t|
    t.datetime "process_start_date",                                                     :null => false
    t.string   "ras_complete_indicator",    :limit => 1,                                 :null => false
    t.integer  "production_batch_idnumber", :limit => 10, :precision => 10, :scale => 0
  end

  create_table "erp_characteristic", :primary_key => "name", :force => true do |t|
    t.string "class_name",  :limit => 30, :null => false
    t.string "object_name", :limit => 30, :null => false
    t.string "field_name",  :limit => 30, :null => false
  end

  create_table "erp_event_attribute", :id => false, :force => true do |t|
    t.string   "event_attribute_name",     :limit => 30,                                 :null => false
    t.string   "event_type_name",          :limit => 30,                                 :null => false
    t.string   "attribute_path_name_text", :limit => 360,                                :null => false
    t.string   "domain_header_name",       :limit => 30,                                 :null => false
    t.integer  "update_number",            :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.string   "audit_update_user_id",     :limit => 15,                                 :null => false
    t.datetime "audit_update_date_time",                                                 :null => false
  end

  add_index "erp_event_attribute", ["attribute_path_name_text", "domain_header_name"], :name => "eea_apnt_ind", :unique => true, :tablespace => "indexes"
  add_index "erp_event_attribute", ["domain_header_name"], :name => "eea_idx"

  create_table "error_admin_error_group", :id => false, :force => true do |t|
    t.string   "login_id",               :limit => 30,                                :null => false
    t.integer  "group_id_number",        :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
    t.integer  "update_number",          :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  add_index "error_admin_error_group", ["group_id_number"], :name => "ea_egc_egc_fk_i", :tablespace => "indexes"

  create_table "error_administrator", :primary_key => "login_id", :force => true do |t|
    t.string   "admin_type_identifier",  :limit => 10,                                :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
    t.integer  "update_number",          :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  create_table "error_attribute", :id => false, :force => true do |t|
    t.integer "code_id_number",           :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.string  "attribute_path_name_text", :limit => 360,                                :null => false
  end

  create_table "error_batch", :primary_key => "batch_number", :force => true do |t|
    t.integer  "file_sequence_number",   :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.integer  "processed_by_enum",      :limit => 3,   :precision => 3,  :scale => 0, :null => false
    t.string   "batch_status",           :limit => 6,                                  :null => false
    t.string   "xml_version_string",     :limit => 100,                                :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                 :null => false
    t.datetime "audit_update_date_time",                                               :null => false
    t.integer  "update_number",          :limit => 10,  :precision => 10, :scale => 0, :null => false
  end

  create_table "error_event", :id => false, :force => true do |t|
    t.string  "event_id",                 :limit => 30,                                :null => false
    t.integer "file_id_number",           :limit => 10, :precision => 10, :scale => 0, :null => false
    t.integer "event_position_id_number", :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string  "status",                   :limit => 6,                                 :null => false
  end

  add_index "error_event", ["file_id_number"], :name => "ere_idx"
  add_index "error_event", ["status"], :name => "ee1_s_ind", :tablespace => "indexes"

  create_table "error_event_error_reason", :primary_key => "code_id_number", :force => true do |t|
    t.string  "event_id",              :limit => 30,                                :null => false
    t.integer "file_id_number",        :limit => 10, :precision => 10, :scale => 0, :null => false
    t.integer "reason_code_id_number", :limit => 10, :precision => 10, :scale => 0, :null => false
    t.integer "process_id_number",     :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string  "status",                :limit => 6,                                 :null => false
  end

  add_index "error_event_error_reason", ["event_id", "file_id_number", "reason_code_id_number", "process_id_number", "status"], :name => "eeer_ind", :tablespace => "indexes"
  add_index "error_event_error_reason", ["reason_code_id_number", "process_id_number"], :name => "eeer_idx"

  create_table "error_file", :primary_key => "file_id_number", :force => true do |t|
    t.integer "process_id_number", :limit => 10,   :precision => 10, :scale => 0, :null => false
    t.string  "ne_identifier",     :limit => 10,                                  :null => false
    t.string  "file_path",         :limit => 1024,                                :null => false
    t.string  "status",            :limit => 6,                                   :null => false
  end

  add_index "error_file", ["file_path"], :name => "ef_fp_ind", :tablespace => "indexes"
  add_index "error_file", ["process_id_number"], :name => "ef_pin_ind", :tablespace => "indexes"

  create_table "error_group_code", :primary_key => "group_id_number", :force => true do |t|
    t.string   "description",            :limit => 60,                                :null => false
    t.string   "error_group_name",       :limit => 30,                                :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
    t.integer  "update_number",          :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  create_table "error_group_error_reason", :id => false, :force => true do |t|
    t.integer  "group_id_number",        :limit => 10, :precision => 10, :scale => 0, :null => false
    t.integer  "reason_code_id_number",  :limit => 10, :precision => 10, :scale => 0, :null => false
    t.integer  "process_id_number",      :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
    t.integer  "update_number",          :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  add_index "error_group_error_reason", ["reason_code_id_number", "process_id_number"], :name => "egc_erc_erc_fk_i", :tablespace => "indexes"

  create_table "error_reason_code", :id => false, :force => true do |t|
    t.integer "reason_code_id_number",   :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.integer "process_id_number",       :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.string  "description",             :limit => 360,                                :null => false
    t.string  "send_external_indicator", :limit => 1,                                  :null => false
  end

# Could not dump table "errored_event" because of following StandardError
#   Unknown type 'XMLTYPE' for column 'errored_event'

  create_table "event_creation_template", :primary_key => "event_creation_template_ver_id", :force => true do |t|
    t.string   "event_creation_template_id", :limit => 16,                                 :null => false
    t.datetime "effective_date",                                                           :null => false
    t.string   "code",                       :limit => 5,                                  :null => false
    t.string   "name",                       :limit => 60,                                 :null => false
    t.string   "service_code",               :limit => 5,                                  :null => false
    t.string   "usage_mode_value",           :limit => 16,                                 :null => false
    t.string   "charge_occurrence_type",     :limit => 2,                                  :null => false
    t.string   "effective_status",           :limit => 6,                                  :null => false
    t.decimal  "amount",                                    :precision => 18, :scale => 6, :null => false
    t.string   "billing_name_1",             :limit => 30,                                 :null => false
    t.string   "audit_update_user_id",       :limit => 15,                                 :null => false
    t.datetime "audit_update_date_time",                                                   :null => false
    t.integer  "update_number",              :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.string   "apply_min_period_indicator", :limit => 1,                                  :null => false
    t.integer  "minimum_factor",             :limit => 3,   :precision => 3,  :scale => 0, :null => false
    t.string   "test_mode_ind",              :limit => 1,                                  :null => false
    t.string   "billing_name_2",             :limit => 30
    t.string   "descriptive_text",           :limit => 360
    t.string   "period_type_value",          :limit => 16
    t.integer  "period_factor",              :limit => 3,   :precision => 3,  :scale => 0
    t.string   "fractionalization_rd",       :limit => 16
    t.string   "rate_plan_code",             :limit => 5
    t.string   "fractionalization_app_rd",   :limit => 16
    t.string   "change_group_id",            :limit => 30
    t.datetime "historical_date"
  end

  add_index "event_creation_template", ["change_group_id"], :name => "ecr_idx"
  add_index "event_creation_template", ["code", "effective_date", "effective_status"], :name => "ect_ind_3", :tablespace => "indexes"
  add_index "event_creation_template", ["event_creation_template_id", "effective_status", "effective_date"], :name => "ect_ind_4", :tablespace => "indexes"
  add_index "event_creation_template", ["name"], :name => "ect_ind_2", :tablespace => "indexes"
  add_index "event_creation_template", ["service_code", "usage_mode_value", "charge_occurrence_type", "effective_date"], :name => "ect_rcp_i", :tablespace => "indexes"

  create_table "event_summary", :id => false, :force => true do |t|
    t.string   "account_number",               :limit => 20,                                :null => false
    t.integer  "sequence_number",              :limit => 10, :precision => 10, :scale => 0, :null => false
    t.integer  "usage_sequence_number",        :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "price_plan_code",              :limit => 5,                                 :null => false
    t.datetime "price_plan_effective_date",                                                 :null => false
    t.string   "algorithm_id",                 :limit => 16,                                :null => false
    t.integer  "process_step_order",           :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "tariff_model_area_version_id", :limit => 16,                                :null => false
    t.string   "tme_id",                       :limit => 16,                                :null => false
    t.string   "tax_code",                     :limit => 5,                                 :null => false
    t.integer  "tax_code_version_number",      :limit => 4,  :precision => 4,  :scale => 0, :null => false
    t.string   "originating_tax_jurisdiction", :limit => 12,                                :null => false
    t.string   "terminating_tax_jurisdiction", :limit => 12,                                :null => false
    t.string   "charge_to_tax_jurisdiction",   :limit => 12,                                :null => false
    t.string   "vertex_tax_jurisdiction",      :limit => 12,                                :null => false
    t.string   "incorporated_code",            :limit => 1,                                 :null => false
    t.string   "tax_category_id",              :limit => 20,                                :null => false
    t.string   "resale_indicator",             :limit => 1,                                 :null => false
    t.string   "customer_indicator",           :limit => 1,                                 :null => false
    t.string   "utility_indicator",            :limit => 1,                                 :null => false
    t.string   "revenue_acct_code_string",     :limit => 20,                                :null => false
    t.string   "price_plan_subscription_id",   :limit => 30,                                :null => false
    t.string   "originating_switch_id",        :limit => 11,                                :null => false
    t.string   "other_switch_id",              :limit => 11,                                :null => false
    t.string   "terminating_switch_id",        :limit => 11,                                :null => false
    t.string   "contract_customer_number",     :limit => 20,                                :null => false
    t.string   "customer_specific_rate_id",    :limit => 16,                                :null => false
    t.string   "summary_identifier",           :limit => 16,                                :null => false
    t.datetime "event_accumulation_date",                                                   :null => false
    t.string   "partition_group",              :limit => 30,                                :null => false
    t.datetime "partition_date_time",                                                       :null => false
    t.integer  "rated_volume",                 :limit => 20, :precision => 20, :scale => 0, :null => false
    t.decimal  "rated_quantity",                             :precision => 18, :scale => 6, :null => false
    t.decimal  "rated_charge",                               :precision => 18, :scale => 6, :null => false
    t.decimal  "tax_info",                                   :precision => 18, :scale => 6, :null => false
    t.string   "recurring_indicator",          :limit => 1,                                 :null => false
    t.string   "minimum_charge_indicator",     :limit => 1,                                 :null => false
    t.string   "process_step_id",              :limit => 16,                                :null => false
    t.string   "multi_period_indicator",       :limit => 1,                                 :null => false
    t.string   "account_discount_indicator",   :limit => 1,                                 :null => false
  end

  create_table "exclude_event_delete", :primary_key => "account_number", :force => true do |t|
  end

  create_table "execution_condition", :primary_key => "execution_condition_id", :force => true do |t|
    t.string   "branch_id",                :limit => 16,                                  :null => false
    t.string   "execution_condition_name", :limit => 30,                                  :null => false
    t.string   "audit_update_user_id",     :limit => 15,                                  :null => false
    t.datetime "audit_update_date_time",                                                  :null => false
    t.integer  "update_number",            :limit => 10,   :precision => 10, :scale => 0, :null => false
    t.string   "expression_string",        :limit => 2000
    t.string   "descriptive_text",         :limit => 360
  end

  add_index "execution_condition", ["branch_id"], :name => "ec_bra_fk_i", :tablespace => "indexes"

  create_table "explicit_link", :id => false, :force => true do |t|
    t.string   "dest_process_step_id",   :limit => 16,                                :null => false
    t.string   "link_kind",              :limit => 2,                                 :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
    t.integer  "update_number",          :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "source_process_step_id", :limit => 16
  end

  add_index "explicit_link", ["dest_process_step_id"], :name => "exl_idx"
  add_index "explicit_link", ["source_process_step_id", "dest_process_step_id"], :name => "exl_uc", :unique => true, :tablespace => "indexes"

  create_table "expression_literal", :primary_key => "expression_literal_id", :force => true do |t|
    t.string   "condition_expression_id",     :limit => 16,                                :null => false
    t.string   "audit_update_user_id",        :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                   :null => false
    t.integer  "update_number",               :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "priceable_char_value_id",     :limit => 16
    t.string   "price_plan_option_value_id",  :limit => 16
    t.string   "priceable_characteristic_id", :limit => 16
    t.string   "characteristic_value_rd",     :limit => 16
    t.string   "erp_value_description",       :limit => 30
    t.string   "measure_unit_code",           :limit => 5
  end

  add_index "expression_literal", ["condition_expression_id"], :name => "el_cce_fk_i", :tablespace => "indexes"
  add_index "expression_literal", ["measure_unit_code"], :name => "expl_idx"
  add_index "expression_literal", ["price_plan_option_value_id"], :name => "e2l_idx"
  add_index "expression_literal", ["priceable_characteristic_id"], :name => "el_idx"

  create_table "ext_characteristic_value", :primary_key => "characteristic_value_id", :force => true do |t|
    t.string   "service_char_code",      :limit => 5,                                 :null => false
    t.string   "value_type_ind",         :limit => 1,                                 :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
    t.integer  "update_number",          :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "d_value",                :limit => 30
    t.string   "c_minimum_value",        :limit => 30
    t.string   "c_maximum_value",        :limit => 30
    t.string   "c_default_value",        :limit => 30
    t.string   "measure_unit_code",      :limit => 5
  end

  add_index "ext_characteristic_value", ["measure_unit_code"], :name => "ecv_idx"
  add_index "ext_characteristic_value", ["service_char_code"], :name => "excv_idx"

  create_table "ext_customer_order", :primary_key => "customer_order_id", :force => true do |t|
    t.datetime "confirmation_date",                                                   :null => false
    t.string   "street_name",            :limit => 40
    t.string   "street_number",          :limit => 10
    t.string   "street_number_suffix",   :limit => 10
    t.string   "addl_address_text",      :limit => 35
    t.string   "city",                   :limit => 40,                                :null => false
    t.string   "city_suffix",            :limit => 30
    t.string   "postal_code",            :limit => 10
    t.string   "post_office_box",        :limit => 10
    t.string   "region_rd",              :limit => 16
    t.string   "country_rd",             :limit => 16,                                :null => false
    t.binary   "customer_facade"
    t.datetime "audit_update_date_time",                                              :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.integer  "update_number",          :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  create_table "ext_customer_order_dep", :id => false, :force => true do |t|
    t.string   "customer_order_id",      :limit => 30,                                :null => false
    t.string   "customer_order_dep_id",  :limit => 10,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.integer  "update_number",          :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  create_table "ext_measure_unit", :primary_key => "measure_unit_code", :force => true do |t|
    t.string   "name",                   :limit => 30,                                 :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                 :null => false
    t.datetime "audit_update_date_time",                                               :null => false
    t.integer  "update_number",          :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.string   "descriptive_text",       :limit => 360
  end

  create_table "ext_product_version", :id => false, :force => true do |t|
    t.string   "product_version_code",   :limit => 5,                                  :null => false
    t.string   "product_code",           :limit => 5,                                  :null => false
    t.datetime "effective_date",                                                       :null => false
    t.string   "effective_status",       :limit => 6,                                  :null => false
    t.string   "name",                   :limit => 60,                                 :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                 :null => false
    t.datetime "audit_update_date_time",                                               :null => false
    t.integer  "update_number",          :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.string   "descriptive_text",       :limit => 360
  end

  create_table "ext_service_char_value", :id => false, :force => true do |t|
    t.string   "service_code",             :limit => 5,                                 :null => false
    t.string   "service_version_code",     :limit => 5,                                 :null => false
    t.string   "service_char_code",        :limit => 5,                                 :null => false
    t.string   "fixed_variable_indicator", :limit => 1,                                 :null => false
    t.string   "audit_update_user_id",     :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                :null => false
    t.integer  "update_number",            :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "value_type_ind",           :limit => 1
    t.string   "distinct_value",           :limit => 30
    t.string   "continuous_value",         :limit => 30
    t.string   "measure_unit_code",        :limit => 5
  end

  add_index "ext_service_char_value", ["measure_unit_code"], :name => "esc_idx"
  add_index "ext_service_char_value", ["service_code", "service_version_code"], :name => "escv_idx"

  create_table "ext_service_characteristic", :primary_key => "service_char_code", :force => true do |t|
    t.string   "name",                      :limit => 30,                                 :null => false
    t.string   "audit_update_user_id",      :limit => 15,                                 :null => false
    t.datetime "audit_update_date_time",                                                  :null => false
    t.integer  "update_number",             :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.string   "datatype_value",            :limit => 16
    t.string   "descriptive_text",          :limit => 360
    t.string   "value_type_ind",            :limit => 1
    t.string   "characteristic_type_value", :limit => 16
    t.string   "sm_only_ind",               :limit => 1
  end

  create_table "ext_service_order_dep", :id => false, :force => true do |t|
    t.string   "service_order_id",       :limit => 16,                                :null => false
    t.string   "service_order_dep_id",   :limit => 16,                                :null => false
    t.string   "customer_order_id",      :limit => 30,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.integer  "update_number",          :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  add_index "ext_service_order_dep", ["service_order_dep_id"], :name => "esod_ind1", :tablespace => "indexes"

  create_table "ext_service_usage_mode", :id => false, :force => true do |t|
    t.string   "service_code",           :limit => 5,                                 :null => false
    t.string   "usage_mode_value",       :limit => 16,                                :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
    t.integer  "update_number",          :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  create_table "ext_service_version", :id => false, :force => true do |t|
    t.string   "service_code",           :limit => 5,                                  :null => false
    t.string   "service_version_code",   :limit => 5,                                  :null => false
    t.datetime "effective_date",                                                       :null => false
    t.string   "effective_status",       :limit => 6,                                  :null => false
    t.string   "name",                   :limit => 30,                                 :null => false
    t.string   "provisioned_indicator",  :limit => 1,                                  :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                 :null => false
    t.datetime "audit_update_date_time",                                               :null => false
    t.integer  "update_number",          :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.string   "descriptive_text",       :limit => 360
  end

  create_table "external_doc_link", :id => false, :force => true do |t|
    t.string   "referring_object_id",      :limit => 16,                                :null => false
    t.string   "external_document_id",     :limit => 16,                                :null => false
    t.string   "referring_object_root_id", :limit => 16,                                :null => false
    t.string   "audit_update_user_id",     :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                :null => false
    t.integer  "update_number",            :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  add_index "external_doc_link", ["external_document_id"], :name => "edl_fk1_i", :tablespace => "indexes"

  create_table "external_doc_path", :primary_key => "external_document_id", :force => true do |t|
    t.string   "audit_update_user_id",   :limit => 15,                                  :null => false
    t.datetime "audit_update_date_time",                                                :null => false
    t.integer  "update_number",          :limit => 10,   :precision => 10, :scale => 0, :null => false
    t.string   "path",                   :limit => 1024
    t.string   "title_name",             :limit => 30
  end

  create_table "external_entity_connection", :id => false, :force => true do |t|
    t.string   "external_entity_name",    :limit => 30,   :null => false
    t.string   "network_address_id_text", :limit => 120,  :null => false
    t.datetime "effective_date",                          :null => false
    t.string   "effective_status",        :limit => 6,    :null => false
    t.string   "description",             :limit => 60,   :null => false
    t.string   "protocol_name",           :limit => 30,   :null => false
    t.string   "output_directory_path",   :limit => 1024, :null => false
    t.string   "audit_update_user_id",    :limit => 15,   :null => false
    t.datetime "audit_update_date_time",                  :null => false
    t.string   "entity_account",          :limit => 20
    t.string   "entity_password",         :limit => 40
  end

  create_table "external_sys_usage_mode", :id => false, :force => true do |t|
    t.string   "external_system_name",    :limit => 30,                                                  :null => false
    t.string   "ext_sys_usage_mode_name", :limit => 30,                                                  :null => false
    t.string   "description_text",        :limit => 1440,                                                :null => false
    t.string   "begin_retry_after_time",  :limit => 15
    t.string   "begin_retry_after_unit",  :limit => 15
    t.integer  "maximum_retry_number",    :limit => 10,   :precision => 10, :scale => 0, :default => -1, :null => false
    t.integer  "update_number",           :limit => 10,   :precision => 10, :scale => 0,                 :null => false
    t.integer  "revision_number",         :limit => 10,   :precision => 10, :scale => 0,                 :null => false
    t.string   "audit_update_user_id",    :limit => 15,                                                  :null => false
    t.datetime "audit_update_date_time",                                                                 :null => false
  end

  create_table "external_sys_usage_mode_retry", :primary_key => "retry_rule_id", :force => true do |t|
    t.string   "external_system_name",    :limit => 30,                                :null => false
    t.string   "ext_sys_usage_mode_name", :limit => 30,                                :null => false
    t.string   "day_of_week",             :limit => 15,                                :null => false
    t.string   "start_time",              :limit => 15,                                :null => false
    t.string   "end_time",                :limit => 15,                                :null => false
    t.string   "frequency_time",          :limit => 15,                                :null => false
    t.string   "frequency_unit",          :limit => 15,                                :null => false
    t.string   "sr_state",                :limit => 10,                                :null => false
    t.integer  "revision_number",         :limit => 10, :precision => 10, :scale => 0, :null => false
    t.integer  "update_number",           :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "audit_update_user_id",    :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                               :null => false
    t.string   "error_pattern",           :limit => 16
  end

  add_index "external_sys_usage_mode_retry", ["external_system_name", "ext_sys_usage_mode_name"], :name => "ext_sys_usage_mode_retry_ind1"

  create_table "external_system", :primary_key => "external_system_name", :force => true do |t|
    t.string   "description_text",       :limit => 1440,                                                :null => false
    t.string   "begin_retry_after_time", :limit => 15
    t.string   "begin_retry_after_unit", :limit => 15
    t.integer  "maximum_retry_number",   :limit => 10,   :precision => 10, :scale => 0, :default => -1, :null => false
    t.integer  "update_number",          :limit => 10,   :precision => 10, :scale => 0,                 :null => false
    t.integer  "revision_number",        :limit => 10,   :precision => 10, :scale => 0,                 :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                                  :null => false
    t.datetime "audit_update_date_time",                                                                :null => false
  end

  create_table "external_system_retry", :id => false, :force => true do |t|
    t.string   "retry_rule_id",          :limit => 16,                                :null => false
    t.string   "external_system_name",   :limit => 30,                                :null => false
    t.string   "day_of_week",            :limit => 15,                                :null => false
    t.string   "start_time",             :limit => 15,                                :null => false
    t.string   "end_time",               :limit => 15,                                :null => false
    t.string   "frequency_time",         :limit => 15,                                :null => false
    t.string   "frequency_unit",         :limit => 15,                                :null => false
    t.string   "sr_state",               :limit => 10,                                :null => false
    t.integer  "revision_number",        :limit => 10, :precision => 10, :scale => 0, :null => false
    t.integer  "update_number",          :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
    t.string   "error_pattern",          :limit => 16
  end

  add_index "external_system_retry", ["external_system_name"], :name => "external_system_retry_ind1"

  create_table "external_tax_exemption", :id => false, :force => true do |t|
    t.string   "customer_number",        :limit => 20,                                :null => false
    t.string   "authority",              :limit => 4,                                 :null => false
    t.string   "exempt_indicator",       :limit => 1,                                 :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
    t.integer  "update_number",          :limit => 10, :precision => 10, :scale => 0, :null => false
    t.datetime "start_date"
    t.datetime "expiry_date"
    t.string   "certificate_id",         :limit => 15
  end

  create_table "fe_catalog_location", :id => false, :force => true do |t|
    t.string   "file_path",              :limit => 1024,                                :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                  :null => false
    t.datetime "audit_update_date_time",                                                :null => false
    t.integer  "update_number",          :limit => 10,   :precision => 10, :scale => 0, :null => false
    t.string   "file_name",              :limit => 100,                                 :null => false
  end

  create_table "feedbacks", :force => true do |t|
    t.string   "user_name"
    t.string   "context"
    t.string   "category"
    t.text     "content"
    t.datetime "created_at",                                               :null => false
    t.datetime "updated_at",                                               :null => false
    t.string   "email",      :limit => 360,                                :null => false
    t.integer  "reply_to",                  :precision => 38, :scale => 0
    t.string   "status",     :limit => 16,                                 :null => false
  end

  create_table "file_lock", :primary_key => "semaphore", :force => true do |t|
  end

  create_table "file_manipulator", :primary_key => "file_manipulator_name", :force => true do |t|
    t.string   "type_name",              :limit => 30,  :null => false
    t.string   "parameter1_text",        :limit => 360, :null => false
    t.string   "audit_update_user_id",   :limit => 15,  :null => false
    t.datetime "audit_update_date_time",                :null => false
    t.string   "parameter2_text",        :limit => 360
    t.string   "parameter3_text",        :limit => 360
    t.string   "parameter4_text",        :limit => 360
  end

  create_table "file_type", :primary_key => "file_type_name", :force => true do |t|
    t.string   "description",            :limit => 60, :null => false
    t.string   "audit_update_user_id",   :limit => 15, :null => false
    t.datetime "audit_update_date_time",               :null => false
  end

  create_table "file_type_manipulator", :id => false, :force => true do |t|
    t.string   "file_type_name",         :limit => 30,                                :null => false
    t.string   "file_manipulator_name",  :limit => 30,                                :null => false
    t.integer  "order_number",           :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "audit_update_user_id",   :limit => 15
    t.datetime "audit_update_date_time"
  end

  add_index "file_type_manipulator", ["file_manipulator_name"], :name => "ftm_fm_fk_i", :tablespace => "indexes"

  create_table "financial_transaction", :id => false, :force => true do |t|
    t.integer  "file_sequence_number",         :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.integer  "file_record_sequence_number",  :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.integer  "invoice_sequence_number",      :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.string   "class_id",                     :limit => 20,                                 :null => false
    t.string   "account_number",               :limit => 20,                                 :null => false
    t.datetime "audit_update_date_time",                                                     :null => false
    t.string   "audit_update_user_id",         :limit => 15,                                 :null => false
    t.integer  "update_number",                :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.integer  "category_id",                  :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.datetime "effective_date_time",                                                        :null => false
    t.datetime "transaction_date",                                                           :null => false
    t.string   "transaction_type_rd",          :limit => 16,                                 :null => false
    t.datetime "partition_date_time",                                                        :null => false
    t.string   "partition_group",              :limit => 30,                                 :null => false
    t.string   "customer_number",              :limit => 20
    t.string   "invoice_id",                   :limit => 20
    t.datetime "invoice_date"
    t.string   "balance_type_rd",              :limit => 16
    t.decimal  "transaction_amount",                          :precision => 18, :scale => 6
    t.string   "transaction_description",      :limit => 600
    t.datetime "from_date"
    t.datetime "to_date"
    t.string   "external_tracking_num_string", :limit => 16
  end

  create_table "fixed_cycle_due_date", :id => false, :force => true do |t|
    t.string   "cycle_name",             :limit => 30,                                :null => false
    t.datetime "due_date_time",                                                       :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
    t.integer  "update_number",          :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  create_table "flexible_attribute", :id => false, :force => true do |t|
    t.string  "class_name",            :limit => 30,                                  :null => false
    t.integer "class_version",         :limit => 10,   :precision => 10, :scale => 0, :null => false
    t.string  "query_id",              :limit => 16,                                  :null => false
    t.string  "query",                 :limit => 4000,                                :null => false
    t.string  "flexible_attribute_1",  :limit => 360,                                 :null => false
    t.string  "flexible_attribute_2",  :limit => 360
    t.string  "flexible_attribute_3",  :limit => 360
    t.string  "flexible_attribute_4",  :limit => 360
    t.string  "flexible_attribute_5",  :limit => 360
    t.string  "flexible_attribute_6",  :limit => 360
    t.string  "flexible_attribute_7",  :limit => 360
    t.string  "flexible_attribute_8",  :limit => 360
    t.string  "flexible_attribute_9",  :limit => 360
    t.string  "flexible_attribute_10", :limit => 360
    t.string  "flexible_attribute_11", :limit => 360
    t.string  "flexible_attribute_12", :limit => 360
    t.string  "flexible_attribute_13", :limit => 360
    t.string  "flexible_attribute_14", :limit => 360
    t.string  "flexible_attribute_15", :limit => 360
    t.string  "flexible_attribute_16", :limit => 360
    t.string  "flexible_attribute_17", :limit => 360
    t.string  "flexible_attribute_18", :limit => 360
    t.string  "flexible_attribute_19", :limit => 360
    t.string  "flexible_attribute_20", :limit => 360
  end

  create_table "format_information", :id => false, :force => true do |t|
    t.integer  "vendor_number",                  :limit => 10, :precision => 10, :scale => 0, :null => false
    t.integer  "version_number",                 :limit => 4,  :precision => 4,  :scale => 0, :null => false
    t.integer  "file_block_size",                :limit => 4,  :precision => 4,  :scale => 0, :null => false
    t.string   "fillers_character_type",         :limit => 2,                                 :null => false
    t.integer  "rec_tag_size_value",             :limit => 4,  :precision => 4,  :scale => 0, :null => false
    t.integer  "rec_tag_size_offset_value",      :limit => 4,  :precision => 4,  :scale => 0, :null => false
    t.integer  "rec_tag_coding_style_value",     :limit => 4,  :precision => 4,  :scale => 0, :null => false
    t.integer  "sub_rec_tag_size_value",         :limit => 4,  :precision => 4,  :scale => 0, :null => false
    t.integer  "sub_rec_tag_size_offset_value",  :limit => 4,  :precision => 4,  :scale => 0, :null => false
    t.integer  "sub_rec_tag_coding_style_value", :limit => 4,  :precision => 4,  :scale => 0, :null => false
    t.string   "audit_update_user_id",           :limit => 15
    t.datetime "audit_update_date_time"
    t.integer  "update_number",                  :limit => 10, :precision => 10, :scale => 0
  end

  create_table "fract_update_calendar_registry", :primary_key => "sequence_number", :force => true do |t|
    t.datetime "system_date",                                                                :null => false
    t.datetime "change_date",                                                                :null => false
    t.datetime "related_object_effective_date",                                              :null => false
    t.string   "fractionalization_ind",         :limit => 1,                                 :null => false
    t.string   "audit_update_user_id",          :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                     :null => false
    t.integer  "update_number",                 :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "rate_plan_code",                :limit => 5
    t.string   "algorithm_id",                  :limit => 16
    t.string   "tariff_model_area_version_id",  :limit => 16
    t.string   "service_group_code",            :limit => 5
    t.string   "tariff_tier_taper_code",        :limit => 5
    t.string   "customer_specific_rate_id",     :limit => 16
  end

  add_index "fract_update_calendar_registry", ["customer_specific_rate_id"], :name => "fucr_ind4", :tablespace => "indexes"
  add_index "fract_update_calendar_registry", ["service_group_code", "related_object_effective_date"], :name => "fucr_ind2", :tablespace => "indexes"
  add_index "fract_update_calendar_registry", ["tariff_model_area_version_id"], :name => "fucr_ind1", :tablespace => "indexes"
  add_index "fract_update_calendar_registry", ["tariff_tier_taper_code", "related_object_effective_date"], :name => "fucr_ind3", :tablespace => "indexes"

  create_table "gateway_condition", :primary_key => "gateway_condition_id", :force => true do |t|
    t.string   "decision_point_id",      :limit => 16,                                  :null => false
    t.string   "gateway_condition_name", :limit => 30,                                  :null => false
    t.string   "descriptive_text",       :limit => 360
    t.integer  "evaluate_order_number",  :limit => 10,   :precision => 10, :scale => 0, :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                  :null => false
    t.datetime "audit_update_date_time",                                                :null => false
    t.integer  "update_number",          :limit => 10,   :precision => 10, :scale => 0, :null => false
    t.string   "gui_expression",         :limit => 2000
  end

  add_index "gateway_condition", ["decision_point_id", "evaluate_order_number"], :name => "gc_uk"

  create_table "gateway_condition_dep_chain", :id => false, :force => true do |t|
    t.string   "gateway_condition_id",   :limit => 16,                                :null => false
    t.string   "business_activity_id",   :limit => 16,                                :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
    t.integer  "update_number",          :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  add_index "gateway_condition_dep_chain", ["business_activity_id"], :name => "gcdc_ind1"

  create_table "gateway_execution_condition", :primary_key => "gateway_execution_condition_id", :force => true do |t|
    t.string   "gateway_condition_id",        :limit => 16,                                  :null => false
    t.string   "gateway_execution_cond_name", :limit => 30,                                  :null => false
    t.string   "descriptive_text",            :limit => 360
    t.string   "expression_string",           :limit => 2000,                                :null => false
    t.string   "audit_update_user_id",        :limit => 15,                                  :null => false
    t.datetime "audit_update_date_time",                                                     :null => false
    t.integer  "update_number",               :limit => 10,   :precision => 10, :scale => 0, :null => false
  end

  add_index "gateway_execution_condition", ["gateway_condition_id"], :name => "gec_ind1"

  create_table "general_code_group", :primary_key => "group_code", :force => true do |t|
    t.string   "description",            :limit => 60,                                :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
    t.integer  "update_number",          :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "modifiable_value",       :limit => 16
    t.string   "ref_data_type_value",    :limit => 16
  end

  create_table "general_code_item", :id => false, :force => true do |t|
    t.string   "group_code",                 :limit => 10,                                :null => false
    t.string   "value",                      :limit => 16,                                :null => false
    t.datetime "effective_date",                                                          :null => false
    t.string   "effective_status",           :limit => 6,                                 :null => false
    t.string   "description",                :limit => 60,                                :null => false
    t.string   "short_description",          :limit => 30,                                :null => false
    t.string   "audit_update_user_id",       :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                  :null => false
    t.integer  "update_number",              :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "modifiable_value",           :limit => 16
    t.string   "ref_data_type_value",        :limit => 16
    t.string   "description_translation_id", :limit => 10
    t.string   "short_description_trans_id", :limit => 10
  end

  add_index "general_code_item", ["description_translation_id"], :name => "gencdeitm_i1", :tablespace => "indexes"
  add_index "general_code_item", ["short_description_trans_id"], :name => "gencdeitm_i2", :tablespace => "indexes"

  create_table "generic_message_statistic", :id => false, :force => true do |t|
    t.string   "process_name",              :limit => 60,                                :null => false
    t.integer  "process_identifier",        :limit => 5,  :precision => 5,  :scale => 0, :null => false
    t.datetime "process_start_time",                                                     :null => false
    t.datetime "process_end_time",                                                       :null => false
    t.string   "adapter_type_name",         :limit => 30,                                :null => false
    t.integer  "messages_processed_number", :limit => 10, :precision => 10, :scale => 0, :null => false
    t.integer  "messages_in_error_number",  :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "process_argument_desc",     :limit => 60
  end

  create_table "geocode", :id => false, :force => true do |t|
    t.string   "npa",                     :limit => 3,                                  :null => false
    t.string   "nxx",                     :limit => 3,                                  :null => false
    t.datetime "effective_date",                                                        :null => false
    t.string   "tax_jurisdiction_state",  :limit => 2,                                  :null => false
    t.string   "tax_jurisdiction_county", :limit => 3,                                  :null => false
    t.string   "tax_jurisdiction_city",   :limit => 4,                                  :null => false
    t.string   "tax_jurisdiction_sub",    :limit => 3,                                  :null => false
    t.string   "audit_update_user_id",    :limit => 15,                                 :null => false
    t.datetime "audit_update_date_time",                                                :null => false
    t.integer  "update_number",           :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.string   "area_description",        :limit => 360
  end

  create_table "gtt_guide_account", :temporary => true, :id => false, :force => true do |t|
    t.string "account_number", :limit => 20, :null => false
  end

  create_table "gtt_guide_subscription", :temporary => true, :id => false, :force => true do |t|
    t.string "service_subscription_id", :limit => 16, :null => false
  end

  create_table "gtt_rcp_interface", :temporary => true, :id => false, :force => true do |t|
    t.string   "service_subscription_id", :limit => 16,                                :null => false
    t.datetime "effective_date",                                                       :null => false
    t.string   "change_type_status",      :limit => 6,                                 :null => false
    t.integer  "work_id",                 :limit => 20, :precision => 20, :scale => 0, :null => false
  end

  create_table "guiding_rule", :id => false, :force => true do |t|
    t.string   "service_subscription_id", :limit => 16,                                :null => false
    t.string   "charge_type_rd",          :limit => 16,                                :null => false
    t.datetime "effective_date",                                                       :null => false
    t.string   "effective_status",        :limit => 6,                                 :null => false
    t.string   "audit_update_user_id",    :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                               :null => false
    t.integer  "update_number",           :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "account_number",          :limit => 20
  end

  add_index "guiding_rule", ["account_number"], :name => "guidrl_acct_i", :tablespace => "indexes"
  add_index "guiding_rule", ["service_subscription_id", "charge_type_rd", "effective_status", "effective_date"], :name => "guidrl_acct_2", :tablespace => "indexes"

  create_table "historical_event", :id => false, :force => true do |t|
    t.string   "action_rd",                     :limit => 16,                                  :null => false
    t.datetime "action_date_time",                                                             :null => false
    t.string   "business_activity_id",          :limit => 16,                                  :null => false
    t.string   "name",                          :limit => 30,                                  :null => false
    t.string   "schedule_constraint_type_rd",   :limit => 16,                                  :null => false
    t.integer  "standard_duration_value",       :limit => 4,    :precision => 4,  :scale => 0, :null => false
    t.string   "standard_duration_unit_rd",     :limit => 16,                                  :null => false
    t.string   "status_rd",                     :limit => 16,                                  :null => false
    t.string   "type_rd",                       :limit => 16,                                  :null => false
    t.string   "user_id",                       :limit => 15,                                  :null => false
    t.string   "audit_update_user_id",          :limit => 15,                                  :null => false
    t.datetime "audit_update_date_time",                                                       :null => false
    t.integer  "update_number",                 :limit => 10,   :precision => 10, :scale => 0, :null => false
    t.datetime "actual_end_date_time"
    t.datetime "actual_start_date_time"
    t.string   "customer_order_id",             :limit => 30
    t.datetime "earliest_start_date_time"
    t.datetime "expected_end_date_time"
    t.string   "internal_order_id_string",      :limit => 50
    t.string   "jeopardy_code_rd",              :limit => 16
    t.datetime "latest_end_date_time"
    t.string   "note_string",                   :limit => 1024
    t.string   "on_hold_indicator",             :limit => 1
    t.string   "priority_rd",                   :limit => 16
    t.datetime "schedule_constraint_date_time"
  end

  create_table "insert_rule", :id => false, :force => true do |t|
    t.string   "insert_rule_name",          :limit => 30,                                :null => false
    t.datetime "effective_date",                                                         :null => false
    t.string   "effective_status",          :limit => 6,                                 :null => false
    t.string   "insert_specification_name", :limit => 30,                                :null => false
    t.string   "condition_name",            :limit => 30,                                :null => false
    t.string   "audit_update_user_id",      :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                 :null => false
    t.integer  "update_number",             :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "description",               :limit => 60
  end

  create_table "insert_specification", :id => false, :force => true do |t|
    t.string   "insert_specification_name", :limit => 30,                                :null => false
    t.datetime "effective_date",                                                         :null => false
    t.string   "effective_status",          :limit => 6,                                 :null => false
    t.string   "slot",                      :limit => 30,                                :null => false
    t.integer  "page_number_value",         :limit => 4,  :precision => 4,  :scale => 0, :null => false
    t.string   "audit_update_user_id",      :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                 :null => false
    t.integer  "update_number",             :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "description",               :limit => 60
    t.integer  "insert_weight_value",       :limit => 10, :precision => 10, :scale => 0
  end

  create_table "international_code", :id => false, :force => true do |t|
    t.string   "translation_group_identifier", :limit => 10,                                :null => false
    t.string   "language_name",                :limit => 30,                                :null => false
    t.datetime "effective_date",                                                            :null => false
    t.string   "effective_status",             :limit => 6,                                 :null => false
    t.integer  "update_number",                :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "description",                  :limit => 60,                                :null => false
    t.datetime "audit_update_date_time",                                                    :null => false
    t.string   "audit_update_user_id",         :limit => 15,                                :null => false
  end

  create_table "invoice_event_charge", :id => false, :force => true do |t|
    t.integer  "production_batch_idnumber", :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "invoice_id",                :limit => 20,                                :null => false
    t.string   "customer_category_rd",      :limit => 16,                                :null => false
    t.string   "event_type_enum_string",    :limit => 32,                                :null => false
    t.decimal  "total_gross_amount",                      :precision => 18, :scale => 6, :null => false
    t.decimal  "total_net_amount",                        :precision => 18, :scale => 6, :null => false
    t.integer  "total_count_volume",        :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "audit_update_user_id",      :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                 :null => false
    t.integer  "duration_volume",           :limit => 10, :precision => 10, :scale => 0
  end

  add_index "invoice_event_charge", ["production_batch_idnumber"], :name => "iec_ind1", :tablespace => "indexes"

  create_table "invoice_tax_charge", :primary_key => "invoice_id", :force => true do |t|
    t.integer  "production_batch_idnumber", :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "customer_category_rd",      :limit => 16,                                :null => false
    t.decimal  "total_tax_charge_amount",                 :precision => 18, :scale => 6, :null => false
    t.string   "audit_update_user_id",      :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                 :null => false
  end

  add_index "invoice_tax_charge", ["production_batch_idnumber"], :name => "itc_ind1", :tablespace => "indexes"

  create_table "ipdr_group_status", :id => false, :force => true do |t|
    t.string   "instance_name",          :limit => 30,                                 :null => false
    t.string   "group_externalid",       :limit => 50,                                 :null => false
    t.boolean  "group_state_number",                    :precision => 1,  :scale => 0, :null => false
    t.integer  "control_file_number",    :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.string   "usage_file_string",      :limit => 512
    t.datetime "audit_update_date_time",                                               :null => false
  end

  create_table "job_definition", :primary_key => "job_name", :force => true do |t|
    t.string "executable_name_string",                   :null => false
    t.string "process_type_rd",          :limit => 16,   :null => false
    t.string "executable_location_path", :limit => 1024, :null => false
    t.string "arguments_string"
    t.string "queue_name_string",        :limit => 30
  end

  create_table "job_relationship", :id => false, :force => true do |t|
    t.string  "from_job_name",     :limit => 30,                               :null => false
    t.string  "to_job_name",       :limit => 30,                               :null => false
    t.integer "input_msg_number",  :limit => 5,  :precision => 5, :scale => 0, :null => false
    t.integer "output_msg_number", :limit => 5,  :precision => 5, :scale => 0, :null => false
  end

  add_index "job_relationship", ["to_job_name"], :name => "jr_idx"

  create_table "last_periodic_completed", :id => false, :force => true do |t|
    t.datetime "last_completed_date", :null => false
  end

  create_table "library_item", :id => false, :force => true do |t|
    t.string   "library_item_name",      :limit => 30,                                :null => false
    t.datetime "effective_date",                                                      :null => false
    t.string   "business_activity_id",   :limit => 16,                                :null => false
    t.string   "effective_status",       :limit => 6,                                 :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
    t.integer  "update_number",          :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "type_rd",                :limit => 16
  end

  add_index "library_item", ["business_activity_id"], :name => "lib_item"

  create_table "location", :id => false, :force => true do |t|
    t.string   "decode_service_number",  :limit => 32,                                 :null => false
    t.datetime "effective_date",                                                       :null => false
    t.string   "description_tgi",        :limit => 10,                                 :null => false
    t.string   "description",            :limit => 60,                                 :null => false
    t.integer  "description_level",      :limit => 2,   :precision => 2,  :scale => 0, :null => false
    t.string   "effective_status",       :limit => 6,                                  :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                 :null => false
    t.datetime "audit_update_date_time",                                               :null => false
    t.integer  "update_number",          :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.string   "property_text",          :limit => 360
  end

  create_table "lock_status", :primary_key => "semaphore", :force => true do |t|
    t.string  "instance_name",            :limit => 30,                                :null => false
    t.integer "leftover_file_size",       :limit => 10, :precision => 10, :scale => 0, :null => false
    t.integer "leftover_sequence_number", :limit => 20, :precision => 20, :scale => 0, :null => false
  end

  create_table "log_message", :id => false, :force => true do |t|
    t.string  "log_message_id",     :limit => 20,                                 :null => false
    t.string  "language_name",      :limit => 30,                                 :null => false
    t.string  "message_text",       :limit => 360,                                :null => false
    t.integer "update_number",      :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.string  "action_description", :limit => 60
    t.string  "severity_ind",       :limit => 1
    t.string  "gui_display_ind",    :limit => 1
    t.integer "threshold",          :limit => 10,  :precision => 10, :scale => 0
  end

  create_table "log_message_entry", :primary_key => "error_number_id", :force => true do |t|
    t.string "error_number_identifier",      :limit => 10,   :null => false
    t.string "message_text_string",          :limit => 500,  :null => false
    t.string "severity_indicator",           :limit => 1,    :null => false
    t.string "error_cause_desc_string",      :limit => 1800, :null => false
    t.string "destination_indicator",        :limit => 1,    :null => false
    t.string "platform_string",              :limit => 40,   :null => false
    t.string "application_comp_desc_string", :limit => 600
    t.string "error_resolution_desc_string", :limit => 1200
  end

  create_table "log_message_entry_user", :primary_key => "error_number_id", :force => true do |t|
    t.string "user_message_text",          :limit => 360
    t.string "contact_information_desc",   :limit => 60
    t.string "display_indicator",          :limit => 1
    t.string "severity_user_defined",      :limit => 20
    t.string "user_description",           :limit => 600
    t.string "user_error_resolution_desc", :limit => 600
    t.string "common_syslog_indicator",    :limit => 1
    t.string "monitor_error_ind",          :limit => 1
  end

  create_table "mailing", :id => false, :force => true do |t|
    t.string   "customer_number",               :limit => 20,                                :null => false
    t.string   "mailing_id",                    :limit => 16,                                :null => false
    t.datetime "effective_date",                                                             :null => false
    t.string   "document_type_rd",              :limit => 16,                                :null => false
    t.string   "name",                          :limit => 60,                                :null => false
    t.string   "effective_status",              :limit => 6,                                 :null => false
    t.string   "table_of_contents_indicator",   :limit => 1,                                 :null => false
    t.string   "marketing_information_ind",     :limit => 1,                                 :null => false
    t.string   "primary_document_recipient_id", :limit => 16,                                :null => false
    t.string   "audit_update_user_id",          :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                     :null => false
    t.integer  "update_number",                 :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "printer_destination_rd",        :limit => 16
    t.integer  "verification_counter_value",    :limit => 4,  :precision => 4,  :scale => 0
    t.datetime "verification_start_date"
    t.string   "encryption_key",                :limit => 16
    t.datetime "reprint_date"
  end

  add_index "mailing", ["mailing_id"], :name => "mail_ind1", :tablespace => "indexes"

  create_table "mass_npa_split_update", :id => false, :force => true do |t|
    t.string   "service_subscription_id",      :limit => 16,                                :null => false
    t.string   "npa",                          :limit => 3,                                 :null => false
    t.string   "nxx",                          :limit => 3,                                 :null => false
    t.string   "line_number_string",           :limit => 16,                                :null => false
    t.string   "access_number_id",             :limit => 16,                                :null => false
    t.integer  "access_number_update_number",  :limit => 10, :precision => 10, :scale => 0, :null => false
    t.datetime "csc_effective_date",                                                        :null => false
    t.string   "batch_ind",                    :limit => 1,                                 :null => false
    t.integer  "update_number",                :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "start_range_string",           :limit => 64
    t.string   "end_range_string",             :limit => 64
    t.string   "config_service_char_id",       :limit => 16
    t.integer  "csc_update_number",            :limit => 10, :precision => 10, :scale => 0
    t.string   "service_ticket_position_id",   :limit => 16
    t.integer  "stp_update_number",            :limit => 10, :precision => 10, :scale => 0
    t.datetime "permissive_period_start_date"
    t.string   "update_type_string",           :limit => 16,                                :null => false
    t.string   "process_indicator",            :limit => 1
    t.string   "new_config_service_char_id",   :limit => 16
    t.string   "new_access_number_id",         :limit => 16
  end

  create_table "mass_transaction_history", :id => false, :force => true do |t|
    t.datetime "effective_process_date",                                                :null => false
    t.string   "state_location_id",        :limit => 16,                                :null => false
    t.string   "contract_customer_number", :limit => 20,                                :null => false
    t.string   "account_number",           :limit => 20,                                :null => false
    t.string   "rating_id",                :limit => 16,                                :null => false
    t.string   "cycle_name",               :limit => 30,                                :null => false
    t.string   "change_type_status",       :limit => 6,                                 :null => false
    t.string   "charge_occurrence_type",   :limit => 2,                                 :null => false
    t.integer  "rcp_request_number",       :limit => 20, :precision => 20, :scale => 0, :null => false
    t.string   "tariff_model_entry_id",    :limit => 16,                                :null => false
    t.string   "fractionalization_ind",    :limit => 1
    t.string   "product_code",             :limit => 5
    t.string   "product_version_code",     :limit => 5
    t.string   "pricing_structure_code",   :limit => 5
    t.string   "service_code",             :limit => 5
  end

  add_index "mass_transaction_history", ["effective_process_date", "rcp_request_number", "change_type_status"], :name => "mc_ind1", :tablespace => "indexes"
  add_index "mass_transaction_history", ["product_code", "product_version_code", "pricing_structure_code", "service_code"], :name => "mc_ind3", :tablespace => "indexes"
  add_index "mass_transaction_history", ["rating_id", "effective_process_date", "change_type_status", "contract_customer_number", "rcp_request_number"], :name => "mc_ind2", :tablespace => "indexes"

  create_table "material_resource_list", :id => false, :force => true do |t|
    t.string   "search_id",                :limit => 16,                                :null => false
    t.integer  "record_number",            :limit => 4,  :precision => 4,  :scale => 0, :null => false
    t.string   "material_resource_name",   :limit => 11,                                :null => false
    t.string   "material_resource_number", :limit => 41,                                :null => false
    t.string   "audit_update_user_id",     :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                :null => false
    t.integer  "update_number",            :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "material_resource_unit",   :limit => 10
  end

  create_table "material_resource_request", :id => false, :force => true do |t|
    t.string   "request_type",                 :limit => 2,                                 :null => false
    t.string   "material_resource_request_id", :limit => 16,                                :null => false
    t.string   "business_activity_id",         :limit => 16,                                :null => false
    t.string   "material_name",                :limit => 30,                                :null => false
    t.string   "material_id",                  :limit => 20,                                :null => false
    t.string   "pickup_indicator",             :limit => 1,                                 :null => false
    t.integer  "quantity_required_value",      :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "quantity_unit_string",         :limit => 10,                                :null => false
    t.string   "audit_update_user_id",         :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                    :null => false
    t.integer  "update_number",                :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "status",                       :limit => 6
    t.integer  "quantity_used_value",          :limit => 10, :precision => 10, :scale => 0
    t.datetime "requested_date_time"
    t.datetime "used_date_time"
    t.string   "reservation_number_string",    :limit => 10
    t.string   "customer_order_id",            :limit => 30
    t.string   "resrv_position",               :limit => 5
    t.datetime "required_date"
  end

  add_index "material_resource_request", ["business_activity_id"], :name => "mrr_ba_i", :tablespace => "indexes"

  create_table "measure_unit", :primary_key => "measure_unit_code", :force => true do |t|
    t.string   "measure_unit_profile_code", :limit => 5,                                  :null => false
    t.string   "name",                      :limit => 30,                                 :null => false
    t.string   "abbreviation",              :limit => 30,                                 :null => false
    t.decimal  "conversion",                               :precision => 18, :scale => 6, :null => false
    t.string   "audit_update_user_id",      :limit => 15,                                 :null => false
    t.datetime "audit_update_date_time",                                                  :null => false
    t.integer  "update_number",             :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.string   "descriptive_text",          :limit => 360
  end

  add_index "measure_unit", ["measure_unit_profile_code"], :name => "mu_mup_fk_i", :tablespace => "indexes"

  create_table "measure_unit_profile", :primary_key => "measure_unit_profile_code", :force => true do |t|
    t.string   "name",                   :limit => 30,                                 :null => false
    t.string   "data_type_value",        :limit => 16,                                 :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                 :null => false
    t.datetime "audit_update_date_time",                                               :null => false
    t.integer  "update_number",          :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.string   "volume_ind",             :limit => 1,                                  :null => false
    t.string   "descriptive_text",       :limit => 360
  end

# Could not dump table "message_response" because of following StandardError
#   Unknown type 'XMLTYPE' for column 'response_xml'

# Could not dump table "message_type_definition" because of following StandardError
#   Unknown type 'XMLTYPE' for column 'message_type_xml'

  create_table "mlog$_config_service_chara", :id => false, :force => true do |t|
    t.string   "service_subscription_id",     :limit => 16
    t.string   "service_characteristic_code", :limit => 5
    t.datetime "effective_date"
    t.string   "config_service_char_id",      :limit => 16
    t.datetime "snaptime$$"
    t.string   "dmltype$$",                   :limit => 1
    t.string   "old_new$$",                   :limit => 1
    t.raw      "change_vector$$",             :limit => 255
  end

  create_table "mlog$_configured_value", :id => false, :force => true do |t|
    t.string   "configured_value_id", :limit => 16
    t.string   "m_row$$"
    t.datetime "snaptime$$"
    t.string   "dmltype$$",           :limit => 1
    t.string   "old_new$$",           :limit => 1
    t.raw      "change_vector$$",     :limit => 255
  end

  create_table "mlog$_tapestry_statistic", :id => false, :force => true do |t|
    t.string   "statistic_id",    :limit => 16
    t.string   "m_row$$"
    t.datetime "snaptime$$"
    t.string   "dmltype$$",       :limit => 1
    t.string   "old_new$$",       :limit => 1
    t.raw      "change_vector$$", :limit => 255
  end

  create_table "mlog$_tapestry_statistic_d", :id => false, :force => true do |t|
    t.string   "detail_id",       :limit => 16
    t.string   "statistic_id",    :limit => 16
    t.string   "m_row$$"
    t.datetime "snaptime$$"
    t.string   "dmltype$$",       :limit => 1
    t.string   "old_new$$",       :limit => 1
    t.raw      "change_vector$$", :limit => 255
  end

  create_table "mlog$_tapestry_statistic_f", :id => false, :force => true do |t|
    t.string   "statistic_file_id", :limit => 16
    t.string   "statistic_id",      :limit => 16
    t.string   "m_row$$"
    t.datetime "snaptime$$"
    t.string   "dmltype$$",         :limit => 1
    t.string   "old_new$$",         :limit => 1
    t.raw      "change_vector$$",   :limit => 255
  end

  create_table "multi_period_ssm_event", :id => false, :force => true do |t|
    t.string   "account_number",               :limit => 20,                                :null => false
    t.integer  "sequence_number",              :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "price_plan_subscription_id",   :limit => 16,                                :null => false
    t.string   "price_plan_code",              :limit => 5,                                 :null => false
    t.datetime "price_plan_effective_date",                                                 :null => false
    t.string   "algorithm_id",                 :limit => 16,                                :null => false
    t.integer  "process_step_order",           :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "partition_group",              :limit => 30,                                :null => false
    t.datetime "partition_date_time",                                                       :null => false
    t.string   "recurring_indicator",          :limit => 1,                                 :null => false
    t.integer  "prev_multi_period_seq_number", :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  create_table "multi_slot_activity", :primary_key => "business_activity_id", :force => true do |t|
    t.string   "root_business_activity_id", :limit => 16,                                :null => false
    t.string   "regional_location_name",    :limit => 30,                                :null => false
    t.string   "role_name",                 :limit => 30,                                :null => false
    t.datetime "earliest_start_date_time",                                               :null => false
    t.datetime "latest_end_date_time",                                                   :null => false
    t.string   "audit_update_user_id",      :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                 :null => false
    t.integer  "update_number",             :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  add_index "multi_slot_activity", ["regional_location_name", "role_name"], :name => "msa_idx"
  add_index "multi_slot_activity", ["root_business_activity_id"], :name => "msa_rba_ind"

  create_table "network_element_definition", :id => false, :force => true do |t|
    t.string   "ne_identifier",                  :limit => 10,                                 :null => false
    t.datetime "effective_date",                                                               :null => false
    t.string   "effective_status",               :limit => 6,                                  :null => false
    t.string   "row_status",                     :limit => 6,                                  :null => false
    t.integer  "vendor_number",                  :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.integer  "version_number",                 :limit => 4,   :precision => 4,  :scale => 0, :null => false
    t.string   "enable_intergap_indicator",      :limit => 1,                                  :null => false
    t.decimal  "percent_max_errors",                            :precision => 5,  :scale => 2, :null => false
    t.integer  "intergap_waiting_time",          :limit => 4,   :precision => 4,  :scale => 0, :null => false
    t.integer  "max_intragap_time",              :limit => 4,   :precision => 4,  :scale => 0, :null => false
    t.integer  "max_intergap_time",              :limit => 4,   :precision => 4,  :scale => 0, :null => false
    t.string   "country_code",                   :limit => 5,                                  :null => false
    t.integer  "assembly_gap",                   :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.integer  "history_length",                 :limit => 4,   :precision => 4,  :scale => 0, :null => false
    t.string   "enable_intragap_indicator",      :limit => 1,                                  :null => false
    t.string   "enable_interpolation_indicator", :limit => 1,                                  :null => false
    t.string   "decompress_indicator",           :limit => 1,                                  :null => false
    t.string   "decrypt_indicator",              :limit => 1,                                  :null => false
    t.integer  "max_retries_value",              :limit => 4,   :precision => 4,  :scale => 0, :null => false
    t.string   "move_indicator",                 :limit => 1,                                  :null => false
    t.string   "remote_file_name",               :limit => 200,                                :null => false
    t.string   "remote_responder_text",          :limit => 360,                                :null => false
    t.integer  "retry_interval_seconds",         :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.integer  "sleep_time_seconds",             :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.integer  "workday_peak_start_seconds",     :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.integer  "workday_peak_end_seconds",       :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.integer  "workday_gap_peak_seconds",       :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.integer  "workday_gap_offpeak_seconds",    :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.integer  "weekend_gap_offpeak_seconds",    :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.integer  "weekend_peak_start_seconds",     :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.integer  "weekend_gap_peak_seconds",       :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.integer  "weekend_peak_end_seconds",       :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.string   "s12_rename_flag",                :limit => 1,                                  :null => false
    t.string   "concatenate_indicator",          :limit => 1,                                  :null => false
    t.string   "dup_check_indicator",            :limit => 1,                                  :null => false
    t.string   "dup_filecheck_indicator",        :limit => 1,                                  :null => false
    t.string   "dup_enable_age_check",           :limit => 1,                                  :null => false
    t.string   "tax_code",                       :limit => 5,                                  :null => false
    t.string   "enable_assemble_indicator",      :limit => 1,                                  :null => false
    t.integer  "force_closure_period_value",     :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.string   "enable_force_closure_indicator", :limit => 1,                                  :null => false
    t.string   "enable_poll_indicator",          :limit => 1,                                  :null => false
    t.string   "ageout_method_ind",              :limit => 1,                                  :null => false
    t.string   "deletion_file_extension_name",   :limit => 30,                                 :null => false
    t.string   "draft_indicator",                :limit => 1,                                  :null => false
    t.integer  "assemble_age_out_period_value",  :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.integer  "max_transfer_retries",           :limit => 4,   :precision => 4,  :scale => 0, :null => false
    t.string   "external_correction_indicator",  :limit => 1,                                  :null => false
    t.string   "audit_update_user_id",           :limit => 15,                                 :null => false
    t.datetime "audit_update_date_time",                                                       :null => false
    t.integer  "update_number",                  :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.string   "description",                    :limit => 60
    t.integer  "max_segment_length",             :limit => 10,  :precision => 10, :scale => 0
    t.integer  "max_interpolation_segments",     :limit => 4,   :precision => 4,  :scale => 0
    t.string   "decrypt_type_name",              :limit => 30
    t.string   "decompress_type_name",           :limit => 30
    t.string   "incoming_currency_code",         :limit => 5
    t.string   "transfer_protocol",              :limit => 30
    t.string   "remote_host_name",               :limit => 30
    t.string   "stream_name",                    :limit => 30
  end

  create_table "network_resource_request", :primary_key => "network_resource_request_id", :force => true do |t|
    t.string   "business_activity_id",       :limit => 16,                                  :null => false
    t.string   "network_resource_name",      :limit => 30,                                  :null => false
    t.integer  "quantity_required_value",    :limit => 10,   :precision => 10, :scale => 0, :null => false
    t.string   "audit_update_user_id",       :limit => 15,                                  :null => false
    t.datetime "audit_update_date_time",                                                    :null => false
    t.integer  "update_number",              :limit => 10,   :precision => 10, :scale => 0, :null => false
    t.string   "description_string",         :limit => 1024
    t.string   "network_id",                 :limit => 20
    t.datetime "required_date_time"
    t.datetime "requested_date_time"
    t.datetime "available_date_time"
    t.string   "confirmation_number_string", :limit => 20
  end

  add_index "network_resource_request", ["business_activity_id"], :name => "nrr_ba_i", :tablespace => "indexes"

  create_table "network_service_request", :primary_key => "business_activity_id", :force => true do |t|
    t.string   "nsr_template_name",      :limit => 30,                                 :null => false
    t.string   "service_code",           :limit => 5,                                  :null => false
    t.string   "format_type_rd",         :limit => 16,                                 :null => false
    t.string   "status",                 :limit => 6,                                  :null => false
    t.string   "priority_rd",            :limit => 16,                                 :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                 :null => false
    t.datetime "audit_update_date_time",                                               :null => false
    t.integer  "update_number",          :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.binary   "command_text_blob"
    t.string   "error_text",             :limit => 360
    t.datetime "sent_date"
  end

  add_index "network_service_request", ["status"], :name => "nsr_ind2", :tablespace => "indexes"

  create_table "notice", :id => false, :force => true do |t|
    t.string   "notice_name",            :limit => 30,                                :null => false
    t.string   "notice_type",            :limit => 2,                                 :null => false
    t.datetime "effective_date",                                                      :null => false
    t.string   "effective_status",       :limit => 6,                                 :null => false
    t.integer  "priority_sequence",      :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "release_status",         :limit => 6,                                 :null => false
    t.string   "category_rd",            :limit => 16,                                :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
    t.integer  "update_number",          :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "marketing_indicator",    :limit => 1
    t.string   "page_break_indicator",   :limit => 1
  end

  create_table "notice_rule", :id => false, :force => true do |t|
    t.string   "notice_rule_name",       :limit => 30,                                :null => false
    t.datetime "effective_date",                                                      :null => false
    t.string   "notice_type",            :limit => 2,                                 :null => false
    t.string   "effective_status",       :limit => 6,                                 :null => false
    t.string   "notice_name",            :limit => 30,                                :null => false
    t.string   "condition_name",         :limit => 30,                                :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
    t.integer  "update_number",          :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "description",            :limit => 60
  end

  create_table "notice_text", :id => false, :force => true do |t|
    t.string   "notice_name",            :limit => 30,                                 :null => false
    t.string   "language_rd",            :limit => 16,                                 :null => false
    t.string   "notice_type",            :limit => 2,                                  :null => false
    t.datetime "notice_eff_date",                                                      :null => false
    t.string   "formatted_text",         :limit => 360,                                :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                 :null => false
    t.datetime "audit_update_date_time",                                               :null => false
    t.integer  "update_number",          :limit => 10,  :precision => 10, :scale => 0, :null => false
  end

  create_table "npa_split_info", :id => false, :force => true do |t|
    t.string   "npa",                    :limit => 3,                                 :null => false
    t.string   "nxx",                    :limit => 3,                                 :null => false
    t.datetime "effective_date",                                                      :null => false
    t.string   "nxx_location_string",    :limit => 10,                                :null => false
    t.string   "new_npa",                :limit => 3,                                 :null => false
    t.datetime "permissive_start_date",                                               :null => false
    t.datetime "permissive_end_date",                                                 :null => false
    t.string   "processed_ind",          :limit => 1,                                 :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
    t.integer  "update_number",          :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "reuse_allowed_ind",      :limit => 1
  end

  create_table "oam_account", :primary_key => "account_id", :force => true do |t|
    t.integer "customer_id", :limit => 16, :precision => 16, :scale => 0, :null => false
  end

  add_index "oam_account", ["customer_id"], :name => "oa_idx1"

# Could not dump table "oam_account_ver" because of following StandardError
#   Unknown type 'XMLTYPE' for column 'account_details'

  create_table "oam_alias_account_mapping", :primary_key => "account_alias_id", :force => true do |t|
    t.integer  "account_id",             :limit => 20, :precision => 20, :scale => 0, :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
  end

  create_table "oam_alias_cust_order_mapping", :primary_key => "customer_order_alias_id", :force => true do |t|
    t.integer  "customer_order_id",      :limit => 20, :precision => 20, :scale => 0, :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
  end

  create_table "oam_alias_customer_mapping", :primary_key => "customer_alias_id", :force => true do |t|
    t.integer  "customer_id",            :limit => 20, :precision => 20, :scale => 0, :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
  end

  create_table "oam_alias_prod_subscr_mapping", :primary_key => "product_subscription_alias_id", :force => true do |t|
    t.integer  "product_subscription_id", :limit => 20, :precision => 20, :scale => 0, :null => false
    t.string   "audit_update_user_id",    :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                               :null => false
  end

  create_table "oam_customer", :primary_key => "customer_id", :force => true do |t|
  end

# Could not dump table "oam_customer_interaction" because of following StandardError
#   Unknown type 'XMLTYPE' for column 'interaction_details'

# Could not dump table "oam_customer_order" because of following StandardError
#   Unknown type 'XMLTYPE' for column 'order_details'

# Could not dump table "oam_customer_ver" because of following StandardError
#   Unknown type 'XMLTYPE' for column 'customer_details'

  create_table "oam_product_subscription", :primary_key => "product_subscription_id", :force => true do |t|
    t.integer "customer_id", :limit => 16, :precision => 16, :scale => 0, :null => false
  end

  add_index "oam_product_subscription", ["customer_id"], :name => "ops_idx1"

# Could not dump table "oam_product_subscription_ver" because of following StandardError
#   Unknown type 'XMLTYPE' for column 'product_details'

  create_table "oam_promotion_subscription", :primary_key => "promotion_subscription_id", :force => true do |t|
    t.integer "service_subscription_id", :limit => 16, :precision => 16, :scale => 0, :null => false
    t.string  "promotion_code",          :limit => 5,                                 :null => false
  end

  add_index "oam_promotion_subscription", ["service_subscription_id"], :name => "opns_idx1"

# Could not dump table "oam_promotion_subscription_ver" because of following StandardError
#   Unknown type 'XMLTYPE' for column 'promotion_details'

  create_table "oam_service_subscription", :primary_key => "service_subscription_id", :force => true do |t|
    t.integer "product_subscription_id", :limit => 16, :precision => 16, :scale => 0, :null => false
    t.string  "service_code",            :limit => 5,                                 :null => false
  end

  add_index "oam_service_subscription", ["product_subscription_id"], :name => "oss_idx1"

# Could not dump table "oam_service_subscription_ver" because of following StandardError
#   Unknown type 'XMLTYPE' for column 'service_characteristics'

  create_table "oam_subscription_contract", :primary_key => "contract_id", :force => true do |t|
    t.string  "contract_code",           :limit => 10,                                :null => false
    t.integer "customer_id",             :limit => 16, :precision => 16, :scale => 0, :null => false
    t.integer "product_subscription_id", :limit => 16, :precision => 16, :scale => 0
    t.integer "service_subscription_id", :limit => 16, :precision => 16, :scale => 0
  end

  add_index "oam_subscription_contract", ["customer_id"], :name => "osc_idx1"
  add_index "oam_subscription_contract", ["product_subscription_id"], :name => "osc_idx2"
  add_index "oam_subscription_contract", ["service_subscription_id"], :name => "osc_idx3"

# Could not dump table "oam_subscription_contract_ver" because of following StandardError
#   Unknown type 'XMLTYPE' for column 'contract_details'

  create_table "on_demand_request", :primary_key => "request_id", :force => true do |t|
    t.datetime "request_date_time",                                                          :null => false
    t.string   "mailing_id",                    :limit => 16,                                :null => false
    t.string   "cycle_name",                    :limit => 30,                                :null => false
    t.string   "print_request_type_rd",         :limit => 16,                                :null => false
    t.string   "supported_object_type_rd",      :limit => 16,                                :null => false
    t.string   "supported_object_id",           :limit => 20,                                :null => false
    t.string   "zero_suppress_indicator",       :limit => 1,                                 :null => false
    t.string   "hierarchy_indicator",           :limit => 1,                                 :null => false
    t.integer  "update_number",                 :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "document_template_name",        :limit => 30
    t.string   "currency_rd",                   :limit => 16
    t.string   "language_rd",                   :limit => 16
    t.string   "output_device_rd",              :limit => 16
    t.datetime "desired_date"
    t.datetime "supported_object_eff_date"
    t.string   "supported_object_second_value", :limit => 30
    t.string   "supported_bill_report_type_rd", :limit => 16
  end

  create_table "oracle_alert_log", :id => false, :force => true do |t|
    t.string "log_text", :limit => 4000
  end

  create_table "order_form", :id => false, :force => true do |t|
    t.string   "contract_number",                :limit => 12,                                :null => false
    t.datetime "effective_date",                                                              :null => false
    t.string   "effective_status",               :limit => 6,                                 :null => false
    t.string   "notice_period_exempt_indicator", :limit => 1,                                 :null => false
    t.string   "state_rd",                       :limit => 16,                                :null => false
    t.string   "currency_rd",                    :limit => 16,                                :null => false
    t.integer  "version_number",                 :limit => 4,  :precision => 4,  :scale => 0, :null => false
    t.string   "language_rd",                    :limit => 16,                                :null => false
    t.string   "loi_indicator",                  :limit => 1,                                 :null => false
    t.string   "on_hold_indicator",              :limit => 1,                                 :null => false
    t.datetime "state_date",                                                                  :null => false
    t.string   "audit_update_user_id",           :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                      :null => false
    t.integer  "update_number",                  :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "board_sign_name",                :limit => 30
    t.datetime "board_sign_date"
    t.string   "primary_cust_sign_name",         :limit => 30
    t.datetime "primary_cust_sign_date"
    t.string   "secondary_cust_sign_name",       :limit => 30
    t.datetime "secondary_cust_sign_date"
    t.integer  "grace_period_dur_value",         :limit => 4,  :precision => 4,  :scale => 0
    t.string   "grace_period_dur_unit_rd",       :limit => 16
    t.integer  "notice_period_dur_value",        :limit => 4,  :precision => 4,  :scale => 0
    t.string   "notice_period_dur_unit_rd",      :limit => 16
    t.datetime "notice_period_start_date"
    t.string   "term_dur_unit_rd",               :limit => 16
    t.integer  "term_dur_value",                 :limit => 4,  :precision => 4,  :scale => 0
    t.integer  "term_extent_dur_value",          :limit => 4,  :precision => 4,  :scale => 0
    t.string   "term_extent_dur_unit_rd",        :limit => 16
    t.datetime "term_start_date"
    t.datetime "min_period_start_date"
    t.datetime "termination_date"
    t.integer  "min_period_dur_value",           :limit => 4,  :precision => 4,  :scale => 0
    t.integer  "sales_org_number_value",         :limit => 10, :precision => 10, :scale => 0
    t.string   "min_period_dur_unit_rd",         :limit => 16
    t.datetime "sales_org_date"
    t.decimal  "monthly_order_entry_amount",                   :precision => 18, :scale => 6
    t.string   "termination_restriction_rd",     :limit => 16
    t.string   "document_template_name",         :limit => 30
    t.string   "assoc_skeleton_contract_number", :limit => 12
  end

  create_table "order_form_product_commit", :id => false, :force => true do |t|
    t.string   "product_commitment_number",      :limit => 12,                                :null => false
    t.datetime "effective_date",                                                              :null => false
    t.string   "contract_number",                :limit => 12,                                :null => false
    t.string   "effective_status",               :limit => 6,                                 :null => false
    t.string   "state_rd",                       :limit => 16,                                :null => false
    t.string   "pricing_structure_code",         :limit => 5,                                 :null => false
    t.string   "product_code",                   :limit => 5,                                 :null => false
    t.string   "product_commitment_number_part", :limit => 12,                                :null => false
    t.string   "product_version_code",           :limit => 5,                                 :null => false
    t.integer  "quantity_value",                 :limit => 4,  :precision => 4,  :scale => 0, :null => false
    t.datetime "state_date",                                                                  :null => false
    t.string   "on_hold_indicator",              :limit => 1,                                 :null => false
    t.string   "audit_update_user_id",           :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                      :null => false
    t.integer  "update_number",                  :limit => 10, :precision => 10, :scale => 0, :null => false
    t.datetime "term_start_date"
    t.string   "transaction_id",                 :limit => 16
    t.datetime "min_period_start_date"
  end

  add_index "order_form_product_commit", ["contract_number"], :name => "cn_ofpc_ind", :tablespace => "indexes"

  create_table "parameter_group", :primary_key => "group_code", :force => true do |t|
    t.string   "description",            :limit => 60,                                :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
    t.integer  "update_number",          :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "modifiable_value",       :limit => 16
    t.string   "ref_data_type_value",    :limit => 16
  end

  create_table "parameter_item", :id => false, :force => true do |t|
    t.string   "item_identifier",            :limit => 10,                                :null => false
    t.string   "group_code",                 :limit => 10,                                :null => false
    t.datetime "effective_date",                                                          :null => false
    t.string   "effective_status",           :limit => 6,                                 :null => false
    t.string   "description",                :limit => 60,                                :null => false
    t.string   "audit_update_user_id",       :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                  :null => false
    t.integer  "update_number",              :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "modifiable_value",           :limit => 16
    t.string   "ref_data_type_value",        :limit => 16
    t.string   "value",                      :limit => 60
    t.string   "value_translation_id",       :limit => 10
    t.string   "description_translation_id", :limit => 10
  end

  create_table "parent_validation_field", :id => false, :force => true do |t|
    t.integer  "parent_class_id",        :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "parent_group_id",        :limit => 16,                                :null => false
    t.string   "parent_field_name",      :limit => 30,                                :null => false
    t.string   "field_value_string",     :limit => 60,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.integer  "update_number",          :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  create_table "periodic_generation_schedule", :primary_key => "service_subscription_id", :force => true do |t|
    t.datetime "next_scheduled_date", :null => false
  end

  add_index "periodic_generation_schedule", ["next_scheduled_date", "service_subscription_id"], :name => "pgs_uk", :unique => true, :tablespace => "indexes"

  create_table "plan_selection_rule", :primary_key => "selection_rule_id", :force => true do |t|
    t.string   "plan_selection_rule_set_id", :limit => 16,                                :null => false
    t.string   "target_type",                :limit => 2,                                 :null => false
    t.string   "audit_update_user_id",       :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                  :null => false
    t.integer  "update_number",              :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "condition_id",               :limit => 16
    t.string   "price_plan_code",            :limit => 5
    t.string   "true_rule_id",               :limit => 16
    t.string   "false_rule_id",              :limit => 16
  end

  add_index "plan_selection_rule", ["condition_id"], :name => "psr_src_fk_i", :tablespace => "indexes"
  add_index "plan_selection_rule", ["plan_selection_rule_set_id"], :name => "psr_psrs_fk_i", :tablespace => "indexes"

  create_table "plan_selection_rule_set", :primary_key => "plan_selection_rule_set_id", :force => true do |t|
    t.datetime "effective_date",                                                           :null => false
    t.string   "effective_status",            :limit => 6,                                 :null => false
    t.string   "comment_id",                  :limit => 16,                                :null => false
    t.string   "test_mode_ind",               :limit => 1,                                 :null => false
    t.string   "audit_update_user_id",        :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                   :null => false
    t.integer  "update_number",               :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "plan_selection_root_rule_id", :limit => 16
    t.string   "change_group_id",             :limit => 30
  end

  add_index "plan_selection_rule_set", ["change_group_id"], :name => "psrs_idx"
  add_index "plan_selection_rule_set", ["plan_selection_root_rule_id"], :name => "psrs_psr1_fk_i", :tablespace => "indexes"

  create_table "pool_assignment", :id => false, :force => true do |t|
    t.string   "employee_number",        :limit => 30,                                :null => false
    t.string   "regional_location_name", :limit => 30,                                :null => false
    t.string   "role_name",              :limit => 30,                                :null => false
    t.string   "pool_assign_type_rd",    :limit => 16,                                :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
    t.integer  "update_number",          :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  add_index "pool_assignment", ["regional_location_name"], :name => "pa_rl_fk_i", :tablespace => "indexes"
  add_index "pool_assignment", ["role_name"], :name => "pa_rol_fk_i", :tablespace => "indexes"

  create_table "pool_request", :id => false, :force => true do |t|
    t.string   "pool_request_id",        :limit => 16,                                :null => false
    t.string   "business_activity_id",   :limit => 16,                                :null => false
    t.string   "role_name",              :limit => 30,                                :null => false
    t.string   "status",                 :limit => 6,                                 :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
    t.integer  "update_number",          :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "regional_location_name", :limit => 30
  end

  add_index "pool_request", ["business_activity_id"], :name => "pr_activity_fk_i", :tablespace => "indexes"
  add_index "pool_request", ["regional_location_name"], :name => "pr_rl_fk_i", :tablespace => "indexes"
  add_index "pool_request", ["role_name"], :name => "pr_rol_fk_i", :tablespace => "indexes"

  create_table "postal_code", :id => false, :force => true do |t|
    t.string   "postal_code_rd",         :limit => 16,                                :null => false
    t.string   "country_code_rd",        :limit => 16,                                :null => false
    t.string   "regional_location_name", :limit => 30,                                :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
    t.integer  "update_number",          :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  add_index "postal_code", ["regional_location_name"], :name => "poco_rl_fk_i", :tablespace => "indexes"

  create_table "predefined_legal_condition", :id => false, :force => true do |t|
    t.string   "predefined_legal_condition_id", :limit => 16,                                 :null => false
    t.datetime "effective_date",                                                              :null => false
    t.string   "effective_status",              :limit => 6,                                  :null => false
    t.string   "type_indicator",                :limit => 20,                                 :null => false
    t.string   "audit_update_user_id",          :limit => 15,                                 :null => false
    t.datetime "audit_update_date_time",                                                      :null => false
    t.integer  "update_number",                 :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.string   "name",                          :limit => 30
    t.string   "description_text",              :limit => 360
  end

  create_table "price_plan", :primary_key => "price_plan_version_id", :force => true do |t|
    t.string   "price_plan_code",               :limit => 5,                                  :null => false
    t.string   "provider_code",                 :limit => 5,                                  :null => false
    t.string   "name",                          :limit => 30,                                 :null => false
    t.string   "service_independent_indicator", :limit => 1,                                  :null => false
    t.datetime "effective_date",                                                              :null => false
    t.string   "effective_status",              :limit => 6,                                  :null => false
    t.integer  "max_selected_destinations_val", :limit => 4,   :precision => 4,  :scale => 0, :null => false
    t.string   "billing_name_1",                :limit => 30,                                 :null => false
    t.string   "minimum_charge_indicator",      :limit => 1,                                  :null => false
    t.string   "summarize_indicator",           :limit => 1,                                  :null => false
    t.string   "plan_period_indicator",         :limit => 1,                                  :null => false
    t.string   "comment_id",                    :limit => 16,                                 :null => false
    t.string   "contributing_item_indicator",   :limit => 1,                                  :null => false
    t.string   "discontinue_indicator",         :limit => 1,                                  :null => false
    t.string   "separate_late_usage_ind",       :limit => 1,                                  :null => false
    t.string   "period_type_rd",                :limit => 16,                                 :null => false
    t.integer  "period_factor",                 :limit => 3,   :precision => 3,  :scale => 0, :null => false
    t.string   "account_discount_indicator",    :limit => 1,                                  :null => false
    t.string   "global_indicator",              :limit => 1,                                  :null => false
    t.string   "test_mode_ind",                 :limit => 1,                                  :null => false
    t.string   "audit_update_user_id",          :limit => 15,                                 :null => false
    t.datetime "audit_update_date_time",                                                      :null => false
    t.integer  "update_number",                 :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.string   "promotion_ind",                 :limit => 1,                                  :null => false
    t.string   "billing_name_2",                :limit => 30
    t.string   "root_selection_rule_id",        :limit => 16
    t.string   "descriptive_text",              :limit => 360
    t.string   "customer_number",               :limit => 20
    t.datetime "discontinue_date_time"
    t.string   "change_group_id",               :limit => 30
  end

  add_index "price_plan", ["change_group_id"], :name => "ppc_idx"
  add_index "price_plan", ["provider_code"], :name => "pp_prov_fk_i", :tablespace => "indexes"
  add_index "price_plan", ["root_selection_rule_id"], :name => "pp_asr_fk_i", :tablespace => "indexes"

  create_table "price_plan_option", :primary_key => "price_plan_option_id", :force => true do |t|
    t.string   "price_plan_version_id",      :limit => 16,                                :null => false
    t.string   "price_plan_option_value_id", :limit => 16,                                :null => false
    t.string   "option_name",                :limit => 30,                                :null => false
    t.string   "audit_update_user_id",       :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                  :null => false
    t.integer  "update_number",              :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  add_index "price_plan_option", ["price_plan_option_value_id"], :name => "ppo_ppov_fk_i", :tablespace => "indexes"
  add_index "price_plan_option", ["price_plan_version_id"], :name => "ppo_pp_fk_i", :tablespace => "indexes"

  create_table "price_plan_option_value", :primary_key => "price_plan_option_value_id", :force => true do |t|
    t.string   "price_plan_version_id",  :limit => 16,                                :null => false
    t.string   "option_value_name",      :limit => 30,                                :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
    t.integer  "update_number",          :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  add_index "price_plan_option_value", ["price_plan_version_id"], :name => "ppov_pp_fk_i", :tablespace => "indexes"

  create_table "price_plan_service", :id => false, :force => true do |t|
    t.string   "price_plan_version_id",  :limit => 16,                                :null => false
    t.string   "service_code",           :limit => 5,                                 :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
    t.integer  "update_number",          :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  create_table "price_plan_subscription", :id => false, :force => true do |t|
    t.string   "price_plan_subscription_id",  :limit => 16,                                :null => false
    t.datetime "effective_date",                                                           :null => false
    t.string   "product_subscription_id",     :limit => 16,                                :null => false
    t.string   "effective_status",            :limit => 6,                                 :null => false
    t.string   "price_plan_code",             :limit => 5,                                 :null => false
    t.string   "contributing_item_indicator", :limit => 1,                                 :null => false
    t.string   "summary_indicator",           :limit => 1,                                 :null => false
    t.string   "active_price_plan_indicator", :limit => 1,                                 :null => false
    t.string   "account_discount_indicator",  :limit => 1,                                 :null => false
    t.string   "audit_update_user_id",        :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                   :null => false
    t.integer  "update_number",               :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "transaction_id",              :limit => 16
    t.string   "account_number",              :limit => 20
    t.string   "option_value_name",           :limit => 30
    t.string   "promotion_name",              :limit => 60
    t.string   "promotion_subscription_id",   :limit => 16
  end

  add_index "price_plan_subscription", ["account_number"], :name => "ppsub_acct_ind", :tablespace => "indexes"
  add_index "price_plan_subscription", ["product_subscription_id"], :name => "psub_ppsub_ind", :tablespace => "indexes"

  create_table "priceable_char_template", :primary_key => "template_idnumber", :force => true do |t|
    t.string   "name",                         :limit => 30,                                 :null => false
    t.string   "rtti_path",                    :limit => 360,                                :null => false
    t.string   "flexible_attribute_ind",       :limit => 1,                                  :null => false
    t.string   "characteristic_type_value_rd", :limit => 16,                                 :null => false
    t.string   "data_type_group_rd",           :limit => 16,                                 :null => false
    t.string   "default_data_type_value_rd",   :limit => 16,                                 :null => false
    t.string   "volume_ind",                   :limit => 1,                                  :null => false
    t.string   "audit_update_user_id",         :limit => 15,                                 :null => false
    t.datetime "audit_update_date_time",                                                     :null => false
    t.integer  "update_number",                :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.string   "descriptive_text",             :limit => 360
  end

  create_table "priceable_char_value", :primary_key => "priceable_char_value_id", :force => true do |t|
    t.string   "priceable_characteristic_id", :limit => 16,                                :null => false
    t.string   "short_description",           :limit => 30,                                :null => false
    t.string   "audit_update_user_id",        :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                   :null => false
    t.integer  "update_number",               :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "description",                 :limit => 60
    t.string   "d_value",                     :limit => 30
    t.string   "c_minimum_value",             :limit => 30
    t.string   "c_maximum_value",             :limit => 30
    t.string   "measure_unit_code",           :limit => 5
  end

  add_index "priceable_char_value", ["measure_unit_code"], :name => "pvc_idx"
  add_index "priceable_char_value", ["priceable_characteristic_id"], :name => "pc_idx"

  create_table "priceable_characteristic", :primary_key => "priceable_characteristic_id", :force => true do |t|
    t.string   "rtti_path",                    :limit => 360,                                :null => false
    t.string   "name",                         :limit => 30,                                 :null => false
    t.string   "data_type_value_rd",           :limit => 16,                                 :null => false
    t.string   "characteristic_type_value_rd", :limit => 16,                                 :null => false
    t.integer  "cml_syntax_value",             :limit => 4,   :precision => 4,  :scale => 0, :null => false
    t.string   "value_type_ind",               :limit => 1,                                  :null => false
    t.string   "value_location_ind",           :limit => 1,                                  :null => false
    t.string   "operator_group_rd",            :limit => 10,                                 :null => false
    t.string   "audit_update_user_id",         :limit => 15,                                 :null => false
    t.datetime "audit_update_date_time",                                                     :null => false
    t.integer  "update_number",                :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.string   "system_defined_ind",           :limit => 1,                                  :null => false
    t.string   "descriptive_text",             :limit => 360
    t.string   "value_group_rd",               :limit => 10
    t.string   "mup_code",                     :limit => 5
  end

  create_table "pricing_structure", :id => false, :force => true do |t|
    t.string   "pricing_structure_code", :limit => 5,                                  :null => false
    t.string   "product_version_code",   :limit => 5,                                  :null => false
    t.string   "product_code",           :limit => 5,                                  :null => false
    t.string   "name",                   :limit => 60,                                 :null => false
    t.string   "billing_name_1",         :limit => 60,                                 :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                 :null => false
    t.datetime "audit_update_date_time",                                               :null => false
    t.integer  "update_number",          :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.datetime "start_date",                                                           :null => false
    t.string   "test_mode_ind",          :limit => 1,                                  :null => false
    t.string   "billing_name_2",         :limit => 60
    t.string   "responsible_manager",    :limit => 30
    t.string   "descriptive_text",       :limit => 360
    t.string   "customer_number",        :limit => 20
    t.string   "comment_id",             :limit => 16
    t.string   "change_group_id",        :limit => 30
    t.datetime "end_date"
  end

  add_index "pricing_structure", ["product_code", "product_version_code", "name"], :name => "ps2_ind", :tablespace => "indexes"

  create_table "pricing_structure_ect", :id => false, :force => true do |t|
    t.string   "event_creation_template_id", :limit => 16,                                :null => false
    t.string   "pricing_structure_code",     :limit => 5,                                 :null => false
    t.string   "product_version_code",       :limit => 5,                                 :null => false
    t.string   "product_code",               :limit => 5,                                 :null => false
    t.string   "audit_update_user_id",       :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                  :null => false
    t.integer  "update_number",              :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  add_index "pricing_structure_ect", ["event_creation_template_id", "product_code", "product_version_code"], :name => "pse_ind_1", :tablespace => "indexes"
  add_index "pricing_structure_ect", ["pricing_structure_code", "product_version_code", "product_code"], :name => "pse_ind_3", :tablespace => "indexes"
  add_index "pricing_structure_ect", ["product_code", "product_version_code", "pricing_structure_code"], :name => "pse_ind_2", :tablespace => "indexes"

  create_table "pricing_structure_price_plan", :id => false, :force => true do |t|
    t.string   "pricing_structure_code",         :limit => 5,                                  :null => false
    t.string   "product_version_code",           :limit => 5,                                  :null => false
    t.string   "product_code",                   :limit => 5,                                  :null => false
    t.string   "price_plan_code",                :limit => 5,                                  :null => false
    t.string   "audit_update_user_id",           :limit => 15,                                 :null => false
    t.datetime "audit_update_date_time",                                                       :null => false
    t.integer  "update_number",                  :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.string   "price_plan_sub1_rtti_path",      :limit => 360
    t.string   "price_plan_sub2_rtti_path",      :limit => 360
    t.string   "accumulation_account_rtti_path", :limit => 360
    t.string   "option_value_rtti_path",         :limit => 360
  end

  add_index "pricing_structure_price_plan", ["product_code", "product_version_code"], :name => "pspp_ind_1", :tablespace => "indexes"

  create_table "pricing_structure_promotion", :id => false, :force => true do |t|
    t.string   "product_code",           :limit => 5,                                 :null => false
    t.string   "product_version_code",   :limit => 5,                                 :null => false
    t.string   "pricing_structure_code", :limit => 5,                                 :null => false
    t.string   "promotion_code",         :limit => 5,                                 :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
    t.integer  "update_number",          :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  add_index "pricing_structure_promotion", ["promotion_code"], :name => "psp_idx"

  create_table "pricing_structure_qual", :id => false, :force => true do |t|
    t.string   "product_code",             :limit => 5,                                 :null => false
    t.string   "product_version_code",     :limit => 5,                                 :null => false
    t.string   "pricing_structure_code",   :limit => 5,                                 :null => false
    t.string   "qualification_group_code", :limit => 10,                                :null => false
    t.string   "qualification_value",      :limit => 16,                                :null => false
    t.string   "audit_update_user_id",     :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                :null => false
    t.integer  "update_number",            :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  add_index "pricing_structure_qual", ["product_code", "product_version_code", "pricing_structure_code"], :name => "psq_ind_1", :tablespace => "indexes"

  create_table "principal_associate", :id => false, :force => true do |t|
    t.string   "supported_object_id",            :limit => 20,                                :null => false
    t.string   "supported_object_type_rd",       :limit => 16,                                :null => false
    t.string   "primary_object_type_rd",         :limit => 16,                                :null => false
    t.datetime "effective_date",                                                              :null => false
    t.string   "effective_status",               :limit => 6,                                 :null => false
    t.string   "primary_object_id",              :limit => 20,                                :null => false
    t.string   "audit_update_user_id",           :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                      :null => false
    t.integer  "update_number",                  :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "primary_object_key_information", :limit => 20
  end

  create_table "printer", :primary_key => "printer_name", :force => true do |t|
    t.string  "file_format",         :limit => 30,                                :null => false
    t.string  "duplex_capable_ind",  :limit => 1,                                 :null => false
    t.string  "local_indicator",     :limit => 1,                                 :null => false
    t.string  "ip_address",          :limit => 20
    t.string  "control_file_name",   :limit => 30
    t.decimal "paper_weight_number",               :precision => 18, :scale => 6
  end

  create_table "process_msg_status", :id => false, :force => true do |t|
    t.string   "executable_name_string",                                             :null => false
    t.integer  "instance_number",        :limit => 5, :precision => 5,  :scale => 0, :null => false
    t.datetime "msg_date_time",                                                      :null => false
    t.decimal  "cpu_time_number",                     :precision => 12, :scale => 6, :null => false
    t.decimal  "elapsed_time_number",                 :precision => 12, :scale => 6, :null => false
    t.integer  "error_count_number",     :limit => 5, :precision => 5,  :scale => 0, :null => false
  end

  add_index "process_msg_status", ["executable_name_string", "msg_date_time"], :name => "pms_ind1", :tablespace => "indexes"

  create_table "process_status", :id => false, :force => true do |t|
    t.string   "stream_name",            :limit => 30,                                :null => false
    t.string   "job_name",               :limit => 30,                                :null => false
    t.string   "host_name",              :limit => 30,                                :null => false
    t.integer  "instance_number",        :limit => 5,  :precision => 5,  :scale => 0, :null => false
    t.integer  "pid_number",             :limit => 5,  :precision => 5,  :scale => 0, :null => false
    t.string   "status_rd",              :limit => 16,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
    t.datetime "start_date_time",                                                     :null => false
    t.integer  "resident_size_number",   :limit => 16, :precision => 16, :scale => 0
    t.integer  "virtual_size_number",    :limit => 16, :precision => 16, :scale => 0
    t.decimal  "cpu_percent_number",                   :precision => 12, :scale => 4
    t.datetime "end_date_time"
    t.string   "shutdown_reason_string"
  end

  create_table "process_step", :primary_key => "process_step_id", :force => true do |t|
    t.string   "algorithm_id",               :limit => 16,                                 :null => false
    t.integer  "calculation_id",             :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.string   "rate_effective_indicator",   :limit => 1,                                  :null => false
    t.string   "calculation_type_indicator", :limit => 1,                                  :null => false
    t.integer  "process_step_order",         :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.string   "audit_update_user_id",       :limit => 15,                                 :null => false
    t.datetime "audit_update_date_time",                                                   :null => false
    t.integer  "update_number",              :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.string   "calculate_mileage_ind",      :limit => 1,                                  :null => false
    t.string   "descriptive_text",           :limit => 360
    t.string   "add_replace_indicator",      :limit => 1
    t.string   "tariff_model_area_code",     :limit => 5
    t.string   "summary_group_id",           :limit => 16
  end

  add_index "process_step", ["algorithm_id"], :name => "ps3_alg_fk_i", :tablespace => "indexes"
  add_index "process_step", ["calculation_id"], :name => "ps3_cal_fk_i", :tablespace => "indexes"
  add_index "process_step", ["summary_group_id"], :name => "prs_idx"

  create_table "product", :primary_key => "product_code", :force => true do |t|
    t.string   "provider_code",          :limit => 5,                                 :null => false
    t.string   "name",                   :limit => 60,                                :null => false
    t.string   "classification_value",   :limit => 16,                                :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
    t.integer  "update_number",          :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "comment_id",             :limit => 16
    t.string   "responsible_manager",    :limit => 30
    t.datetime "discontinue_date_time"
    t.string   "discontinue_indicator",  :limit => 1
  end

  add_index "product", ["provider_code"], :name => "pro_prov_fk_i", :tablespace => "indexes"

  create_table "product_service_rule", :id => false, :force => true do |t|
    t.string   "product_code",              :limit => 5,                                 :null => false
    t.string   "product_version_code",      :limit => 5,                                 :null => false
    t.string   "service_code",              :limit => 5,                                 :null => false
    t.string   "associated_indicator",      :limit => 1,                                 :null => false
    t.string   "associated_service_code",   :limit => 5,                                 :null => false
    t.string   "product_subscription_rule", :limit => 1,                                 :null => false
    t.integer  "maximum_quantity",          :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "audit_update_user_id",      :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                 :null => false
    t.integer  "update_number",             :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  add_index "product_service_rule", ["service_code"], :name => "psru_ind1", :tablespace => "indexes"

  create_table "product_skeleton_contract", :id => false, :force => true do |t|
    t.string   "contract_number",        :limit => 12,                                :null => false
    t.datetime "effective_date",                                                      :null => false
    t.string   "pricing_structure_code", :limit => 5,                                 :null => false
    t.string   "product_version_code",   :limit => 5,                                 :null => false
    t.string   "product_code",           :limit => 5,                                 :null => false
    t.string   "effective_status",       :limit => 6,                                 :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
    t.integer  "update_number",          :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  create_table "product_subscription", :id => false, :force => true do |t|
    t.string   "product_subscription_id",      :limit => 16,                                :null => false
    t.datetime "effective_date",                                                            :null => false
    t.string   "effective_status",             :limit => 6,                                 :null => false
    t.string   "customer_number",              :limit => 20,                                :null => false
    t.string   "product_commitment_number",    :limit => 12,                                :null => false
    t.string   "state_rd",                     :limit => 16,                                :null => false
    t.datetime "state_date",                                                                :null => false
    t.string   "price_plan_state_rd",          :limit => 16,                                :null => false
    t.string   "product_change_req_indicator", :limit => 1,                                 :null => false
    t.string   "audit_update_user_id",         :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                    :null => false
    t.integer  "update_number",                :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "product_group_rd",             :limit => 16
  end

  add_index "product_subscription", ["customer_number"], :name => "prosub_cust_fk_i", :tablespace => "indexes"
  add_index "product_subscription", ["product_commitment_number"], :name => "prosub_prcom_fk_i", :tablespace => "indexes"

  create_table "product_subscription_group", :id => false, :force => true do |t|
    t.string   "product_subscription_group_id", :limit => 16,                                :null => false
    t.datetime "effective_date",                                                             :null => false
    t.string   "effective_status",              :limit => 6,                                 :null => false
    t.string   "product_sub_group_name",        :limit => 16,                                :null => false
    t.string   "customer_number",               :limit => 20,                                :null => false
    t.string   "description",                   :limit => 30,                                :null => false
    t.string   "audit_update_user_id",          :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                     :null => false
    t.integer  "update_number",                 :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  add_index "product_subscription_group", ["customer_number", "product_sub_group_name"], :name => "psg_ind1", :tablespace => "indexes"

  create_table "product_version", :id => false, :force => true do |t|
    t.string   "product_version_code",   :limit => 5,                                  :null => false
    t.string   "product_code",           :limit => 5,                                  :null => false
    t.datetime "effective_date",                                                       :null => false
    t.string   "effective_status",       :limit => 6,                                  :null => false
    t.string   "billing_name_1",         :limit => 60,                                 :null => false
    t.datetime "approval_date",                                                        :null => false
    t.string   "test_mode_ind",          :limit => 1,                                  :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                 :null => false
    t.datetime "audit_update_date_time",                                               :null => false
    t.integer  "update_number",          :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.string   "billing_name_2",         :limit => 60
    t.string   "descriptive_text",       :limit => 360
    t.datetime "operational_date"
    t.datetime "planned_release_date"
    t.string   "change_group_id",        :limit => 30
  end

  add_index "product_version", ["change_group_id"], :name => "pcv_idx"
  add_index "product_version", ["product_code"], :name => "prod_ver_prod_fk_i", :tablespace => "indexes"

  create_table "product_version_service", :id => false, :force => true do |t|
    t.string   "product_version_code",      :limit => 5,                                 :null => false
    t.string   "product_code",              :limit => 5,                                 :null => false
    t.string   "service_code",              :limit => 5,                                 :null => false
    t.string   "product_subscription_rule", :limit => 1,                                 :null => false
    t.integer  "maximum_subscriptions",     :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "audit_update_user_id",      :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                 :null => false
    t.integer  "update_number",             :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  add_index "product_version_service", ["service_code"], :name => "pvs_ser_fk_i", :tablespace => "indexes"

  create_table "production_batch", :primary_key => "production_batch_idnumber", :force => true do |t|
    t.integer "production_run_idnumber", :limit => 10,   :precision => 10, :scale => 0, :null => false
    t.string  "state_rd",                :limit => 16,                                  :null => false
    t.integer "invoice_number",          :limit => 10,   :precision => 10, :scale => 0, :null => false
    t.integer "credit_note_number",      :limit => 10,   :precision => 10, :scale => 0, :null => false
    t.string  "distributed_indicator",   :limit => 1,                                   :null => false
    t.integer "document_number",         :limit => 10,   :precision => 10, :scale => 0, :null => false
    t.string  "image_file_path",         :limit => 1024
    t.string  "request_file_path",       :limit => 1024
  end

  add_index "production_batch", ["production_run_idnumber"], :name => "prb_prr_fk_i", :tablespace => "indexes"

  create_table "production_group", :primary_key => "production_group_idnumber", :force => true do |t|
    t.integer "production_run_idnumber", :limit => 10,   :precision => 10, :scale => 0, :null => false
    t.string  "state_rd",                :limit => 16,                                  :null => false
    t.string  "image_file_path",         :limit => 1024
    t.string  "request_file_path",       :limit => 1024
  end

  add_index "production_group", ["production_run_idnumber"], :name => "prg_idx"

  create_table "production_run", :primary_key => "production_run_idnumber", :force => true do |t|
    t.string   "cycle_name",                  :limit => 30,                                :null => false
    t.datetime "cycle_due_date_time",                                                      :null => false
    t.string   "execution_indicator",         :limit => 1,                                 :null => false
    t.string   "state_rd",                    :limit => 16,                                :null => false
    t.datetime "pricing_due_date_time",                                                    :null => false
    t.datetime "run_created_date_time",                                                    :null => false
    t.datetime "cycle_effective_date",                                                     :null => false
    t.string   "bill_verification_indicator", :limit => 1,                                 :null => false
    t.string   "exclude_detail_usage_ind",    :limit => 1,                                 :null => false
    t.integer  "highest_ot_event_seq_number", :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "invoice_cycle_type_ind",      :limit => 1,                                 :null => false
    t.integer  "preformatted_batches_count",  :limit => 10, :precision => 10, :scale => 0, :null => false
    t.datetime "document_maintenance_date"
    t.datetime "distribution_date"
    t.string   "invoice_cycle_name",          :limit => 30
    t.datetime "maintenance_date"
    t.integer  "print_delay",                 :limit => 10, :precision => 10, :scale => 0
    t.datetime "actual_bill_close_date"
  end

  add_index "production_run", ["cycle_name", "cycle_effective_date"], :name => "prod_idx"
  add_index "production_run", ["cycle_name"], :name => "prr_cyc_fk_i", :tablespace => "indexes"

  create_table "promotion", :primary_key => "promotion_code", :force => true do |t|
    t.string   "promotion_name",             :limit => 60,                                 :null => false
    t.string   "promotion_status",           :limit => 16,                                 :null => false
    t.string   "billing_name_1",             :limit => 60,                                 :null => false
    t.datetime "offering_period_start_date",                                               :null => false
    t.datetime "offering_period_end_date",                                                 :null => false
    t.string   "apply_promotion_date_ind",   :limit => 1,                                  :null => false
    t.string   "period_type_ind",            :limit => 1,                                  :null => false
    t.string   "test_mode_ind",              :limit => 1,                                  :null => false
    t.string   "audit_update_user_id",       :limit => 15,                                 :null => false
    t.datetime "audit_update_date_time",                                                   :null => false
    t.integer  "update_number",              :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.string   "discontinue_ind",            :limit => 1,                                  :null => false
    t.string   "billing_name_2",             :limit => 60
    t.string   "descriptive_text",           :limit => 360
    t.string   "apply_promotion_ind",        :limit => 1
    t.datetime "apply_promotion_date"
    t.datetime "first_activation_date"
    t.datetime "rollout_date"
    t.string   "ignore_partial_ind",         :limit => 1
    t.string   "change_group_id",            :limit => 30
    t.integer  "partial_bill_period_days",   :limit => 10,  :precision => 10, :scale => 0
    t.integer  "number_of_periods",          :limit => 4,   :precision => 4,  :scale => 0
  end

  add_index "promotion", ["promotion_name"], :name => "pro_ind1", :unique => true, :tablespace => "indexes"

  create_table "promotion_batch_interface", :primary_key => "promotion_batch_id", :force => true do |t|
    t.string   "promotion_code",         :limit => 5,                                 :null => false
    t.datetime "processing_date",                                                     :null => false
    t.string   "product_code",           :limit => 5,                                 :null => false
    t.string   "product_version_code",   :limit => 5,                                 :null => false
    t.string   "pricing_structure_code", :limit => 5,                                 :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
    t.integer  "update_number",          :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "processed_ind",          :limit => 1,                                 :null => false
  end

  add_index "promotion_batch_interface", ["promotion_code"], :name => "pbi_idx"

  create_table "promotion_qual", :id => false, :force => true do |t|
    t.string   "promotion_code",           :limit => 5,                                 :null => false
    t.string   "qualification_group_code", :limit => 10,                                :null => false
    t.string   "qualification_value",      :limit => 16,                                :null => false
    t.string   "audit_update_user_id",     :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                :null => false
    t.integer  "update_number",            :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  create_table "promotion_subscription", :id => false, :force => true do |t|
    t.string   "promotion_subscription_id",  :limit => 16,                                 :null => false
    t.string   "product_subscription_id",    :limit => 16,                                 :null => false
    t.string   "account_number",             :limit => 20,                                 :null => false
    t.datetime "start_date",                                                               :null => false
    t.datetime "end_date",                                                                 :null => false
    t.string   "promotion_code",             :limit => 5,                                  :null => false
    t.string   "promotion_name",             :limit => 60,                                 :null => false
    t.string   "promotion_description_text", :limit => 360
    t.string   "audit_update_user_id",       :limit => 15,                                 :null => false
    t.datetime "audit_update_date_time",                                                   :null => false
    t.integer  "update_number",              :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.datetime "apply_date",                                                               :null => false
    t.datetime "termination_date",                                                         :null => false
    t.string   "state_rd",                   :limit => 16,                                 :null => false
  end

  add_index "promotion_subscription", ["product_subscription_id"], :name => "ps_ind1", :tablespace => "indexes"

  create_table "promotion_subscription_hist", :id => false, :force => true do |t|
    t.string   "promotion_subscription_id", :limit => 16,                                :null => false
    t.string   "customer_order_id",         :limit => 10,                                :null => false
    t.string   "state_rd",                  :limit => 16
    t.string   "previous_state_rd",         :limit => 16
    t.string   "audit_update_user_id",      :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                 :null => false
    t.integer  "update_number",             :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  create_table "promotion_term", :primary_key => "promotion_term_id", :force => true do |t|
    t.integer  "term_start_period",        :limit => 10, :precision => 10, :scale => 0, :null => false
    t.integer  "term_duration",            :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "audit_update_user_id",     :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                :null => false
    t.integer  "update_number",            :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "price_plan_code",          :limit => 5
    t.string   "service_code",             :limit => 5
    t.string   "usage_mode_rd",            :limit => 16
    t.string   "charge_occurance_type_rd", :limit => 16
    t.string   "rate_plan_code",           :limit => 5
    t.string   "promotion_code",           :limit => 5,                                 :null => false
  end

  add_index "promotion_term", ["promotion_code"], :name => "prt_pc_ind1"

  create_table "property_value", :id => false, :force => true do |t|
    t.string   "service_property_id",        :limit => 16,                                  :null => false
    t.string   "service_order_stp_id",       :limit => 16,                                  :null => false
    t.datetime "service_order_desired_date",                                                :null => false
    t.string   "part_name",                  :limit => 30,                                  :null => false
    t.string   "audit_update_user_id",       :limit => 15,                                  :null => false
    t.datetime "audit_update_date_time",                                                    :null => false
    t.integer  "update_number",              :limit => 10,   :precision => 10, :scale => 0, :null => false
    t.string   "property_value_id",          :limit => 16
    t.string   "value_string",               :limit => 1024
    t.string   "measure_unit_code",          :limit => 5
  end

  add_index "property_value", ["service_order_stp_id"], :name => "pv_ind1", :tablespace => "indexes"

  create_table "provider", :primary_key => "provider_code", :force => true do |t|
    t.string   "name",                   :limit => 30,                                 :null => false
    t.string   "descriptive_text",       :limit => 360,                                :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                 :null => false
    t.datetime "audit_update_date_time",                                               :null => false
    t.integer  "update_number",          :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.string   "information_provided",   :limit => 16
    t.string   "country_code",           :limit => 5
    t.string   "postal_code",            :limit => 10
    t.string   "po_box",                 :limit => 30
    t.string   "city",                   :limit => 30
    t.string   "street_address",         :limit => 60
    t.string   "fax_number",             :limit => 32
    t.string   "telephone_number",       :limit => 32
    t.string   "email_address",          :limit => 129
    t.string   "company_type",           :limit => 16
  end

  create_table "ps_qual_value", :primary_key => "code_rd", :force => true do |t|
    t.string   "description",            :limit => 30,                                :null => false
    t.string   "validate_values_ind",    :limit => 1,                                 :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
    t.integer  "update_number",          :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  create_table "published_version", :id => false, :force => true do |t|
    t.string   "name",                   :limit => 1000
    t.string   "revision_number",        :limit => 15
    t.datetime "audit_update_date_time",                                                :null => false
    t.string   "subversion_url",         :limit => 1000
    t.string   "audit_update_user_id",   :limit => 15
    t.integer  "update_number",          :limit => 10,   :precision => 10, :scale => 0, :null => false
  end

# Could not dump table "query_definition" because of following StandardError
#   Unknown type 'XMLTYPE' for column 'query_xml'

  create_table "queue_message", :primary_key => "message_id", :force => true do |t|
  end

  create_table "rate_cells", :id => false, :force => true do |t|
    t.string "rate_cell_id", :limit => 20, :null => false
    t.string "rate_id",      :limit => 20, :null => false
    t.string "rate_row_id",  :limit => 20, :null => false
    t.string "value",        :limit => 20, :null => false
  end

  create_table "rate_plan_subscription", :primary_key => "rate_plan_subscription_id", :force => true do |t|
    t.string   "promotion_subscription_id", :limit => 16,                                :null => false
    t.string   "service_subscription_id",   :limit => 16,                                :null => false
    t.string   "rate_plan_code",            :limit => 5,                                 :null => false
    t.string   "charge_occurance_type_rd",  :limit => 16,                                :null => false
    t.string   "usage_mode_value",          :limit => 16,                                :null => false
    t.datetime "start_date",                                                             :null => false
    t.datetime "end_date",                                                               :null => false
    t.string   "audit_update_user_id",      :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                 :null => false
    t.integer  "update_number",             :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  add_index "rate_plan_subscription", ["promotion_subscription_id"], :name => "rpss_ind2", :tablespace => "indexes"
  add_index "rate_plan_subscription", ["service_subscription_id"], :name => "rpss_ind1", :tablespace => "indexes"

  create_table "rate_rows", :id => false, :force => true do |t|
    t.string   "rate_row_id",      :limit => 20,                               :null => false
    t.string   "rate_table_id",    :limit => 20,                               :null => false
    t.string   "completer",        :limit => 15
    t.boolean  "delete_allowed",                 :precision => 1, :scale => 0, :null => false
    t.string   "state",            :limit => 16,                               :null => false
    t.boolean  "valid",                          :precision => 1, :scale => 0, :null => false
    t.string   "error_message"
    t.datetime "effective_date",                                               :null => false
    t.string   "effective_status", :limit => 6,                                :null => false
    t.string   "audit_user",       :limit => 15,                               :null => false
    t.string   "billing_name_1",   :limit => 60,                               :null => false
  end

# Could not dump table "rate_table" because of following StandardError
#   Unknown type 'XMLTYPE' for column 'rate_table_xml'

  create_table "rate_table_pricing_structure", :id => false, :force => true do |t|
    t.string   "rate_table_id",          :limit => 16,                                :null => false
    t.string   "product_code",           :limit => 5,                                 :null => false
    t.string   "product_version_code",   :limit => 5,                                 :null => false
    t.string   "pricing_structure_code", :limit => 5,                                 :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
    t.integer  "update_number",          :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  add_index "rate_table_pricing_structure", ["pricing_structure_code", "product_version_code", "product_code"], :name => "rtp_idx"

# Could not dump table "rate_table_structure" because of following StandardError
#   Unknown type 'XMLTYPE' for column 'rate_table_structure_xml'

  create_table "rate_tables", :id => false, :force => true do |t|
    t.string   "rate_table_id",    :limit => 20, :null => false
    t.datetime "effective_date",                 :null => false
    t.string   "effective_status", :limit => 6,  :null => false
    t.string   "template_id",      :limit => 20, :null => false
    t.string   "error_message"
    t.string   "audit_user",       :limit => 15, :null => false
    t.string   "title",            :limit => 50, :null => false
  end

  create_table "rated_general_adjustment_event", :id => false, :force => true do |t|
    t.string   "account_number",                 :limit => 20,                                 :null => false
    t.string   "customer_number",                :limit => 20,                                 :null => false
    t.string   "detail_deletion_indicator",      :limit => 16,                                 :null => false
    t.string   "event_unique_id",                :limit => 30,                                 :null => false
    t.integer  "file_record_sequence_number",    :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.integer  "file_sequence_number",           :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.decimal  "info_charge",                                   :precision => 18, :scale => 6, :null => false
    t.string   "informational_indicator",        :limit => 1,                                  :null => false
    t.integer  "invoice_sequence_number",        :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.integer  "usage_sequence_number",          :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.integer  "invoice_sub_sequence_number",    :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.datetime "last_processing_date_time",                                                    :null => false
    t.integer  "last_processor_enum",            :limit => 3,   :precision => 3,  :scale => 0, :null => false
    t.decimal  "net_billable_charge",                           :precision => 18, :scale => 6, :null => false
    t.datetime "partition_date_time",                                                          :null => false
    t.string   "partition_group",                :limit => 30,                                 :null => false
    t.string   "pricing_structure_code",         :limit => 5,                                  :null => false
    t.string   "product_code",                   :limit => 5,                                  :null => false
    t.string   "rating_tax_code",                :limit => 5,                                  :null => false
    t.integer  "rating_tax_code_version_number", :limit => 4,   :precision => 4,  :scale => 0, :null => false
    t.integer  "recycle_sequence_number",        :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.integer  "rerate_sequence_number",         :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.string   "service_code",                   :limit => 5,                                  :null => false
    t.string   "service_subscription_id",        :limit => 16,                                 :null => false
    t.integer  "xref_version_number",            :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.binary   "data_blob",                                                                    :null => false
    t.string   "release_id",                     :limit => 20
    t.string   "contract_customer_number",       :limit => 20
    t.decimal  "adjustment_amount",                             :precision => 18, :scale => 6
    t.datetime "adjustment_creation_date"
    t.string   "adjustment_description",         :limit => 600
    t.string   "adjustment_id",                  :limit => 16
    t.string   "adjustment_invoice_id",          :limit => 16
    t.string   "adjustment_reason_code_rd",      :limit => 16
    t.decimal  "adjustment_tax_amount",                         :precision => 18, :scale => 6
    t.string   "adjustment_type_kind",           :limit => 3
    t.string   "product_commitment_number",      :limit => 12
    t.integer  "event_version_number",           :limit => 10,  :precision => 10, :scale => 0
    t.string   "generic_string_1",               :limit => 100
    t.string   "generic_string_2",               :limit => 100
    t.string   "generic_string_3",               :limit => 100
    t.string   "generic_string_4",               :limit => 100
    t.string   "generic_string_5",               :limit => 100
    t.string   "generic_string_6",               :limit => 100
    t.string   "generic_string_7",               :limit => 100
    t.string   "generic_string_8",               :limit => 100
    t.string   "generic_string_9",               :limit => 100
    t.string   "generic_string_10",              :limit => 100
    t.string   "generic_string_11",              :limit => 100
    t.string   "generic_string_12",              :limit => 100
    t.string   "generic_string_13",              :limit => 100
    t.string   "generic_string_14",              :limit => 100
    t.string   "generic_string_15",              :limit => 100
    t.string   "generic_string_16",              :limit => 100
    t.string   "generic_string_17",              :limit => 100
    t.string   "generic_string_18",              :limit => 100
    t.string   "generic_string_19",              :limit => 100
    t.string   "generic_string_20",              :limit => 100
    t.string   "generic_string_21",              :limit => 100
    t.string   "generic_string_22",              :limit => 100
    t.string   "generic_string_23",              :limit => 100
    t.string   "generic_string_24",              :limit => 100
    t.string   "generic_string_25",              :limit => 100
    t.string   "generic_string_26",              :limit => 100
    t.string   "generic_string_27",              :limit => 100
    t.string   "generic_string_28",              :limit => 100
    t.string   "generic_string_29",              :limit => 100
    t.string   "generic_string_30",              :limit => 100
    t.string   "generic_string_31",              :limit => 100
    t.string   "generic_string_32",              :limit => 100
    t.string   "generic_string_33",              :limit => 100
    t.string   "generic_string_34",              :limit => 100
    t.string   "generic_string_35",              :limit => 100
    t.string   "generic_string_36",              :limit => 100
    t.string   "generic_string_37",              :limit => 100
    t.string   "generic_string_38",              :limit => 100
    t.string   "generic_string_39",              :limit => 100
    t.string   "generic_string_40",              :limit => 100
    t.string   "generic_string_41",              :limit => 100
    t.string   "generic_string_42",              :limit => 100
    t.string   "generic_string_43",              :limit => 100
    t.string   "generic_string_44",              :limit => 100
    t.string   "generic_string_45",              :limit => 100
    t.string   "generic_string_46",              :limit => 100
    t.string   "generic_string_47",              :limit => 100
    t.string   "generic_string_48",              :limit => 100
    t.string   "generic_string_49",              :limit => 100
    t.string   "generic_string_50",              :limit => 100
    t.string   "generic_string_51",              :limit => 100
    t.string   "generic_string_52",              :limit => 100
    t.string   "generic_string_53",              :limit => 100
    t.string   "generic_string_54",              :limit => 100
    t.string   "generic_string_55",              :limit => 100
    t.string   "generic_string_56",              :limit => 100
    t.string   "generic_string_57",              :limit => 100
    t.string   "generic_string_58",              :limit => 100
    t.string   "generic_string_59",              :limit => 100
    t.string   "generic_string_60",              :limit => 100
    t.string   "generic_string_61",              :limit => 100
    t.string   "generic_string_62",              :limit => 100
    t.string   "generic_string_63",              :limit => 100
    t.string   "generic_string_64",              :limit => 100
    t.string   "generic_string_65",              :limit => 100
    t.string   "generic_string_66",              :limit => 100
    t.string   "generic_string_67",              :limit => 100
    t.string   "generic_string_68",              :limit => 100
    t.string   "generic_string_69",              :limit => 100
    t.string   "generic_string_70",              :limit => 100
    t.string   "generic_string_71",              :limit => 100
    t.string   "generic_string_72",              :limit => 100
    t.string   "generic_string_73",              :limit => 100
    t.string   "generic_string_74",              :limit => 100
    t.string   "generic_string_75",              :limit => 100
    t.string   "generic_string_76",              :limit => 100
    t.string   "generic_string_77",              :limit => 100
    t.string   "generic_string_78",              :limit => 100
    t.string   "generic_string_79",              :limit => 100
    t.string   "generic_string_80",              :limit => 100
    t.string   "generic_string_81",              :limit => 100
    t.string   "generic_string_82",              :limit => 100
    t.string   "generic_string_83",              :limit => 100
    t.string   "generic_string_84",              :limit => 100
    t.string   "generic_string_85",              :limit => 100
    t.string   "generic_string_86",              :limit => 100
    t.string   "generic_string_87",              :limit => 100
    t.string   "generic_string_88",              :limit => 100
    t.string   "generic_string_89",              :limit => 100
    t.string   "generic_string_90",              :limit => 100
    t.string   "generic_string_91",              :limit => 100
    t.string   "generic_string_92",              :limit => 100
    t.string   "generic_string_93",              :limit => 100
    t.string   "generic_string_94",              :limit => 100
    t.string   "generic_string_95",              :limit => 100
    t.string   "generic_string_96",              :limit => 100
    t.string   "generic_string_97",              :limit => 100
    t.string   "generic_string_98",              :limit => 100
    t.string   "generic_string_99",              :limit => 100
    t.string   "generic_string_100",             :limit => 100
    t.decimal  "gross_billable_charge",                         :precision => 18, :scale => 9, :null => false
    t.decimal  "rating_total_tax_charge",                       :precision => 18, :scale => 9, :null => false
    t.decimal  "tax_charge",                                    :precision => 18, :scale => 9, :null => false
  end

  create_table "rated_misc_event", :id => false, :force => true do |t|
    t.string   "account_number",                 :limit => 20,                                  :null => false
    t.integer  "invoice_sequence_number",        :limit => 10,   :precision => 10, :scale => 0, :null => false
    t.integer  "invoice_sub_sequence_number",    :limit => 10,   :precision => 10, :scale => 0, :null => false
    t.string   "partition_group",                :limit => 30,                                  :null => false
    t.datetime "partition_date_time",                                                           :null => false
    t.string   "class_id",                       :limit => 20,                                  :null => false
    t.string   "customer_number",                :limit => 20,                                  :null => false
    t.string   "contract_customer_number",       :limit => 20,                                  :null => false
    t.string   "event_unique_id",                :limit => 30,                                  :null => false
    t.string   "detail_deletion_indicator",      :limit => 16,                                  :null => false
    t.integer  "file_record_sequence_number",    :limit => 10,   :precision => 10, :scale => 0, :null => false
    t.integer  "file_sequence_number",           :limit => 10,   :precision => 10, :scale => 0, :null => false
    t.datetime "last_processing_date_time",                                                     :null => false
    t.integer  "last_processor_enum",            :limit => 3,    :precision => 3,  :scale => 0, :null => false
    t.decimal  "net_billable_charge",                            :precision => 18, :scale => 6, :null => false
    t.string   "product_code",                   :limit => 5,                                   :null => false
    t.string   "rating_tax_code",                :limit => 5,                                   :null => false
    t.integer  "rating_tax_code_version_number", :limit => 4,    :precision => 4,  :scale => 0, :null => false
    t.integer  "recycle_sequence_number",        :limit => 10,   :precision => 10, :scale => 0, :null => false
    t.integer  "rerate_sequence_number",         :limit => 10,   :precision => 10, :scale => 0, :null => false
    t.string   "service_code",                   :limit => 5,                                   :null => false
    t.string   "service_subscription_id",        :limit => 16,                                  :null => false
    t.integer  "service_type_enum",              :limit => 3,    :precision => 3,  :scale => 0, :null => false
    t.datetime "start_date_time",                                                               :null => false
    t.integer  "xref_version_number",            :limit => 10,   :precision => 10, :scale => 0, :null => false
    t.integer  "usage_sequence_number",          :limit => 10,   :precision => 10, :scale => 0, :null => false
    t.string   "pricing_structure_code",         :limit => 5,                                   :null => false
    t.decimal  "info_charge",                                    :precision => 18, :scale => 6, :null => false
    t.string   "informational_indicator",        :limit => 1,                                   :null => false
    t.binary   "data_blob",                                                                     :null => false
    t.string   "release_id",                     :limit => 20
    t.decimal  "adjustment_amount",                              :precision => 18, :scale => 6
    t.decimal  "incoming_charge_amount",                         :precision => 18, :scale => 6
    t.string   "paying_party_number",            :limit => 63
    t.integer  "paying_party_type_enum",         :limit => 3,    :precision => 3,  :scale => 0
    t.string   "product_commitment_number",      :limit => 12
    t.string   "technical_service_code",         :limit => 60
    t.string   "tma_version_id_concat_string",   :limit => 2039
    t.string   "generic_string_1",               :limit => 100
    t.string   "generic_string_2",               :limit => 100
    t.string   "generic_string_3",               :limit => 100
    t.string   "generic_string_4",               :limit => 100
    t.string   "generic_string_5",               :limit => 100
    t.string   "generic_string_6",               :limit => 100
    t.string   "generic_string_7",               :limit => 100
    t.string   "generic_string_8",               :limit => 100
    t.string   "generic_string_9",               :limit => 100
    t.string   "generic_string_10",              :limit => 100
    t.string   "generic_string_11",              :limit => 100
    t.string   "generic_string_12",              :limit => 100
    t.string   "generic_string_13",              :limit => 100
    t.string   "generic_string_14",              :limit => 100
    t.string   "generic_string_15",              :limit => 100
    t.string   "generic_string_16",              :limit => 100
    t.string   "generic_string_17",              :limit => 100
    t.string   "generic_string_18",              :limit => 100
    t.string   "generic_string_19",              :limit => 100
    t.string   "generic_string_20",              :limit => 100
    t.string   "generic_string_21",              :limit => 100
    t.string   "generic_string_22",              :limit => 100
    t.string   "generic_string_23",              :limit => 100
    t.string   "generic_string_24",              :limit => 100
    t.string   "generic_string_25",              :limit => 100
    t.string   "generic_string_26",              :limit => 100
    t.string   "generic_string_27",              :limit => 100
    t.string   "generic_string_28",              :limit => 100
    t.string   "generic_string_29",              :limit => 100
    t.string   "generic_string_30",              :limit => 100
    t.string   "generic_string_31",              :limit => 100
    t.string   "generic_string_32",              :limit => 100
    t.string   "generic_string_33",              :limit => 100
    t.string   "generic_string_34",              :limit => 100
    t.string   "generic_string_35",              :limit => 100
    t.string   "generic_string_36",              :limit => 100
    t.string   "generic_string_37",              :limit => 100
    t.string   "generic_string_38",              :limit => 100
    t.string   "generic_string_39",              :limit => 100
    t.string   "generic_string_40",              :limit => 100
    t.string   "generic_string_41",              :limit => 100
    t.string   "generic_string_42",              :limit => 100
    t.string   "generic_string_43",              :limit => 100
    t.string   "generic_string_44",              :limit => 100
    t.string   "generic_string_45",              :limit => 100
    t.string   "generic_string_46",              :limit => 100
    t.string   "generic_string_47",              :limit => 100
    t.string   "generic_string_48",              :limit => 100
    t.string   "generic_string_49",              :limit => 100
    t.string   "generic_string_50",              :limit => 100
    t.string   "generic_string_51",              :limit => 100
    t.string   "generic_string_52",              :limit => 100
    t.string   "generic_string_53",              :limit => 100
    t.string   "generic_string_54",              :limit => 100
    t.string   "generic_string_55",              :limit => 100
    t.string   "generic_string_56",              :limit => 100
    t.string   "generic_string_57",              :limit => 100
    t.string   "generic_string_58",              :limit => 100
    t.string   "generic_string_59",              :limit => 100
    t.string   "generic_string_60",              :limit => 100
    t.string   "generic_string_61",              :limit => 100
    t.string   "generic_string_62",              :limit => 100
    t.string   "generic_string_63",              :limit => 100
    t.string   "generic_string_64",              :limit => 100
    t.string   "generic_string_65",              :limit => 100
    t.string   "generic_string_66",              :limit => 100
    t.string   "generic_string_67",              :limit => 100
    t.string   "generic_string_68",              :limit => 100
    t.string   "generic_string_69",              :limit => 100
    t.string   "generic_string_70",              :limit => 100
    t.string   "generic_string_71",              :limit => 100
    t.string   "generic_string_72",              :limit => 100
    t.string   "generic_string_73",              :limit => 100
    t.string   "generic_string_74",              :limit => 100
    t.string   "generic_string_75",              :limit => 100
    t.string   "generic_string_76",              :limit => 100
    t.string   "generic_string_77",              :limit => 100
    t.string   "generic_string_78",              :limit => 100
    t.string   "generic_string_79",              :limit => 100
    t.string   "generic_string_80",              :limit => 100
    t.string   "generic_string_81",              :limit => 100
    t.string   "generic_string_82",              :limit => 100
    t.string   "generic_string_83",              :limit => 100
    t.string   "generic_string_84",              :limit => 100
    t.string   "generic_string_85",              :limit => 100
    t.string   "generic_string_86",              :limit => 100
    t.string   "generic_string_87",              :limit => 100
    t.string   "generic_string_88",              :limit => 100
    t.string   "generic_string_89",              :limit => 100
    t.string   "generic_string_90",              :limit => 100
    t.string   "generic_string_91",              :limit => 100
    t.string   "generic_string_92",              :limit => 100
    t.string   "generic_string_93",              :limit => 100
    t.string   "generic_string_94",              :limit => 100
    t.string   "generic_string_95",              :limit => 100
    t.string   "generic_string_96",              :limit => 100
    t.string   "generic_string_97",              :limit => 100
    t.string   "generic_string_98",              :limit => 100
    t.string   "generic_string_99",              :limit => 100
    t.string   "generic_string_100",             :limit => 100
    t.decimal  "gross_billable_charge",                          :precision => 18, :scale => 9, :null => false
    t.decimal  "rating_total_tax_charge",                        :precision => 18, :scale => 9, :null => false
    t.decimal  "tax_charge",                                     :precision => 18, :scale => 9, :null => false
  end

  create_table "rated_one_time_charge_event", :id => false, :force => true do |t|
    t.string   "account_number",                 :limit => 20,                                  :null => false
    t.string   "class_id",                       :limit => 20,                                  :null => false
    t.string   "customer_number",                :limit => 20,                                  :null => false
    t.string   "detail_deletion_indicator",      :limit => 16,                                  :null => false
    t.string   "event_unique_id",                :limit => 30,                                  :null => false
    t.integer  "file_record_sequence_number",    :limit => 10,   :precision => 10, :scale => 0, :null => false
    t.integer  "file_sequence_number",           :limit => 10,   :precision => 10, :scale => 0, :null => false
    t.string   "event_creation_template_id",     :limit => 20,                                  :null => false
    t.decimal  "info_charge",                                    :precision => 18, :scale => 6, :null => false
    t.string   "informational_indicator",        :limit => 1,                                   :null => false
    t.integer  "invoice_sequence_number",        :limit => 10,   :precision => 10, :scale => 0, :null => false
    t.integer  "usage_sequence_number",          :limit => 10,   :precision => 10, :scale => 0, :null => false
    t.integer  "invoice_sub_sequence_number",    :limit => 10,   :precision => 10, :scale => 0, :null => false
    t.datetime "last_processing_date_time",                                                     :null => false
    t.integer  "last_processor_enum",            :limit => 3,    :precision => 3,  :scale => 0, :null => false
    t.decimal  "net_billable_charge",                            :precision => 18, :scale => 6, :null => false
    t.decimal  "otc_amount",                                     :precision => 18, :scale => 6, :null => false
    t.datetime "partition_date_time",                                                           :null => false
    t.string   "partition_group",                :limit => 30,                                  :null => false
    t.string   "pricing_structure_code",         :limit => 5,                                   :null => false
    t.string   "product_code",                   :limit => 5,                                   :null => false
    t.string   "rating_tax_code",                :limit => 5,                                   :null => false
    t.integer  "rating_tax_code_version_number", :limit => 4,    :precision => 4,  :scale => 0, :null => false
    t.integer  "recycle_sequence_number",        :limit => 10,   :precision => 10, :scale => 0, :null => false
    t.integer  "rerate_sequence_number",         :limit => 10,   :precision => 10, :scale => 0, :null => false
    t.string   "service_code",                   :limit => 5,                                   :null => false
    t.string   "service_subscription_id",        :limit => 16,                                  :null => false
    t.integer  "xref_version_number",            :limit => 10,   :precision => 10, :scale => 0, :null => false
    t.string   "state_location_id",              :limit => 16,                                  :null => false
    t.integer  "event_sequence_number",          :limit => 20,   :precision => 20, :scale => 0, :null => false
    t.datetime "start_date_time",                                                               :null => false
    t.datetime "end_date_time",                                                                 :null => false
    t.binary   "data_blob",                                                                     :null => false
    t.string   "release_id",                     :limit => 20
    t.string   "contract_customer_number",       :limit => 20
    t.datetime "rc_monthly_effective_date"
    t.decimal  "adjustment_amount",                              :precision => 18, :scale => 6
    t.integer  "change_type_enum",               :limit => 3,    :precision => 3,  :scale => 0
    t.datetime "charge_creation_date"
    t.integer  "charge_method_enum",             :limit => 3,    :precision => 3,  :scale => 0
    t.integer  "minimum_indicator_enum",         :limit => 3,    :precision => 3,  :scale => 0
    t.integer  "period_factor",                  :limit => 3,    :precision => 3,  :scale => 0
    t.integer  "period_type_enum",               :limit => 3,    :precision => 3,  :scale => 0
    t.string   "tma_version_id_concat_string",   :limit => 2039
    t.string   "product_commitment_number",      :limit => 12
    t.decimal  "prorate_part",                                   :precision => 18, :scale => 6
    t.decimal  "prorated_change_amount",                         :precision => 18, :scale => 6
    t.string   "proration_indicator",            :limit => 1
    t.integer  "recurring_charge_type_enum",     :limit => 3,    :precision => 3,  :scale => 0
    t.datetime "period_start_date"
    t.datetime "period_end_date"
    t.string   "generic_string_1",               :limit => 100
    t.string   "generic_string_2",               :limit => 100
    t.string   "generic_string_3",               :limit => 100
    t.string   "generic_string_4",               :limit => 100
    t.string   "generic_string_5",               :limit => 100
    t.string   "generic_string_6",               :limit => 100
    t.string   "generic_string_7",               :limit => 100
    t.string   "generic_string_8",               :limit => 100
    t.string   "generic_string_9",               :limit => 100
    t.string   "generic_string_10",              :limit => 100
    t.string   "generic_string_11",              :limit => 100
    t.string   "generic_string_12",              :limit => 100
    t.string   "generic_string_13",              :limit => 100
    t.string   "generic_string_14",              :limit => 100
    t.string   "generic_string_15",              :limit => 100
    t.string   "generic_string_16",              :limit => 100
    t.string   "generic_string_17",              :limit => 100
    t.string   "generic_string_18",              :limit => 100
    t.string   "generic_string_19",              :limit => 100
    t.string   "generic_string_20",              :limit => 100
    t.string   "generic_string_21",              :limit => 100
    t.string   "generic_string_22",              :limit => 100
    t.string   "generic_string_23",              :limit => 100
    t.string   "generic_string_24",              :limit => 100
    t.string   "generic_string_25",              :limit => 100
    t.string   "generic_string_26",              :limit => 100
    t.string   "generic_string_27",              :limit => 100
    t.string   "generic_string_28",              :limit => 100
    t.string   "generic_string_29",              :limit => 100
    t.string   "generic_string_30",              :limit => 100
    t.string   "generic_string_31",              :limit => 100
    t.string   "generic_string_32",              :limit => 100
    t.string   "generic_string_33",              :limit => 100
    t.string   "generic_string_34",              :limit => 100
    t.string   "generic_string_35",              :limit => 100
    t.string   "generic_string_36",              :limit => 100
    t.string   "generic_string_37",              :limit => 100
    t.string   "generic_string_38",              :limit => 100
    t.string   "generic_string_39",              :limit => 100
    t.string   "generic_string_40",              :limit => 100
    t.string   "generic_string_41",              :limit => 100
    t.string   "generic_string_42",              :limit => 100
    t.string   "generic_string_43",              :limit => 100
    t.string   "generic_string_44",              :limit => 100
    t.string   "generic_string_45",              :limit => 100
    t.string   "generic_string_46",              :limit => 100
    t.string   "generic_string_47",              :limit => 100
    t.string   "generic_string_48",              :limit => 100
    t.string   "generic_string_49",              :limit => 100
    t.string   "generic_string_50",              :limit => 100
    t.string   "generic_string_51",              :limit => 100
    t.string   "generic_string_52",              :limit => 100
    t.string   "generic_string_53",              :limit => 100
    t.string   "generic_string_54",              :limit => 100
    t.string   "generic_string_55",              :limit => 100
    t.string   "generic_string_56",              :limit => 100
    t.string   "generic_string_57",              :limit => 100
    t.string   "generic_string_58",              :limit => 100
    t.string   "generic_string_59",              :limit => 100
    t.string   "generic_string_60",              :limit => 100
    t.string   "generic_string_61",              :limit => 100
    t.string   "generic_string_62",              :limit => 100
    t.string   "generic_string_63",              :limit => 100
    t.string   "generic_string_64",              :limit => 100
    t.string   "generic_string_65",              :limit => 100
    t.string   "generic_string_66",              :limit => 100
    t.string   "generic_string_67",              :limit => 100
    t.string   "generic_string_68",              :limit => 100
    t.string   "generic_string_69",              :limit => 100
    t.string   "generic_string_70",              :limit => 100
    t.string   "generic_string_71",              :limit => 100
    t.string   "generic_string_72",              :limit => 100
    t.string   "generic_string_73",              :limit => 100
    t.string   "generic_string_74",              :limit => 100
    t.string   "generic_string_75",              :limit => 100
    t.string   "generic_string_76",              :limit => 100
    t.string   "generic_string_77",              :limit => 100
    t.string   "generic_string_78",              :limit => 100
    t.string   "generic_string_79",              :limit => 100
    t.string   "generic_string_80",              :limit => 100
    t.string   "generic_string_81",              :limit => 100
    t.string   "generic_string_82",              :limit => 100
    t.string   "generic_string_83",              :limit => 100
    t.string   "generic_string_84",              :limit => 100
    t.string   "generic_string_85",              :limit => 100
    t.string   "generic_string_86",              :limit => 100
    t.string   "generic_string_87",              :limit => 100
    t.string   "generic_string_88",              :limit => 100
    t.string   "generic_string_89",              :limit => 100
    t.string   "generic_string_90",              :limit => 100
    t.string   "generic_string_91",              :limit => 100
    t.string   "generic_string_92",              :limit => 100
    t.string   "generic_string_93",              :limit => 100
    t.string   "generic_string_94",              :limit => 100
    t.string   "generic_string_95",              :limit => 100
    t.string   "generic_string_96",              :limit => 100
    t.string   "generic_string_97",              :limit => 100
    t.string   "generic_string_98",              :limit => 100
    t.string   "generic_string_99",              :limit => 100
    t.string   "generic_string_100",             :limit => 100
    t.decimal  "gross_billable_charge",                          :precision => 18, :scale => 9, :null => false
    t.decimal  "rating_total_tax_charge",                        :precision => 18, :scale => 9, :null => false
    t.decimal  "tax_charge",                                     :precision => 18, :scale => 9, :null => false
  end

  create_table "rated_summary_event", :id => false, :force => true do |t|
    t.string   "account_number",              :limit => 20,                                 :null => false
    t.decimal  "accumulated_charge",                         :precision => 18, :scale => 6, :null => false
    t.decimal  "accumulated_quantity",                       :precision => 18, :scale => 6, :null => false
    t.string   "class_id",                    :limit => 20,                                 :null => false
    t.string   "customer_number",             :limit => 20,                                 :null => false
    t.string   "detail_deletion_indicator",   :limit => 16,                                 :null => false
    t.string   "event_unique_id",             :limit => 30,                                 :null => false
    t.integer  "file_record_sequence_number", :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.integer  "file_sequence_number",        :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.decimal  "info_charge",                                :precision => 18, :scale => 6, :null => false
    t.string   "informational_indicator",     :limit => 1,                                  :null => false
    t.integer  "invoice_sequence_number",     :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.integer  "usage_sequence_number",       :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.integer  "invoice_sub_sequence_number", :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.datetime "last_processing_date_time",                                                 :null => false
    t.integer  "last_processor_enum",         :limit => 3,   :precision => 3,  :scale => 0, :null => false
    t.decimal  "net_billable_charge",                        :precision => 18, :scale => 6, :null => false
    t.datetime "partition_date_time",                                                       :null => false
    t.string   "partition_group",             :limit => 30,                                 :null => false
    t.string   "pricing_structure_code",      :limit => 5,                                  :null => false
    t.string   "product_code",                :limit => 5,                                  :null => false
    t.string   "service_code",                :limit => 5,                                  :null => false
    t.string   "service_subscription_id",     :limit => 16,                                 :null => false
    t.integer  "xref_version_number",         :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.integer  "rerate_sequence_number",      :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.binary   "data_blob",                                                                 :null => false
    t.string   "release_id",                  :limit => 20
    t.integer  "current_event_counter",       :limit => 10,  :precision => 10, :scale => 0
    t.decimal  "final_charge",                               :precision => 18, :scale => 6
    t.decimal  "initial_charge",                             :precision => 18, :scale => 6
    t.string   "product_commitment_number",   :limit => 12
    t.string   "contract_customer_number",    :limit => 20
    t.integer  "total_event_counter",         :limit => 10,  :precision => 10, :scale => 0
    t.string   "generic_string_1",            :limit => 100
    t.string   "generic_string_2",            :limit => 100
    t.string   "generic_string_3",            :limit => 100
    t.string   "generic_string_4",            :limit => 100
    t.string   "generic_string_5",            :limit => 100
    t.string   "generic_string_6",            :limit => 100
    t.string   "generic_string_7",            :limit => 100
    t.string   "generic_string_8",            :limit => 100
    t.string   "generic_string_9",            :limit => 100
    t.string   "generic_string_10",           :limit => 100
    t.string   "generic_string_11",           :limit => 100
    t.string   "generic_string_12",           :limit => 100
    t.string   "generic_string_13",           :limit => 100
    t.string   "generic_string_14",           :limit => 100
    t.string   "generic_string_15",           :limit => 100
    t.string   "generic_string_16",           :limit => 100
    t.string   "generic_string_17",           :limit => 100
    t.string   "generic_string_18",           :limit => 100
    t.string   "generic_string_19",           :limit => 100
    t.string   "generic_string_20",           :limit => 100
    t.string   "generic_string_21",           :limit => 100
    t.string   "generic_string_22",           :limit => 100
    t.string   "generic_string_23",           :limit => 100
    t.string   "generic_string_24",           :limit => 100
    t.string   "generic_string_25",           :limit => 100
    t.string   "generic_string_26",           :limit => 100
    t.string   "generic_string_27",           :limit => 100
    t.string   "generic_string_28",           :limit => 100
    t.string   "generic_string_29",           :limit => 100
    t.string   "generic_string_30",           :limit => 100
    t.string   "generic_string_31",           :limit => 100
    t.string   "generic_string_32",           :limit => 100
    t.string   "generic_string_33",           :limit => 100
    t.string   "generic_string_34",           :limit => 100
    t.string   "generic_string_35",           :limit => 100
    t.string   "generic_string_36",           :limit => 100
    t.string   "generic_string_37",           :limit => 100
    t.string   "generic_string_38",           :limit => 100
    t.string   "generic_string_39",           :limit => 100
    t.string   "generic_string_40",           :limit => 100
    t.string   "generic_string_41",           :limit => 100
    t.string   "generic_string_42",           :limit => 100
    t.string   "generic_string_43",           :limit => 100
    t.string   "generic_string_44",           :limit => 100
    t.string   "generic_string_45",           :limit => 100
    t.string   "generic_string_46",           :limit => 100
    t.string   "generic_string_47",           :limit => 100
    t.string   "generic_string_48",           :limit => 100
    t.string   "generic_string_49",           :limit => 100
    t.string   "generic_string_50",           :limit => 100
    t.string   "generic_string_51",           :limit => 100
    t.string   "generic_string_52",           :limit => 100
    t.string   "generic_string_53",           :limit => 100
    t.string   "generic_string_54",           :limit => 100
    t.string   "generic_string_55",           :limit => 100
    t.string   "generic_string_56",           :limit => 100
    t.string   "generic_string_57",           :limit => 100
    t.string   "generic_string_58",           :limit => 100
    t.string   "generic_string_59",           :limit => 100
    t.string   "generic_string_60",           :limit => 100
    t.string   "generic_string_61",           :limit => 100
    t.string   "generic_string_62",           :limit => 100
    t.string   "generic_string_63",           :limit => 100
    t.string   "generic_string_64",           :limit => 100
    t.string   "generic_string_65",           :limit => 100
    t.string   "generic_string_66",           :limit => 100
    t.string   "generic_string_67",           :limit => 100
    t.string   "generic_string_68",           :limit => 100
    t.string   "generic_string_69",           :limit => 100
    t.string   "generic_string_70",           :limit => 100
    t.string   "generic_string_71",           :limit => 100
    t.string   "generic_string_72",           :limit => 100
    t.string   "generic_string_73",           :limit => 100
    t.string   "generic_string_74",           :limit => 100
    t.string   "generic_string_75",           :limit => 100
    t.string   "generic_string_76",           :limit => 100
    t.string   "generic_string_77",           :limit => 100
    t.string   "generic_string_78",           :limit => 100
    t.string   "generic_string_79",           :limit => 100
    t.string   "generic_string_80",           :limit => 100
    t.string   "generic_string_81",           :limit => 100
    t.string   "generic_string_82",           :limit => 100
    t.string   "generic_string_83",           :limit => 100
    t.string   "generic_string_84",           :limit => 100
    t.string   "generic_string_85",           :limit => 100
    t.string   "generic_string_86",           :limit => 100
    t.string   "generic_string_87",           :limit => 100
    t.string   "generic_string_88",           :limit => 100
    t.string   "generic_string_89",           :limit => 100
    t.string   "generic_string_90",           :limit => 100
    t.string   "generic_string_91",           :limit => 100
    t.string   "generic_string_92",           :limit => 100
    t.string   "generic_string_93",           :limit => 100
    t.string   "generic_string_94",           :limit => 100
    t.string   "generic_string_95",           :limit => 100
    t.string   "generic_string_96",           :limit => 100
    t.string   "generic_string_97",           :limit => 100
    t.string   "generic_string_98",           :limit => 100
    t.string   "generic_string_99",           :limit => 100
    t.string   "generic_string_100",          :limit => 100
    t.decimal  "gross_billable_charge",                      :precision => 18, :scale => 9, :null => false
    t.decimal  "tax_charge",                                 :precision => 18, :scale => 9, :null => false
  end

  create_table "rated_usage_event", :id => false, :force => true do |t|
    t.string   "account_number",                 :limit => 20,                                  :null => false
    t.integer  "invoice_sequence_number",        :limit => 10,   :precision => 10, :scale => 0, :null => false
    t.integer  "invoice_sub_sequence_number",    :limit => 10,   :precision => 10, :scale => 0, :null => false
    t.string   "partition_group",                :limit => 30,                                  :null => false
    t.datetime "partition_date_time",                                                           :null => false
    t.string   "class_id",                       :limit => 20,                                  :null => false
    t.string   "customer_number",                :limit => 20,                                  :null => false
    t.string   "contract_customer_number",       :limit => 20,                                  :null => false
    t.string   "event_unique_id",                :limit => 30,                                  :null => false
    t.string   "detail_deletion_indicator",      :limit => 16,                                  :null => false
    t.integer  "file_record_sequence_number",    :limit => 10,   :precision => 10, :scale => 0, :null => false
    t.integer  "file_sequence_number",           :limit => 10,   :precision => 10, :scale => 0, :null => false
    t.integer  "forced_closed_enum",             :limit => 3,    :precision => 3,  :scale => 0, :null => false
    t.decimal  "info_charge",                                    :precision => 18, :scale => 6, :null => false
    t.string   "informational_indicator",        :limit => 1,                                   :null => false
    t.datetime "last_processing_date_time",                                                     :null => false
    t.integer  "last_processor_enum",            :limit => 3,    :precision => 3,  :scale => 0, :null => false
    t.integer  "nei_vendor_number",              :limit => 10,   :precision => 10, :scale => 0, :null => false
    t.integer  "nei_version_number",             :limit => 4,    :precision => 4,  :scale => 0, :null => false
    t.decimal  "net_billable_charge",                            :precision => 18, :scale => 6, :null => false
    t.integer  "partial_sequence_number",        :limit => 10,   :precision => 10, :scale => 0, :null => false
    t.string   "paying_party_number",            :limit => 63,                                  :null => false
    t.integer  "paying_party_type_enum",         :limit => 3,    :precision => 3,  :scale => 0, :null => false
    t.string   "pricing_structure_code",         :limit => 5,                                   :null => false
    t.string   "product_code",                   :limit => 5,                                   :null => false
    t.string   "rating_tax_code",                :limit => 5,                                   :null => false
    t.integer  "rating_tax_code_version_number", :limit => 4,    :precision => 4,  :scale => 0, :null => false
    t.integer  "recycle_sequence_number",        :limit => 10,   :precision => 10, :scale => 0, :null => false
    t.integer  "rerate_sequence_number",         :limit => 10,   :precision => 10, :scale => 0, :null => false
    t.string   "service_code",                   :limit => 5,                                   :null => false
    t.string   "service_subscription_id",        :limit => 16,                                  :null => false
    t.integer  "service_type_enum",              :limit => 3,    :precision => 3,  :scale => 0, :null => false
    t.string   "technical_service_code",         :limit => 60,                                  :null => false
    t.integer  "usage_sequence_number",          :limit => 10,   :precision => 10, :scale => 0, :null => false
    t.string   "usage_source_id",                :limit => 20,                                  :null => false
    t.datetime "start_date_time",                                                               :null => false
    t.integer  "xref_version_number",            :limit => 10,   :precision => 10, :scale => 0, :null => false
    t.binary   "data_blob",                                                                     :null => false
    t.string   "release_id",                     :limit => 20
    t.decimal  "adjustment_amount",                              :precision => 18, :scale => 6
    t.string   "rate_a_party_number",            :limit => 63
    t.integer  "rate_a_party_type_enum",         :limit => 3,    :precision => 3,  :scale => 0
    t.string   "rate_b_party_number",            :limit => 63
    t.integer  "rate_b_party_type_enum",         :limit => 3,    :precision => 3,  :scale => 0
    t.string   "other_party_needs_masking_ind",  :limit => 1
    t.string   "other_party_masked_number",      :limit => 63
    t.string   "other_party_number",             :limit => 63
    t.string   "product_commitment_number",      :limit => 12
    t.string   "tma_version_id_concat_string",   :limit => 2039
    t.string   "generic_string_1",               :limit => 100
    t.string   "generic_string_2",               :limit => 100
    t.string   "generic_string_3",               :limit => 100
    t.string   "generic_string_4",               :limit => 100
    t.string   "generic_string_5",               :limit => 100
    t.string   "generic_string_6",               :limit => 100
    t.string   "generic_string_7",               :limit => 100
    t.string   "generic_string_8",               :limit => 100
    t.string   "generic_string_9",               :limit => 100
    t.string   "generic_string_10",              :limit => 100
    t.string   "generic_string_11",              :limit => 100
    t.string   "generic_string_12",              :limit => 100
    t.string   "generic_string_13",              :limit => 100
    t.string   "generic_string_14",              :limit => 100
    t.string   "generic_string_15",              :limit => 100
    t.string   "generic_string_16",              :limit => 100
    t.string   "generic_string_17",              :limit => 100
    t.string   "generic_string_18",              :limit => 100
    t.string   "generic_string_19",              :limit => 100
    t.string   "generic_string_20",              :limit => 100
    t.string   "generic_string_21",              :limit => 100
    t.string   "generic_string_22",              :limit => 100
    t.string   "generic_string_23",              :limit => 100
    t.string   "generic_string_24",              :limit => 100
    t.string   "generic_string_25",              :limit => 100
    t.string   "generic_string_26",              :limit => 100
    t.string   "generic_string_27",              :limit => 100
    t.string   "generic_string_28",              :limit => 100
    t.string   "generic_string_29",              :limit => 100
    t.string   "generic_string_30",              :limit => 100
    t.string   "generic_string_31",              :limit => 100
    t.string   "generic_string_32",              :limit => 100
    t.string   "generic_string_33",              :limit => 100
    t.string   "generic_string_34",              :limit => 100
    t.string   "generic_string_35",              :limit => 100
    t.string   "generic_string_36",              :limit => 100
    t.string   "generic_string_37",              :limit => 100
    t.string   "generic_string_38",              :limit => 100
    t.string   "generic_string_39",              :limit => 100
    t.string   "generic_string_40",              :limit => 100
    t.string   "generic_string_41",              :limit => 100
    t.string   "generic_string_42",              :limit => 100
    t.string   "generic_string_43",              :limit => 100
    t.string   "generic_string_44",              :limit => 100
    t.string   "generic_string_45",              :limit => 100
    t.string   "generic_string_46",              :limit => 100
    t.string   "generic_string_47",              :limit => 100
    t.string   "generic_string_48",              :limit => 100
    t.string   "generic_string_49",              :limit => 100
    t.string   "generic_string_50",              :limit => 100
    t.string   "generic_string_51",              :limit => 100
    t.string   "generic_string_52",              :limit => 100
    t.string   "generic_string_53",              :limit => 100
    t.string   "generic_string_54",              :limit => 100
    t.string   "generic_string_55",              :limit => 100
    t.string   "generic_string_56",              :limit => 100
    t.string   "generic_string_57",              :limit => 100
    t.string   "generic_string_58",              :limit => 100
    t.string   "generic_string_59",              :limit => 100
    t.string   "generic_string_60",              :limit => 100
    t.string   "generic_string_61",              :limit => 100
    t.string   "generic_string_62",              :limit => 100
    t.string   "generic_string_63",              :limit => 100
    t.string   "generic_string_64",              :limit => 100
    t.string   "generic_string_65",              :limit => 100
    t.string   "generic_string_66",              :limit => 100
    t.string   "generic_string_67",              :limit => 100
    t.string   "generic_string_68",              :limit => 100
    t.string   "generic_string_69",              :limit => 100
    t.string   "generic_string_70",              :limit => 100
    t.string   "generic_string_71",              :limit => 100
    t.string   "generic_string_72",              :limit => 100
    t.string   "generic_string_73",              :limit => 100
    t.string   "generic_string_74",              :limit => 100
    t.string   "generic_string_75",              :limit => 100
    t.string   "generic_string_76",              :limit => 100
    t.string   "generic_string_77",              :limit => 100
    t.string   "generic_string_78",              :limit => 100
    t.string   "generic_string_79",              :limit => 100
    t.string   "generic_string_80",              :limit => 100
    t.string   "generic_string_81",              :limit => 100
    t.string   "generic_string_82",              :limit => 100
    t.string   "generic_string_83",              :limit => 100
    t.string   "generic_string_84",              :limit => 100
    t.string   "generic_string_85",              :limit => 100
    t.string   "generic_string_86",              :limit => 100
    t.string   "generic_string_87",              :limit => 100
    t.string   "generic_string_88",              :limit => 100
    t.string   "generic_string_89",              :limit => 100
    t.string   "generic_string_90",              :limit => 100
    t.string   "generic_string_91",              :limit => 100
    t.string   "generic_string_92",              :limit => 100
    t.string   "generic_string_93",              :limit => 100
    t.string   "generic_string_94",              :limit => 100
    t.string   "generic_string_95",              :limit => 100
    t.string   "generic_string_96",              :limit => 100
    t.string   "generic_string_97",              :limit => 100
    t.string   "generic_string_98",              :limit => 100
    t.string   "generic_string_99",              :limit => 100
    t.string   "generic_string_100",             :limit => 100
    t.decimal  "gross_billable_charge",                          :precision => 18, :scale => 9, :null => false
    t.decimal  "rating_total_tax_charge",                        :precision => 18, :scale => 9, :null => false
    t.decimal  "tax_charge",                                     :precision => 18, :scale => 9, :null => false
  end

  create_table "rates", :id => false, :force => true do |t|
    t.string  "rate_id",                 :limit => 20,                                 :null => false
    t.string  "rate_code",               :limit => 10,                                 :null => false
    t.string  "group_code",              :limit => 10
    t.string  "data_type",               :limit => 10,                                 :null => false
    t.boolean "min_charge_applies",                     :precision => 1,  :scale => 0
    t.integer "precision",                              :precision => 38, :scale => 0
    t.string  "title",                   :limit => 50,                                 :null => false
    t.string  "billing_code",            :limit => 10
    t.integer "width",                                  :precision => 38, :scale => 0
    t.boolean "default_allowed",                        :precision => 1,  :scale => 0
    t.string  "criteria",                :limit => 100
    t.string  "evaluation_order",        :limit => 10
    t.boolean "multi_selection_allowed",                :precision => 1,  :scale => 0
    t.string  "rate_type",               :limit => 15
    t.string  "rtti_path",               :limit => 100
  end

  create_table "rcp_controller_statistic", :id => false, :force => true do |t|
    t.string   "run_type",                 :limit => 8,                                 :null => false
    t.datetime "run_end_time",                                                          :null => false
    t.datetime "run_start_time",                                                        :null => false
    t.integer  "work_id",                  :limit => 22, :precision => 22, :scale => 0
    t.integer  "periodics_in_batch",       :limit => 8,  :precision => 8,  :scale => 0
    t.integer  "changes_in_batch",         :limit => 8,  :precision => 8,  :scale => 0
    t.integer  "mass_changes_to_breakout", :limit => 10, :precision => 10, :scale => 0
  end

  create_table "rcp_interface", :id => false, :force => true do |t|
    t.integer  "work_id",                    :limit => 20, :precision => 20, :scale => 0, :null => false
    t.string   "service_subscription_id",    :limit => 16,                                :null => false
    t.integer  "rcp_request_number",         :limit => 20, :precision => 20, :scale => 0, :null => false
    t.datetime "insertion_date_time",                                                     :null => false
    t.string   "transaction_status",         :limit => 6,                                 :null => false
    t.string   "charge_occurrence_type",     :limit => 2,                                 :null => false
    t.datetime "effective_process_date",                                                  :null => false
    t.string   "state_location_id",          :limit => 16,                                :null => false
    t.string   "cycle_name",                 :limit => 30,                                :null => false
    t.string   "customer_number",            :limit => 20,                                :null => false
    t.string   "promotion_subscription_id",  :limit => 16,                                :null => false
    t.string   "recurring_account_number",   :limit => 20,                                :null => false
    t.string   "one_time_account_number",    :limit => 20,                                :null => false
    t.string   "pricing_structure_code",     :limit => 5,                                 :null => false
    t.string   "product_subscription_id",    :limit => 16,                                :null => false
    t.string   "product_version_code",       :limit => 5,                                 :null => false
    t.string   "product_code",               :limit => 5,                                 :null => false
    t.string   "service_code",               :limit => 5,                                 :null => false
    t.string   "usage_mode_value",           :limit => 16,                                :null => false
    t.string   "event_creation_template_id", :limit => 16,                                :null => false
    t.string   "charge_method_type",         :limit => 2,                                 :null => false
    t.string   "charge_override_code",       :limit => 5,                                 :null => false
    t.string   "change_type_status",         :limit => 6,                                 :null => false
    t.string   "rate_plan_code",             :limit => 5,                                 :null => false
    t.string   "tariff_model_entry_id",      :limit => 16,                                :null => false
    t.string   "fractionalization_ind",      :limit => 1,                                 :null => false
    t.string   "early_termination_ind",      :limit => 1,                                 :null => false
    t.datetime "settlement_date",                                                         :null => false
    t.string   "exclude_trans_date_ind",     :limit => 1,                                 :null => false
    t.string   "request_description",        :limit => 60,                                :null => false
  end

  add_index "rcp_interface", ["service_subscription_id", "change_type_status", "effective_process_date"], :name => "ri_ind"

  create_table "rcp_mass_trans_to_serv_sub", :id => false, :force => true do |t|
    t.integer  "rcp_request_number",      :limit => 20, :precision => 20, :scale => 0, :null => false
    t.string   "service_subscription_id", :limit => 16,                                :null => false
    t.datetime "effective_process_date",                                               :null => false
    t.string   "rating_id",               :limit => 16,                                :null => false
    t.datetime "applied_date",                                                         :null => false
    t.string   "suppressed_indicator",    :limit => 1,                                 :null => false
    t.string   "change_type_ind",         :limit => 1,                                 :null => false
  end

  add_index "rcp_mass_trans_to_serv_sub", ["service_subscription_id", "rating_id", "effective_process_date", "applied_date"], :name => "rmttss_ind1", :tablespace => "indexes"

  create_table "re_pri_account", :id => false, :force => true do |t|
    t.integer  "request_idnumber",             :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "account_number",               :limit => 20,                                :null => false
    t.datetime "start_date",                                                                :null => false
    t.string   "tme_id",                       :limit => 16,                                :null => false
    t.string   "tariff_model_area_version_id", :limit => 16
    t.string   "contract_customer_number",     :limit => 20
    t.datetime "end_effective_date"
    t.integer  "affected_bill_period_count",   :limit => 10, :precision => 10, :scale => 0
    t.string   "audit_update_user_id",         :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                    :null => false
    t.integer  "update_number",                :limit => 22, :precision => 22, :scale => 0, :null => false
  end

  create_table "re_pri_account_sequence_number", :id => false, :force => true do |t|
    t.integer  "request_idnumber",           :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "account_number",             :limit => 20,                                :null => false
    t.integer  "invoice_sequence_number",    :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "state_rd",                   :limit => 16,                                :null => false
    t.string   "audit_update_user_id",       :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                  :null => false
    t.integer  "update_number",              :limit => 10, :precision => 10, :scale => 0, :null => false
    t.integer  "events_retrieved_count",     :limit => 10, :precision => 10, :scale => 0
    t.integer  "rated_summary_events_count", :limit => 10, :precision => 10, :scale => 0
    t.integer  "adjustments_count",          :limit => 10, :precision => 10, :scale => 0
  end

  create_table "re_pri_lock", :id => false, :force => true do |t|
    t.string   "account_number",          :limit => 20,                                :null => false
    t.integer  "invoice_sequence_number", :limit => 22, :precision => 22, :scale => 0, :null => false
    t.string   "tme_id",                  :limit => 16,                                :null => false
    t.integer  "request_idnumber",        :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "audit_update_user_id",    :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                               :null => false
    t.integer  "update_number",           :limit => 22, :precision => 22, :scale => 0, :null => false
  end

  create_table "re_rate_account", :id => false, :force => true do |t|
    t.integer  "request_idnumber",          :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "account_number",            :limit => 20,                                :null => false
    t.integer  "account_entry_idnumber",    :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "state_rd",                  :limit => 16,                                :null => false
    t.integer  "charge_type_mask_value",    :limit => 4,  :precision => 4,  :scale => 0, :null => false
    t.integer  "work_unit_count_value",     :limit => 4,  :precision => 4,  :scale => 0, :null => false
    t.integer  "work_unit_sequence_value",  :limit => 4,  :precision => 4,  :scale => 0, :null => false
    t.string   "partition_group_name",      :limit => 30
    t.datetime "partition_start_date_time"
    t.datetime "partition_end_date_time"
  end

  create_table "re_rate_file", :primary_key => "file_name", :force => true do |t|
    t.integer "request_idnumber",             :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string  "account_number",               :limit => 20,                                :null => false
    t.integer "invoice_seq_number",           :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string  "file_state_rd",                :limit => 16,                                :null => false
    t.integer "re_rate_file_sequence_number", :limit => 10, :precision => 10, :scale => 0, :null => false
    t.integer "account_entry_idnumber",       :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  add_index "re_rate_file", ["request_idnumber"], :name => "rrf_rra_fk_i", :tablespace => "indexes"

  create_table "re_rate_request", :primary_key => "request_idnumber", :force => true do |t|
    t.datetime "scheduled_date_time",                                                        :null => false
    t.string   "state_rd",                      :limit => 16,                                :null => false
    t.integer  "charge_type_mask_value",        :limit => 4,  :precision => 4,  :scale => 0, :null => false
    t.string   "audit_update_user_id",          :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                     :null => false
    t.integer  "update_number",                 :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "tariff_model_area_version_id",  :limit => 16
    t.string   "account_number",                :limit => 20
    t.string   "customer_number",               :limit => 20
    t.string   "access_number",                 :limit => 63
    t.string   "access_type_rd",                :limit => 16
    t.string   "product_code",                  :limit => 5
    t.string   "service_code",                  :limit => 5
    t.datetime "search_effective_date_time"
    t.integer  "file_sequence_number",          :limit => 10, :precision => 10, :scale => 0
    t.datetime "start_date"
    t.integer  "number_files_value",            :limit => 10, :precision => 10, :scale => 0
    t.integer  "number_events_value",           :limit => 10, :precision => 10, :scale => 0
    t.integer  "nei_vendor_number",             :limit => 10, :precision => 10, :scale => 0
    t.integer  "nei_version_number",            :limit => 4,  :precision => 4,  :scale => 0
    t.integer  "production_run_id",             :limit => 10, :precision => 10, :scale => 0
    t.string   "tariff_model_entry_id",         :limit => 16
    t.string   "contract_customer_number",      :limit => 20
    t.string   "scheduling_mode_code",          :limit => 5
    t.string   "flowthrough_indicator",         :limit => 1
    t.integer  "event_flowthrough_limit_value", :limit => 10, :precision => 10, :scale => 0
    t.datetime "xref_start_date_time"
    t.string   "service_subscription_id",       :limit => 16
    t.integer  "invoice_sequence_number",       :limit => 10, :precision => 10, :scale => 0
    t.integer  "production_batch_idnumber",     :limit => 10, :precision => 10, :scale => 0
    t.string   "external_events_indicator",     :limit => 1
  end

  create_table "region_table", :primary_key => "region_name", :force => true do |t|
    t.string   "region_code",                    :limit => 5,                                                    :null => false
    t.string   "description_string",             :limit => 1024,                                                 :null => false
    t.string   "audit_update_user_id",           :limit => 15,                                                   :null => false
    t.datetime "audit_update_date_time",                                                                         :null => false
    t.integer  "update_number",                  :limit => 10,   :precision => 10, :scale => 0,                  :null => false
    t.string   "post_office_box_string",         :limit => 10
    t.string   "post_office_postal_code_rd",     :limit => 16
    t.string   "post_office_city_name",          :limit => 30
    t.string   "post_office_country_code_rd",    :limit => 16
    t.string   "street_name",                    :limit => 30
    t.string   "street_number_string",           :limit => 20
    t.string   "additional_address_description", :limit => 60
    t.string   "city_name",                      :limit => 30
    t.string   "postal_code_rd",                 :limit => 16
    t.string   "country_code_rd",                :limit => 16
    t.string   "phone_number",                   :limit => 32
    t.string   "alt_phone_number",               :limit => 32
    t.string   "fax_phone_number",               :limit => 32
    t.string   "email_address",                  :limit => 129
    t.integer  "revision_number",                :limit => 10,   :precision => 10, :scale => 0
    t.string   "active_ind",                     :limit => 1,                                   :default => "Y"
  end

  add_index "region_table", ["region_code"], :name => "reg_ind1", :unique => true, :tablespace => "indexes"

  create_table "regional_location_table", :primary_key => "regional_location_name", :force => true do |t|
    t.string   "regional_location_code",         :limit => 5,                                                    :null => false
    t.string   "region_name",                    :limit => 30,                                                   :null => false
    t.string   "audit_update_user_id",           :limit => 15,                                                   :null => false
    t.datetime "audit_update_date_time",                                                                         :null => false
    t.integer  "update_number",                  :limit => 10,   :precision => 10, :scale => 0,                  :null => false
    t.string   "description_string",             :limit => 1024
    t.string   "post_office_box_string",         :limit => 10
    t.string   "post_office_postal_code_rd",     :limit => 16
    t.string   "post_office_city_name",          :limit => 30
    t.string   "post_office_country_code_rd",    :limit => 16
    t.string   "street_name",                    :limit => 30
    t.string   "street_number_string",           :limit => 20
    t.string   "additional_address_description", :limit => 60
    t.string   "city_name",                      :limit => 30
    t.string   "postal_code_rd",                 :limit => 16
    t.string   "country_code_rd",                :limit => 16
    t.string   "phone_number",                   :limit => 32
    t.string   "alt_phone_number",               :limit => 32
    t.string   "fax_phone_number",               :limit => 32
    t.string   "order_desk_manager_name",        :limit => 30
    t.string   "order_desk_manager_email_addr",  :limit => 50
    t.integer  "revision_number",                :limit => 10,   :precision => 10, :scale => 0
    t.string   "active_ind",                     :limit => 1,                                   :default => "Y"
  end

  add_index "regional_location_table", ["region_name"], :name => "rlt_idx"
  add_index "regional_location_table", ["regional_location_code"], :name => "rl_ind1", :unique => true, :tablespace => "indexes"

  create_table "reminder_notice", :primary_key => "reminder_notice_id", :force => true do |t|
    t.string   "customer_number",         :limit => 20,                                  :null => false
    t.string   "reminder_priority_rd",    :limit => 16,                                  :null => false
    t.datetime "reminder_date",                                                          :null => false
    t.datetime "creation_date",                                                          :null => false
    t.string   "text",                    :limit => 2048,                                :null => false
    t.string   "reminder_notice_type_rd", :limit => 16,                                  :null => false
    t.string   "audit_update_user_id",    :limit => 15,                                  :null => false
    t.datetime "audit_update_date_time",                                                 :null => false
    t.integer  "update_number",           :limit => 10,   :precision => 10, :scale => 0, :null => false
  end

  create_table "remote_nei_password", :id => false, :force => true do |t|
    t.string   "ne_identifier",                  :limit => 10,                                :null => false
    t.datetime "effective_date",                                                              :null => false
    t.string   "effective_status",               :limit => 6,                                 :null => false
    t.string   "remote_login",                   :limit => 20,                                :null => false
    t.string   "remote_password",                :limit => 50,                                :null => false
    t.datetime "remote_password_expiration_dat",                                              :null => false
    t.integer  "remote_warning_days",            :limit => 3,  :precision => 3,  :scale => 0, :null => false
    t.string   "audit_update_user_id",           :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                      :null => false
    t.integer  "update_number",                  :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  create_table "report_request", :primary_key => "job_id_string", :force => true do |t|
    t.string   "report_name_string",       :limit => 50,                                  :null => false
    t.string   "report_display_string",    :limit => 100,                                 :null => false
    t.datetime "start_date_time",                                                         :null => false
    t.datetime "finish_date_time",                                                        :null => false
    t.string   "status_string",            :limit => 20,                                  :null => false
    t.string   "status_message_string",    :limit => 2024,                                :null => false
    t.string   "user_name_string",         :limit => 20,                                  :null => false
    t.string   "retention_ind",            :limit => 1,                                   :null => false
    t.string   "audit_update_user_id",     :limit => 15,                                  :null => false
    t.datetime "audit_update_date_time",                                                  :null => false
    t.integer  "update_number",            :limit => 10,   :precision => 10, :scale => 0, :null => false
    t.string   "report_file_string",       :limit => 128
    t.string   "report_parameters_string", :limit => 1024
    t.string   "image_files_string",       :limit => 1024
    t.string   "format_string",            :limit => 20
    t.string   "request_url_string",       :limit => 2048
  end

  add_index "report_request", ["user_name_string"], :name => "report_request_user_name_idx", :tablespace => "indexes"

  create_table "resource_pool", :id => false, :force => true do |t|
    t.string   "regional_location_name",      :limit => 30,                                                   :null => false
    t.string   "role_name",                   :limit => 30,                                                   :null => false
    t.string   "description_string",          :limit => 1024,                                                 :null => false
    t.decimal  "scheduling_capacity_percent",                 :precision => 5,  :scale => 2,                  :null => false
    t.decimal  "max_scheduling_capacity_pct",                 :precision => 5,  :scale => 2,                  :null => false
    t.string   "availability_indicator",      :limit => 1,                                                    :null => false
    t.string   "auto_assign_ind",             :limit => 1,                                                    :null => false
    t.string   "audit_update_user_id",        :limit => 15,                                                   :null => false
    t.datetime "audit_update_date_time",                                                                      :null => false
    t.integer  "update_number",               :limit => 10,   :precision => 10, :scale => 0,                  :null => false
    t.string   "alt_regional_location_name",  :limit => 30
    t.string   "alt_role_name",               :limit => 30
    t.integer  "assign_period_val",           :limit => 4,    :precision => 4,  :scale => 0
    t.integer  "revision_number",             :limit => 10,   :precision => 10, :scale => 0
    t.string   "active_ind",                  :limit => 1,                                   :default => "Y"
  end

  add_index "resource_pool", ["alt_regional_location_name"], :name => "rp_idx"
  add_index "resource_pool", ["alt_role_name"], :name => "res_idx"
  add_index "resource_pool", ["role_name"], :name => "rp_rol_fk_i", :tablespace => "indexes"

  create_table "response_code_assoc", :id => false, :force => true do |t|
    t.string   "external_system_name",   :limit => 30,                                :null => false
    t.string   "response_code",          :limit => 16,                                :null => false
    t.string   "error_code",             :limit => 16,                                :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
    t.integer  "update_number",          :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "service_code",           :limit => 5,                                 :null => false
    t.string   "usage_mode_rd",          :limit => 16,                                :null => false
  end

  add_index "response_code_assoc", ["error_code"], :name => "rca_index1", :tablespace => "indexes"

  create_table "response_template", :primary_key => "response_template_id", :force => true do |t|
    t.string   "nsr_template_name",           :limit => 30,                                :null => false
    t.string   "keyword_rd",                  :limit => 60,                                :null => false
    t.string   "service_characteristic_code", :limit => 5,                                 :null => false
    t.string   "part_name",                   :limit => 30,                                :null => false
    t.string   "audit_update_user_id",        :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                   :null => false
    t.integer  "update_number",               :limit => 10, :precision => 10, :scale => 0, :null => false
    t.datetime "sr_template_effective_date"
  end

  add_index "response_template", ["nsr_template_name", "sr_template_effective_date"], :name => "rte_idx"

  create_table "roc_flexible_attribute", :id => false, :force => true do |t|
    t.string   "service_subscription_id",  :limit => 16,                                :null => false
    t.datetime "effective_date",                                                        :null => false
    t.integer  "rtti_path_relid",          :limit => 20, :precision => 20, :scale => 0, :null => false
    t.integer  "attribute_type_enum",      :limit => 3,  :precision => 3,  :scale => 0, :null => false
    t.string   "flexible_attribute_value", :limit => 25
  end

  add_index "roc_flexible_attribute", ["rtti_path_relid"], :name => "rfa_idx"

  create_table "roc_rate_result", :id => false, :force => true do |t|
    t.string   "service_subscription_id", :limit => 16,                                :null => false
    t.datetime "effective_date",                                                       :null => false
    t.integer  "rtti_path_relid",         :limit => 20, :precision => 20, :scale => 0, :null => false
    t.string   "rate_attribute_value",    :limit => 25
    t.string   "rate_table_id",           :limit => 16,                                :null => false
    t.string   "rate_table_entry_id",     :limit => 16,                                :null => false
  end

  add_index "roc_rate_result", ["rtti_path_relid"], :name => "rrr_idx"

  create_table "roc_service_subscription", :primary_key => "service_subscription_id", :force => true do |t|
    t.string   "charge_method_type",           :limit => 2,  :null => false
    t.string   "starting_usage_mode_value",    :limit => 16, :null => false
    t.datetime "activation_period_start_date"
    t.datetime "activation_period_end_date"
  end

  create_table "roc_timeline", :id => false, :force => true do |t|
    t.string   "service_subscription_id",     :limit => 16,                                :null => false
    t.datetime "effective_start_date",                                                     :null => false
    t.string   "timeline_entry_type",         :limit => 2,                                 :null => false
    t.integer  "rcp_request_number",          :limit => 20, :precision => 20, :scale => 0, :null => false
    t.integer  "roc_timeline_relid",          :limit => 20, :precision => 20, :scale => 0, :null => false
    t.datetime "effective_end_date",                                                       :null => false
    t.string   "change_type_status",          :limit => 6,                                 :null => false
    t.string   "state_location_id",           :limit => 16,                                :null => false
    t.string   "contract_customer_number",    :limit => 20,                                :null => false
    t.string   "product_subscription_id",     :limit => 16,                                :null => false
    t.string   "account_number",              :limit => 20,                                :null => false
    t.string   "pricing_structure_code",      :limit => 5,                                 :null => false
    t.string   "product_version_code",        :limit => 5,                                 :null => false
    t.string   "product_code",                :limit => 5,                                 :null => false
    t.string   "service_code",                :limit => 5,                                 :null => false
    t.integer  "transaction_sequence_number", :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "subscription_status",         :limit => 6
    t.string   "cycle_name",                  :limit => 30
    t.string   "charge_override_code",        :limit => 5
    t.string   "event_creation_template_id",  :limit => 16
    t.string   "ect_type_indicator",          :limit => 1
    t.datetime "start_date"
    t.datetime "end_date"
    t.decimal  "first_period_amount",                       :precision => 18, :scale => 6
    t.decimal  "last_period_amount",                        :precision => 18, :scale => 6
    t.decimal  "ect_full_amount",                           :precision => 18, :scale => 6
    t.string   "ect_period_type",             :limit => 2
    t.integer  "ect_period_factor",           :limit => 3,  :precision => 3,  :scale => 0
    t.datetime "prediction_generation_date"
    t.integer  "ot_sequence_number",          :limit => 20, :precision => 20, :scale => 0
  end

  add_index "roc_timeline", ["effective_end_date", "account_number", "timeline_entry_type", "cycle_name"], :name => "roc_time_ind3", :tablespace => "indexes"
  add_index "roc_timeline", ["event_creation_template_id", "ect_type_indicator", "effective_end_date", "change_type_status", "service_subscription_id"], :name => "roc_time_ind4", :tablespace => "indexes"
  add_index "roc_timeline", ["event_creation_template_id", "effective_end_date", "change_type_status", "service_subscription_id"], :name => "roc_time_ind2", :tablespace => "indexes"
  add_index "roc_timeline", ["roc_timeline_relid"], :name => "roc_time_uc1", :unique => true, :tablespace => "indexes"
  add_index "roc_timeline", ["service_subscription_id", "timeline_entry_type", "effective_end_date"], :name => "roc_time_ind1", :tablespace => "indexes"

  create_table "roc_work", :primary_key => "work_numid", :force => true do |t|
  end

  create_table "role_table", :primary_key => "role_name", :force => true do |t|
    t.string   "description_string",     :limit => 1024,                                                 :null => false
    t.string   "management_indicator",   :limit => 1,                                                    :null => false
    t.string   "default_indicator",      :limit => 1,                                                    :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                                   :null => false
    t.datetime "audit_update_date_time",                                                                 :null => false
    t.integer  "update_number",          :limit => 10,   :precision => 10, :scale => 0,                  :null => false
    t.string   "product_type_rd",        :limit => 16
    t.integer  "revision_number",        :limit => 10,   :precision => 10, :scale => 0
    t.string   "active_ind",             :limit => 1,                                   :default => "Y"
  end

  create_table "rollback_point_dep_chain", :id => false, :force => true do |t|
    t.string   "rollback_point_id",      :limit => 16,                                :null => false
    t.string   "business_activity_id",   :limit => 16,                                :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
    t.integer  "update_number",          :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  add_index "rollback_point_dep_chain", ["business_activity_id"], :name => "rpdc_ind1"

  create_table "rrm_statistic", :id => false, :force => true do |t|
    t.integer  "request_idnumber",       :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.datetime "process_end_date",                                                     :null => false
    t.string   "process_id",             :limit => 20,                                 :null => false
    t.integer  "xref_version_number",    :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.datetime "process_start_date",                                                   :null => false
    t.string   "request_step_name",      :limit => 30,                                 :null => false
    t.integer  "events_num",             :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.string   "file_name",              :limit => 100,                                :null => false
    t.string   "instance_name",          :limit => 30
    t.integer  "rerated_event_number",   :limit => 10,  :precision => 10, :scale => 0
    t.integer  "skipped_event_number",   :limit => 10,  :precision => 10, :scale => 0
    t.string   "account_number",         :limit => 20
    t.integer  "account_entry_idnumber", :limit => 22,  :precision => 22, :scale => 0, :null => false
  end

  create_table "rtti_information", :primary_key => "process_name", :force => true do |t|
    t.text     "rtti_information_clob",               :null => false
    t.datetime "time_stamp",                          :null => false
    t.string   "process_argument_name", :limit => 60
  end

  create_table "rtti_repository", :primary_key => "rtti_path", :force => true do |t|
    t.integer "rtti_path_relid", :limit => 20, :precision => 20, :scale => 0, :null => false
  end

  add_index "rtti_repository", ["rtti_path_relid"], :name => "rttir_uk", :unique => true, :tablespace => "indexes"

  create_table "rules", :force => true do |t|
    t.string   "name",                                        :null => false
    t.string   "description1",                                :null => false
    t.string   "description2",                                :null => false
    t.decimal  "value",        :precision => 20, :scale => 2, :null => false
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
    t.integer  "active",       :precision => 38, :scale => 0, :null => false
  end

  create_table "rupd$_config_service_chara", :temporary => true, :id => false, :force => true do |t|
    t.string   "service_subscription_id",     :limit => 16
    t.string   "service_characteristic_code", :limit => 5
    t.datetime "effective_date"
    t.string   "config_service_char_id",      :limit => 16
    t.string   "dmltype$$",                   :limit => 1
    t.integer  "snapid",                                     :precision => 38, :scale => 0
    t.raw      "change_vector$$",             :limit => 255
  end

  create_table "rupd$_configured_value", :temporary => true, :id => false, :force => true do |t|
    t.string  "configured_value_id", :limit => 16
    t.string  "dmltype$$",           :limit => 1
    t.integer "snapid",                             :precision => 38, :scale => 0
    t.raw     "change_vector$$",     :limit => 255
  end

  create_table "rupd$_tapestry_statistic", :temporary => true, :id => false, :force => true do |t|
    t.string  "statistic_id",    :limit => 16
    t.string  "dmltype$$",       :limit => 1
    t.integer "snapid",                         :precision => 38, :scale => 0
    t.raw     "change_vector$$", :limit => 255
  end

  create_table "rupd$_tapestry_statistic_d", :temporary => true, :id => false, :force => true do |t|
    t.string  "detail_id",       :limit => 16
    t.string  "statistic_id",    :limit => 16
    t.string  "dmltype$$",       :limit => 1
    t.integer "snapid",                         :precision => 38, :scale => 0
    t.raw     "change_vector$$", :limit => 255
  end

  create_table "rupd$_tapestry_statistic_f", :temporary => true, :id => false, :force => true do |t|
    t.string  "statistic_file_id", :limit => 16
    t.string  "statistic_id",      :limit => 16
    t.string  "dmltype$$",         :limit => 1
    t.integer "snapid",                           :precision => 38, :scale => 0
    t.raw     "change_vector$$",   :limit => 255
  end

  create_table "sample_envelope", :id => false, :force => true do |t|
    t.string   "mailing_id",                :limit => 16,                                :null => false
    t.datetime "print_date_time",                                                        :null => false
    t.string   "verification_rule_name",    :limit => 30,                                :null => false
    t.string   "envelope_id",               :limit => 16,                                :null => false
    t.integer  "production_run_idnumber",   :limit => 10, :precision => 10, :scale => 0, :null => false
    t.integer  "production_batch_idnumber", :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "audit_update_user_id",      :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                 :null => false
  end

  add_index "sample_envelope", ["mailing_id", "print_date_time", "envelope_id"], :name => "samp_idx"
  add_index "sample_envelope", ["production_batch_idnumber"], :name => "senv_prb_fk", :tablespace => "indexes"
  add_index "sample_envelope", ["production_run_idnumber", "verification_rule_name"], :name => "senv_prr_fk", :tablespace => "indexes"

  create_table "sap_dunning", :id => false, :force => true do |t|
    t.string   "account_number",               :limit => 20,                                :null => false
    t.datetime "sap_status_date",                                                           :null => false
    t.string   "sap_dunning_status_indicator", :limit => 1,                                 :null => false
    t.string   "sap_request_type_indicator",   :limit => 1,                                 :null => false
    t.string   "audit_update_user_id",         :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                    :null => false
    t.integer  "update_number",                :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  create_table "sap_dunning_processing", :id => false, :force => true do |t|
    t.string   "account_number",         :limit => 20,                                :null => false
    t.datetime "effective_date",                                                      :null => false
    t.string   "state_transition_rd",    :limit => 16,                                :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
    t.integer  "update_number",          :limit => 10, :precision => 10, :scale => 0, :null => false
    t.integer  "process_status_value",   :limit => 4,  :precision => 4,  :scale => 0
  end

  create_table "sap_dunning_statistic", :id => false, :force => true do |t|
    t.string   "file_name",                      :limit => 100,                                :null => false
    t.datetime "start_date_time",                                                              :null => false
    t.string   "audit_update_user_id",           :limit => 15,                                 :null => false
    t.datetime "audit_update_date_time",                                                       :null => false
    t.integer  "update_number",                  :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.datetime "file_date"
    t.integer  "process_status_value",           :limit => 10,  :precision => 10, :scale => 0
    t.integer  "declared_input_row_count_value", :limit => 10,  :precision => 10, :scale => 0
    t.integer  "verified_input_row_count_value", :limit => 10,  :precision => 10, :scale => 0
    t.integer  "upload_errored_row_count_value", :limit => 10,  :precision => 10, :scale => 0
    t.datetime "end_date_time"
    t.integer  "suspended_account_count_value",  :limit => 10,  :precision => 10, :scale => 0
    t.integer  "reactivated_account_count_val",  :limit => 10,  :precision => 10, :scale => 0
    t.integer  "failed_to_suspend_count_value",  :limit => 10,  :precision => 10, :scale => 0
    t.integer  "failed_to_reactivate_count_val", :limit => 10,  :precision => 10, :scale => 0
    t.decimal  "error_threshold_percent",                       :precision => 5,  :scale => 2
  end

  create_table "sap_search_return_code", :primary_key => "search_id", :force => true do |t|
    t.string   "return_code_type_indicator",     :limit => 1,                                  :null => false
    t.string   "return_code_id",                 :limit => 20,                                 :null => false
    t.string   "audit_update_user_id",           :limit => 15,                                 :null => false
    t.datetime "audit_update_date_time",                                                       :null => false
    t.integer  "update_number",                  :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.string   "return_code_type_number",        :limit => 4
    t.string   "return_code_message",            :limit => 221
    t.string   "return_code_log_number",         :limit => 21
    t.string   "return_code_log_message_number", :limit => 7
    t.string   "return_code_message_var_1",      :limit => 51
    t.string   "return_code_message_var_2",      :limit => 51
    t.string   "return_code_message_var_3",      :limit => 51
    t.string   "return_code_message_var_4",      :limit => 51
    t.string   "return_code_table",              :limit => 33
    t.string   "return_code_row",                :limit => 11
    t.string   "return_code_field",              :limit => 31
  end

  create_table "schedule_day", :id => false, :force => true do |t|
    t.datetime "start_date",                                                            :null => false
    t.string   "regional_location_name",   :limit => 30,                                :null => false
    t.string   "role_name",                :limit => 30,                                :null => false
    t.datetime "schedule_week_start_date",                                              :null => false
    t.integer  "capacity_value",           :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "audit_update_user_id",     :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                :null => false
    t.integer  "update_number",            :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  add_index "schedule_day", ["schedule_week_start_date", "regional_location_name", "role_name"], :name => "sd_idx"

  create_table "schedule_week", :id => false, :force => true do |t|
    t.datetime "start_date",                                                          :null => false
    t.string   "regional_location_name", :limit => 30,                                :null => false
    t.string   "role_name",              :limit => 30,                                :null => false
    t.integer  "capacity_value",         :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
    t.integer  "update_number",          :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  add_index "schedule_week", ["regional_location_name", "role_name"], :name => "sw_idx"

  create_table "schema", :primary_key => "schema_name", :force => true do |t|
    t.datetime "creation_date",                  :null => false
    t.string   "base_schema_name", :limit => 30
  end

  create_table "schema_control", :id => false, :force => true do |t|
    t.integer  "schema_control_version_number", :limit => 10, :precision => 10, :scale => 0, :null => false
    t.datetime "applied_date",                                                               :null => false
  end

  create_table "schema_parameter", :id => false, :force => true do |t|
    t.string   "schema_name",           :limit => 30, :null => false
    t.string   "schema_parameter_name", :limit => 30, :null => false
    t.string   "parameter_value",       :limit => 30, :null => false
    t.string   "modifiable_indicator",  :limit => 1,  :null => false
    t.datetime "last_update_date",                    :null => false
  end

  create_table "schema_pit", :id => false, :force => true do |t|
    t.string   "measured_item_name",    :limit => 30,                                :null => false
    t.integer  "measured_value_number",               :precision => 38, :scale => 0, :null => false
    t.datetime "measured_date_time",                                                 :null => false
  end

  create_table "schema_release", :id => false, :force => true do |t|
    t.string   "schema_name",    :limit => 30,                                :null => false
    t.integer  "release_number", :limit => 10, :precision => 10, :scale => 0, :null => false
    t.datetime "applied_date",                                                :null => false
  end

  create_table "schema_subversion", :id => false, :force => true do |t|
    t.string   "schema_name",       :limit => 30,                                :null => false
    t.integer  "release_number",    :limit => 10, :precision => 10, :scale => 0, :null => false
    t.integer  "version_number",    :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "version_extension", :limit => 3,                                 :null => false
    t.datetime "applied_date",                                                   :null => false
  end

  create_table "schema_upgrade_plan", :primary_key => "schema_name", :force => true do |t|
    t.datetime "creation_date", :null => false
  end

  create_table "schema_upgrade_plan_detail", :id => false, :force => true do |t|
    t.string   "schema_name",          :limit => 30,                                :null => false
    t.integer  "release_number",       :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "upgrade_source",       :limit => 1,                                 :null => false
    t.integer  "start_version_number", :limit => 10, :precision => 10, :scale => 0, :null => false
    t.integer  "end_version_number",   :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "upgrade_status",       :limit => 10,                                :null => false
    t.datetime "update_date",                                                       :null => false
  end

  create_table "schema_upgrade_plan_error", :primary_key => "schema_name", :force => true do |t|
    t.integer "release_number",    :limit => 10, :precision => 10, :scale => 0, :null => false
    t.integer "version_number",    :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string  "version_extension", :limit => 3,                                 :null => false
  end

  create_table "schema_version", :id => false, :force => true do |t|
    t.string   "schema_name",    :limit => 30,                                :null => false
    t.integer  "release_number", :limit => 10, :precision => 10, :scale => 0, :null => false
    t.integer  "version_number", :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "upgrade_status", :limit => 10,                                :null => false
    t.datetime "applied_date",                                                :null => false
  end

  create_table "scripted_command_cml", :id => false, :force => true do |t|
    t.string   "package_name",           :limit => 60,                      :null => false
    t.string   "cml_name",               :limit => 60,                      :null => false
    t.text     "cml_text",                                                  :null => false
    t.string   "audit_update_user_id",   :limit => 15,                      :null => false
    t.datetime "audit_update_date_time",                                    :null => false
    t.string   "cml_type_code",          :limit => 6,  :default => "SCRPT", :null => false
  end

# Could not dump table "scripted_command_definition" because of following StandardError
#   Unknown type 'XMLTYPE' for column 'scripted_command_xml'

  create_table "scripted_command_dependency", :id => false, :force => true do |t|
    t.string   "from_command_id",        :limit => 60,                                :null => false
    t.string   "to_command_id",          :limit => 60,                                :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
    t.integer  "update_number",          :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  create_table "scripted_command_status", :primary_key => "command_id", :force => true do |t|
    t.string   "original_command_id",    :limit => 60
    t.string   "status_string",          :limit => 20,                                :null => false
    t.binary   "command_blob"
    t.binary   "response_blob"
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
    t.integer  "update_number",          :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  add_index "scripted_command_status", ["original_command_id"], :name => "scs_ind_2", :tablespace => "indexes"
  add_index "scripted_command_status", ["status_string"], :name => "scs_ind_1", :tablespace => "indexes"

  create_table "section_definition", :id => false, :force => true do |t|
    t.string   "section_definition_name", :limit => 30,                                :null => false
    t.datetime "effective_date",                                                       :null => false
    t.string   "effective_status",        :limit => 6,                                 :null => false
    t.string   "mix_indicator",           :limit => 1,                                 :null => false
    t.string   "audit_update_user_id",    :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                               :null => false
    t.integer  "update_number",           :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "description",             :limit => 60
  end

  create_table "section_definition_list", :id => false, :force => true do |t|
    t.string   "document_template_name",   :limit => 30,                                :null => false
    t.datetime "document_template_eff_dt",                                              :null => false
    t.integer  "sequence_number",          :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "section_definition_name",  :limit => 30,                                :null => false
    t.string   "audit_update_user_id",     :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                :null => false
    t.integer  "update_number",            :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  create_table "selected_destination", :id => false, :force => true do |t|
    t.string   "price_plan_subscription_id", :limit => 16,                                :null => false
    t.string   "selected_destination_id",    :limit => 16,                                :null => false
    t.datetime "effective_date",                                                          :null => false
    t.string   "effective_status",           :limit => 6,                                 :null => false
    t.string   "begin_number",               :limit => 32,                                :null => false
    t.string   "audit_update_user_id",       :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                  :null => false
    t.integer  "update_number",              :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "end_number",                 :limit => 32
  end

  add_index "selected_destination", ["price_plan_subscription_id"], :name => "pp_subscription_ind", :tablespace => "indexes"

  create_table "selected_service_char", :id => false, :force => true do |t|
    t.string   "business_activity_id",   :limit => 16,                                :null => false
    t.string   "service_char_code",      :limit => 16,                                :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
    t.integer  "update_number",          :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "modify_rule_rd",         :limit => 16
    t.string   "perform_rollback_ind",   :limit => 1,                                 :null => false
  end

  create_table "selection_rule", :id => false, :force => true do |t|
    t.string   "selection_rule_name",     :limit => 30,                                 :null => false
    t.datetime "effective_date",                                                        :null => false
    t.string   "condition_name",          :limit => 30,                                 :null => false
    t.string   "effective_status",        :limit => 6,                                  :null => false
    t.string   "billing_char_group_name", :limit => 30,                                 :null => false
    t.string   "rule_type",               :limit => 2,                                  :null => false
    t.string   "audit_update_user_id",    :limit => 15,                                 :null => false
    t.datetime "audit_update_date_time",                                                :null => false
    t.integer  "update_number",           :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.string   "description",             :limit => 60
    t.string   "sort_key_text",           :limit => 360
    t.string   "group_key_text",          :limit => 360
    t.string   "summary_list_text",       :limit => 360
  end

  create_table "selection_rule_condition", :primary_key => "condition_id", :force => true do |t|
    t.string   "condition_code",         :limit => 5,                                   :null => false
    t.string   "name",                   :limit => 30,                                  :null => false
    t.string   "parent_type",            :limit => 2,                                   :null => false
    t.string   "condition_string",       :limit => 2000,                                :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                  :null => false
    t.datetime "audit_update_date_time",                                                :null => false
    t.integer  "update_number",          :limit => 10,   :precision => 10, :scale => 0, :null => false
    t.string   "descriptive_text",       :limit => 360
  end

  create_table "selection_rule_list", :id => false, :force => true do |t|
    t.string   "section_definition_name",   :limit => 30,                                :null => false
    t.datetime "section_definition_eff_dt",                                              :null => false
    t.integer  "sequence_number",           :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "selection_rule_name",       :limit => 30,                                :null => false
    t.string   "audit_update_user_id",      :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                 :null => false
    t.integer  "update_number",             :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  create_table "sensitivity", :primary_key => "sensitivity_version_id", :force => true do |t|
    t.string   "sensitivity_code",            :limit => 5,                                  :null => false
    t.string   "name",                        :limit => 30,                                 :null => false
    t.datetime "effective_date",                                                            :null => false
    t.string   "effective_status",            :limit => 6,                                  :null => false
    t.string   "audit_update_user_id",        :limit => 15,                                 :null => false
    t.datetime "audit_update_date_time",                                                    :null => false
    t.integer  "update_number",               :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.string   "tariff_model_area_indicator", :limit => 1,                                  :null => false
    t.string   "test_mode_ind",               :limit => 1,                                  :null => false
    t.string   "descriptive_text",            :limit => 360
    t.string   "change_group_id",             :limit => 30
  end

  add_index "sensitivity", ["change_group_id"], :name => "sen_idx"

  create_table "sensitivity_condition_expr", :primary_key => "condition_expression_id", :force => true do |t|
    t.string   "sensitivity_code",       :limit => 5,                                 :null => false
    t.string   "condition_code",         :limit => 5,                                 :null => false
    t.string   "sr_condition_id",        :limit => 16,                                :null => false
    t.integer  "component_order_value",  :limit => 4,  :precision => 4,  :scale => 0, :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
    t.integer  "update_number",          :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  add_index "sensitivity_condition_expr", ["sr_condition_id"], :name => "sce_src_fk_i", :tablespace => "indexes"

  create_table "sensitivity_domain_condition", :primary_key => "condition_id", :force => true do |t|
    t.string   "condition_code",         :limit => 5,                                   :null => false
    t.string   "sensitivity_version_id", :limit => 16,                                  :null => false
    t.string   "name",                   :limit => 60,                                  :null => false
    t.string   "parent_type",            :limit => 2,                                   :null => false
    t.string   "condition_string",       :limit => 2000,                                :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                  :null => false
    t.datetime "audit_update_date_time",                                                :null => false
    t.integer  "update_number",          :limit => 10,   :precision => 10, :scale => 0, :null => false
    t.string   "billing_name_1",         :limit => 30,                                  :null => false
    t.string   "billing_name_2",         :limit => 30
    t.string   "descriptive_text",       :limit => 360
  end

  add_index "sensitivity_domain_condition", ["sensitivity_version_id"], :name => "sdc_idx"

  create_table "sequence_number_generator", :primary_key => "business_attribute_name", :force => true do |t|
    t.integer  "maximum_index_number",   :limit => 12, :precision => 12, :scale => 0, :null => false
    t.datetime "audit_update_date_time",                                              :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.integer  "update_number",          :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  create_table "serv_deliv_cont_product_commit", :id => false, :force => true do |t|
    t.string   "product_commitment_number",      :limit => 12,                                :null => false
    t.datetime "effective_date",                                                              :null => false
    t.string   "contract_number",                :limit => 12,                                :null => false
    t.string   "effective_status",               :limit => 6,                                 :null => false
    t.string   "loi_indicator",                  :limit => 1,                                 :null => false
    t.string   "on_hold_indicator",              :limit => 1,                                 :null => false
    t.string   "pricing_structure_code",         :limit => 5,                                 :null => false
    t.string   "product_code",                   :limit => 5,                                 :null => false
    t.string   "product_commitment_number_part", :limit => 12,                                :null => false
    t.string   "product_version_code",           :limit => 5,                                 :null => false
    t.integer  "quantity_value",                 :limit => 4,  :precision => 4,  :scale => 0, :null => false
    t.datetime "state_date",                                                                  :null => false
    t.string   "state_rd",                       :limit => 16,                                :null => false
    t.integer  "version_number",                 :limit => 4,  :precision => 4,  :scale => 0, :null => false
    t.string   "notice_period_exempt_indicator", :limit => 1,                                 :null => false
    t.string   "audit_update_user_id",           :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                      :null => false
    t.integer  "update_number",                  :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "board_sign_name",                :limit => 30
    t.string   "grace_period_dur_unit_rd",       :limit => 16
    t.integer  "grace_period_dur_value",         :limit => 4,  :precision => 4,  :scale => 0
    t.string   "min_period_dur_unit_rd",         :limit => 16
    t.integer  "min_period_dur_value",           :limit => 4,  :precision => 4,  :scale => 0
    t.datetime "min_period_start_date"
    t.decimal  "monthly_order_entry_amount",                   :precision => 18, :scale => 6
    t.datetime "board_sign_date"
    t.string   "notice_period_dur_unit_rd",      :limit => 16
    t.integer  "notice_period_dur_value",        :limit => 4,  :precision => 4,  :scale => 0
    t.datetime "notice_period_start_date"
    t.datetime "primary_cust_sign_date"
    t.string   "primary_cust_sign_name",         :limit => 30
    t.datetime "sales_org_date"
    t.integer  "sales_org_number_value",         :limit => 10, :precision => 10, :scale => 0
    t.datetime "secondary_cust_sign_date"
    t.string   "secondary_cust_sign_name",       :limit => 30
    t.string   "term_dur_unit_rd",               :limit => 16
    t.integer  "term_dur_value",                 :limit => 4,  :precision => 4,  :scale => 0
    t.string   "term_extent_dur_unit_rd",        :limit => 16
    t.integer  "term_extent_dur_value",          :limit => 4,  :precision => 4,  :scale => 0
    t.datetime "term_start_date"
    t.datetime "termination_date"
    t.string   "termination_restriction_rd",     :limit => 16
    t.string   "transaction_id",                 :limit => 16
    t.string   "document_template_name",         :limit => 30
  end

  add_index "serv_deliv_cont_product_commit", ["contract_number", "product_code", "product_version_code", "pricing_structure_code", "state_rd"], :name => "cn_sdcpc_ind", :tablespace => "indexes"

  create_table "serv_subscr_price_plan_subscr", :id => false, :force => true do |t|
    t.string   "service_subscription_id",     :limit => 16,                                :null => false
    t.string   "price_plan_subscription_id",  :limit => 16,                                :null => false
    t.datetime "effective_date",                                                           :null => false
    t.string   "effective_status",            :limit => 6,                                 :null => false
    t.string   "active_price_plan_indicator", :limit => 1,                                 :null => false
    t.string   "audit_update_user_id",        :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                   :null => false
    t.integer  "update_number",               :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "transaction_id",              :limit => 16
  end

  add_index "serv_subscr_price_plan_subscr", ["price_plan_subscription_id"], :name => "ppsub_serv_ppsub_fk_i", :tablespace => "indexes"

  create_table "serv_subscr_tax_description", :id => false, :force => true do |t|
    t.string   "service_subscription_id",   :limit => 16,                                :null => false
    t.string   "tax_jurisdiction_state",    :limit => 2,                                 :null => false
    t.string   "tax_jurisdiction_county",   :limit => 3,                                 :null => false
    t.string   "tax_jurisdiction_city",     :limit => 4,                                 :null => false
    t.string   "tax_jurisdiction_sub",      :limit => 3,                                 :null => false
    t.string   "incorporated_code",         :limit => 1,                                 :null => false
    t.datetime "effective_date",                                                         :null => false
    t.string   "effective_status",          :limit => 6,                                 :null => false
    t.integer  "subscr_num_of_lines_value", :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "audit_update_user_id",      :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                 :null => false
    t.integer  "update_number",             :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "originating_id",            :limit => 16,                                :null => false
    t.string   "tax_code_rd",               :limit => 16
  end

  create_table "service", :id => false, :force => true do |t|
    t.string   "service_code",                  :limit => 5,                                  :null => false
    t.string   "service_version_code",          :limit => 5,                                  :null => false
    t.string   "service_level_id",              :limit => 16,                                 :null => false
    t.string   "name",                          :limit => 60,                                 :null => false
    t.datetime "effective_date",                                                              :null => false
    t.string   "effective_status",              :limit => 6,                                  :null => false
    t.string   "classification_value",          :limit => 16,                                 :null => false
    t.string   "tax_code",                      :limit => 5,                                  :null => false
    t.string   "access_indicator",              :limit => 1,                                  :null => false
    t.string   "provisioned_indicator",         :limit => 1,                                  :null => false
    t.string   "technical_service_value",       :limit => 16,                                 :null => false
    t.string   "allow_multipoint_taxation_ind", :limit => 1,                                  :null => false
    t.string   "test_mode_ind",                 :limit => 1,                                  :null => false
    t.string   "audit_update_user_id",          :limit => 15,                                 :null => false
    t.datetime "audit_update_date_time",                                                      :null => false
    t.integer  "update_number",                 :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.string   "deniable_indicator",            :limit => 1,                                  :null => false
    t.string   "provider_code",                 :limit => 5
    t.string   "descriptive_text",              :limit => 360
    t.integer  "min_time_of_provision",         :limit => 10,  :precision => 10, :scale => 0
    t.string   "responsible_manager",           :limit => 30
    t.string   "billing_name_1",                :limit => 60,                                 :null => false
    t.string   "billing_name_2",                :limit => 60
    t.string   "comment_id",                    :limit => 16
    t.datetime "planned_release_date"
    t.datetime "discontinue_date_time"
    t.string   "discontinue_indicator",         :limit => 1
    t.string   "utility_indicator",             :limit => 1
    t.string   "change_group_id",               :limit => 30
  end

  add_index "service", ["change_group_id"], :name => "ser_idx"
  add_index "service", ["provider_code"], :name => "ser2_idx"
  add_index "service", ["service_level_id"], :name => "ser_sl_fk_i", :tablespace => "indexes"

  create_table "service_association", :id => false, :force => true do |t|
    t.string   "service_code",            :limit => 5,                                 :null => false
    t.string   "associated_service_code", :limit => 5,                                 :null => false
    t.string   "excludes_indicator",      :limit => 1,                                 :null => false
    t.string   "requires_indicator",      :limit => 1,                                 :null => false
    t.string   "is_required_indicator",   :limit => 1,                                 :null => false
    t.string   "owns_indicator",          :limit => 1,                                 :null => false
    t.string   "is_owned_indicator",      :limit => 1,                                 :null => false
    t.string   "audit_update_user_id",    :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                               :null => false
    t.integer  "update_number",           :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  add_index "service_association", ["associated_service_code"], :name => "sa_ser_associated_service_co_1", :tablespace => "indexes"

  create_table "service_characteristic", :primary_key => "service_char_code", :force => true do |t|
    t.string   "name",                        :limit => 60,                                 :null => false
    t.string   "audit_update_user_id",        :limit => 15,                                 :null => false
    t.datetime "audit_update_date_time",                                                    :null => false
    t.integer  "update_number",               :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.string   "value_type_ind",              :limit => 1,                                  :null => false
    t.string   "priceable_characteristic_id", :limit => 16
    t.string   "measure_unit_profile_code",   :limit => 5
    t.string   "def_char_value_id",           :limit => 16
    t.string   "datatype_value",              :limit => 16
    t.string   "descriptive_text",            :limit => 360
    t.string   "characteristic_type_value",   :limit => 16
    t.string   "line_count_method_rd",        :limit => 16
    t.integer  "number_of_lines_value",       :limit => 10,  :precision => 10, :scale => 0
  end

  add_index "service_characteristic", ["def_char_value_id"], :name => "sc_cv_fk_i", :tablespace => "indexes"
  add_index "service_characteristic", ["measure_unit_profile_code"], :name => "sc_mup_fk_i", :tablespace => "indexes"
  add_index "service_characteristic", ["priceable_characteristic_id"], :name => "sc_pc_fk_i", :tablespace => "indexes"

  create_table "service_characteristic_value", :id => false, :force => true do |t|
    t.string   "service_code",             :limit => 5,                                 :null => false
    t.string   "service_version_code",     :limit => 5,                                 :null => false
    t.string   "service_char_code",        :limit => 5,                                 :null => false
    t.string   "fixed_variable_indicator", :limit => 1,                                 :null => false
    t.string   "mandatory_provision_ind",  :limit => 1,                                 :null => false
    t.string   "set_by_customer_ind",      :limit => 1,                                 :null => false
    t.string   "audit_update_user_id",     :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                :null => false
    t.integer  "update_number",            :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "measure_unit_code",        :limit => 5
    t.string   "continuous_value",         :limit => 30
    t.string   "discrete_value",           :limit => 30
    t.string   "value_type_ind",           :limit => 1,                                 :null => false
    t.integer  "max_number_of_values",     :limit => 10, :precision => 10, :scale => 0
  end

  add_index "service_characteristic_value", ["measure_unit_code"], :name => "serc2_idx"
  add_index "service_characteristic_value", ["service_char_code"], :name => "serc_idx"

  create_table "service_coverage", :primary_key => "service_coverage_code", :force => true do |t|
    t.string   "name",                   :limit => 30,                                 :null => false
    t.string   "test_mode_ind",          :limit => 1,                                  :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                 :null => false
    t.datetime "audit_update_date_time",                                               :null => false
    t.integer  "update_number",          :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.string   "descriptive_text",       :limit => 360
    t.string   "change_group_id",        :limit => 30
  end

  add_index "service_coverage", ["change_group_id"], :name => "sec_idx"

  create_table "service_coverage_service_group", :id => false, :force => true do |t|
    t.string   "service_coverage_code",  :limit => 5,                                 :null => false
    t.string   "service_group_code",     :limit => 5,                                 :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
    t.integer  "update_number",          :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  create_table "service_delivery_contract", :id => false, :force => true do |t|
    t.string   "contract_number",                :limit => 12,                                :null => false
    t.datetime "effective_date",                                                              :null => false
    t.string   "effective_status",               :limit => 6,                                 :null => false
    t.string   "language_rd",                    :limit => 16,                                :null => false
    t.string   "on_hold_indicator",              :limit => 1,                                 :null => false
    t.string   "state_rd",                       :limit => 16,                                :null => false
    t.integer  "version_number",                 :limit => 4,  :precision => 4,  :scale => 0, :null => false
    t.datetime "state_date",                                                                  :null => false
    t.string   "currency_rd",                    :limit => 16,                                :null => false
    t.string   "loi_indicator",                  :limit => 1,                                 :null => false
    t.string   "audit_update_user_id",           :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                      :null => false
    t.integer  "update_number",                  :limit => 10, :precision => 10, :scale => 0, :null => false
    t.datetime "board_sign_date"
    t.string   "board_sign_name",                :limit => 30
    t.string   "document_template_name",         :limit => 30
    t.decimal  "monthly_order_entry_amount",                   :precision => 18, :scale => 6
    t.string   "primary_cust_sign_name",         :limit => 30
    t.datetime "primary_cust_sign_date"
    t.datetime "secondary_cust_sign_date"
    t.string   "secondary_cust_sign_name",       :limit => 30
    t.string   "assoc_skeleton_contract_number", :limit => 12
    t.datetime "min_period_end_date"
    t.datetime "min_period_start_date"
    t.datetime "term_end_date"
    t.datetime "term_start_date"
  end

  create_table "service_group", :primary_key => "service_group_version_id", :force => true do |t|
    t.string   "service_group_code",     :limit => 5,                                  :null => false
    t.string   "name",                   :limit => 30,                                 :null => false
    t.datetime "effective_date",                                                       :null => false
    t.string   "effective_status",       :limit => 6,                                  :null => false
    t.string   "test_mode_ind",          :limit => 1,                                  :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                 :null => false
    t.datetime "audit_update_date_time",                                               :null => false
    t.integer  "update_number",          :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.string   "descriptive_text",       :limit => 360
    t.string   "change_group_id",        :limit => 30
  end

  add_index "service_group", ["change_group_id"], :name => "sgr_idx"
  add_index "service_group", ["service_group_code", "effective_date"], :name => "sg_ind1", :tablespace => "indexes"

  create_table "service_group_service", :id => false, :force => true do |t|
    t.string   "service_group_version_id", :limit => 16,                                :null => false
    t.string   "service_code",             :limit => 5,                                 :null => false
    t.string   "audit_update_user_id",     :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                :null => false
    t.integer  "update_number",            :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  add_index "service_group_service", ["service_code"], :name => "sgs_ser_fk_i", :tablespace => "indexes"

  create_table "service_journalization", :id => false, :force => true do |t|
    t.string   "service_code",           :limit => 5,                                 :null => false
    t.string   "service_version_code",   :limit => 5,                                 :null => false
    t.datetime "effective_date",                                                      :null => false
    t.string   "accounting_code_string", :limit => 20,                                :null => false
    t.string   "event_category_rd",      :limit => 16,                                :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
    t.integer  "update_number",          :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  create_table "service_level", :primary_key => "service_level_id", :force => true do |t|
    t.string   "service_level_value",    :limit => 16,                                 :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                 :null => false
    t.datetime "audit_update_date_time",                                               :null => false
    t.integer  "update_number",          :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.string   "descriptive_text",       :limit => 360
  end

  create_table "service_location", :primary_key => "service_location_id", :force => true do |t|
    t.string   "config_service_char_id",   :limit => 16,                                 :null => false
    t.string   "audit_update_user_id",     :limit => 15,                                 :null => false
    t.datetime "audit_update_date_time",                                                 :null => false
    t.integer  "update_number",            :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.string   "room_number",              :limit => 10
    t.string   "desk_number",              :limit => 10
    t.string   "jack_location",            :limit => 30
    t.string   "additional_location_info", :limit => 360
    t.string   "floor",                    :limit => 5
  end

  add_index "service_location", ["config_service_char_id"], :name => "srvlc_confgsc_fk_i", :tablespace => "indexes"

  create_table "service_order", :primary_key => "service_order_stp_id", :force => true do |t|
    t.string   "internal_order_position_id", :limit => 16,                                :null => false
    t.string   "internal_order_id",          :limit => 16,                                :null => false
    t.string   "priority_value_rd",          :limit => 16,                                :null => false
    t.string   "state_rd",                   :limit => 16,                                :null => false
    t.string   "standard_indicator",         :limit => 1,                                 :null => false
    t.string   "usage_mode_value_rd",        :limit => 16,                                :null => false
    t.string   "service_code",               :limit => 5,                                 :null => false
    t.string   "service_version_code",       :limit => 5,                                 :null => false
    t.string   "audit_update_user_id",       :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                  :null => false
    t.integer  "update_number",              :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "workflow_template_id",       :limit => 16
    t.datetime "actual_start_date_time"
    t.datetime "actual_end_date_time"
    t.datetime "desired_date_time"
    t.string   "desired_schedule_type_rd",   :limit => 16
    t.string   "product_code",               :limit => 5
  end

  add_index "service_order", ["internal_order_id"], :name => "seo_activity_fk_i", :tablespace => "indexes"
  add_index "service_order", ["internal_order_position_id"], :name => "seo_position_activity_fk_i", :tablespace => "indexes"
  add_index "service_order", ["workflow_template_id"], :name => "seo_workflow_fk_i", :tablespace => "indexes"

  create_table "service_order_date", :id => false, :force => true do |t|
    t.string   "service_order_stp_id",       :limit => 16,                                :null => false
    t.string   "code",                       :limit => 5,                                 :null => false
    t.string   "description",                :limit => 60,                                :null => false
    t.string   "audit_update_user_id",       :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                  :null => false
    t.integer  "update_number",              :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "assoc_business_activity_id", :limit => 16
    t.datetime "planned_end_date"
    t.datetime "actual_end_date"
  end

  add_index "service_order_date", ["assoc_business_activity_id"], :name => "sod_ind1", :tablespace => "indexes"

  create_table "service_order_wkfl_sel_rule", :primary_key => "service_order_wkfl_sel_rule_id", :force => true do |t|
    t.string   "library_item_name",      :limit => 30,                                :null => false
    t.string   "usage_mode_code",        :limit => 16,                                :null => false
    t.string   "service_code",           :limit => 5,                                 :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
    t.integer  "update_number",          :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "region_name",            :limit => 30
    t.string   "customer_number",        :limit => 20
    t.string   "customer_category_rd",   :limit => 16
  end

  add_index "service_order_wkfl_sel_rule", ["library_item_name"], :name => "sowsr_li_fk_i", :tablespace => "indexes"
  add_index "service_order_wkfl_sel_rule", ["region_name"], :name => "sowsr_reg_fk_i", :tablespace => "indexes"

  create_table "service_postal", :id => false, :force => true do |t|
    t.string   "service_code",           :limit => 5,                                 :null => false
    t.string   "service_version_code",   :limit => 5,                                 :null => false
    t.string   "postal_code",            :limit => 9,                                 :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
    t.integer  "update_number",          :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  create_table "service_property", :id => false, :force => true do |t|
    t.string   "service_property_id",     :limit => 16,                                 :null => false
    t.string   "service_order_stp_id",    :limit => 16,                                 :null => false
    t.string   "service_property_code",   :limit => 5,                                  :null => false
    t.string   "name",                    :limit => 60,                                 :null => false
    t.string   "property_type_value_rd",  :limit => 16,                                 :null => false
    t.string   "data_type_value_rd",      :limit => 16,                                 :null => false
    t.string   "value_type_indicator_rd", :limit => 16,                                 :null => false
    t.string   "modified_indicator",      :limit => 1,                                  :null => false
    t.string   "fixed_indicator",         :limit => 1,                                  :null => false
    t.string   "modifiable_indicator",    :limit => 1,                                  :null => false
    t.string   "audit_update_user_id",    :limit => 15,                                 :null => false
    t.datetime "audit_update_date_time",                                                :null => false
    t.integer  "update_number",           :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.string   "description",             :limit => 360
    t.string   "sm_only_ind",             :limit => 1
  end

  add_index "service_property", ["service_order_stp_id"], :name => "sp_ind1", :tablespace => "indexes"

# Could not dump table "service_request_response" because of following StandardError
#   Unknown type 'XMLTYPE' for column 'response_xml'

  create_table "service_subscription", :primary_key => "service_subscription_id", :force => true do |t|
    t.string   "product_subscription_id",       :limit => 16,                                :null => false
    t.string   "service_code",                  :limit => 5,                                 :null => false
    t.string   "mandatory_indicator",           :limit => 1,                                 :null => false
    t.string   "state_rd",                      :limit => 16,                                :null => false
    t.datetime "state_date",                                                                 :null => false
    t.string   "technical_service_code_rd",     :limit => 16,                                :null => false
    t.string   "service_version_code",          :limit => 5,                                 :null => false
    t.string   "location_limited_indicator",    :limit => 1,                                 :null => false
    t.string   "audit_update_user_id",          :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                     :null => false
    t.integer  "update_number",                 :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "allow_multipoint_taxation_ind", :limit => 1,                                 :null => false
    t.string   "deniable_ind",                  :limit => 1,                                 :null => false
    t.integer  "quantity",                      :limit => 4,  :precision => 4,  :scale => 0
  end

  add_index "service_subscription", ["product_subscription_id"], :name => "servsub_prosub_fk_i", :tablespace => "indexes"

  create_table "service_subscription_dep", :id => false, :force => true do |t|
    t.string   "service_subscription_id",       :limit => 16,                                :null => false
    t.string   "service_subscription_dep_id",   :limit => 16,                                :null => false
    t.string   "service_association_indicator", :limit => 1,                                 :null => false
    t.string   "audit_update_user_id",          :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                     :null => false
    t.integer  "update_number",                 :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  add_index "service_subscription_dep", ["service_subscription_dep_id"], :name => "ssd_ind1", :tablespace => "indexes"

  create_table "service_ticket_position", :primary_key => "service_ticket_position_id", :force => true do |t|
    t.string   "service_subscription_id",       :limit => 16,                                :null => false
    t.string   "usage_mode_value_rd",           :limit => 16,                                :null => false
    t.string   "reason_rd",                     :limit => 16,                                :null => false
    t.string   "state_rd",                      :limit => 16,                                :null => false
    t.string   "on_hold_indicator",             :limit => 1,                                 :null => false
    t.datetime "state_date",                                                                 :null => false
    t.datetime "desired_date",                                                               :null => false
    t.string   "process_immediately_indicator", :limit => 1,                                 :null => false
    t.integer  "same_day_value",                :limit => 4,  :precision => 4,  :scale => 0, :null => false
    t.string   "service_version_code",          :limit => 5,                                 :null => false
    t.string   "charge_override_code_rd",       :limit => 16,                                :null => false
    t.datetime "original_desired_date",                                                      :null => false
    t.string   "audit_update_user_id",          :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                     :null => false
    t.integer  "update_number",                 :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "customer_order_id",             :limit => 10
    t.string   "cancel_reason_rd",              :limit => 16
    t.string   "desired_schedule_type_rd",      :limit => 16
    t.datetime "completion_date"
  end

  add_index "service_ticket_position", ["customer_order_id"], :name => "servtct_custord_fk_i", :tablespace => "indexes"
  add_index "service_ticket_position", ["desired_date"], :name => "servtct_desdate_i", :tablespace => "indexes"
  add_index "service_ticket_position", ["service_subscription_id"], :name => "servtct_servsub_fk_i", :tablespace => "indexes"

  create_table "service_ticket_position_dep", :id => false, :force => true do |t|
    t.string   "service_ticket_position_id",     :limit => 16,                                :null => false
    t.string   "service_ticket_position_dep_id", :limit => 16,                                :null => false
    t.string   "audit_update_user_id",           :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                      :null => false
    t.integer  "update_number",                  :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  add_index "service_ticket_position_dep", ["service_ticket_position_dep_id"], :name => "stpd_ind", :tablespace => "indexes"

  create_table "service_usage_mode", :id => false, :force => true do |t|
    t.string   "service_code",           :limit => 5,                                 :null => false
    t.string   "usage_mode_value",       :limit => 16,                                :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
    t.integer  "update_number",          :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  create_table "skeleton_contract", :id => false, :force => true do |t|
    t.string   "contract_number",                :limit => 12,                                :null => false
    t.datetime "effective_date",                                                              :null => false
    t.string   "effective_status",               :limit => 6,                                 :null => false
    t.string   "currency_rd",                    :limit => 16,                                :null => false
    t.string   "language_rd",                    :limit => 16,                                :null => false
    t.string   "loi_indicator",                  :limit => 1,                                 :null => false
    t.string   "notice_period_exempt_indicator", :limit => 1,                                 :null => false
    t.string   "on_hold_indicator",              :limit => 1,                                 :null => false
    t.datetime "state_date",                                                                  :null => false
    t.string   "state_rd",                       :limit => 16,                                :null => false
    t.integer  "version_number",                 :limit => 4,  :precision => 4,  :scale => 0, :null => false
    t.string   "audit_update_user_id",           :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                      :null => false
    t.integer  "update_number",                  :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "min_period_dur_unit_rd",         :limit => 16
    t.integer  "min_period_dur_value",           :limit => 4,  :precision => 4,  :scale => 0
    t.datetime "min_period_start_date"
    t.decimal  "monthly_order_entry_amount",                   :precision => 18, :scale => 6
    t.string   "notice_period_dur_unit_rd",      :limit => 16
    t.integer  "notice_period_dur_value",        :limit => 4,  :precision => 4,  :scale => 0
    t.datetime "notice_period_start_date"
    t.string   "primary_cust_sign_name",         :limit => 30
    t.datetime "primary_cust_sign_date"
    t.integer  "sales_org_number_value",         :limit => 10, :precision => 10, :scale => 0
    t.datetime "sales_org_date"
    t.string   "secondary_cust_sign_name",       :limit => 30
    t.datetime "secondary_cust_sign_date"
    t.string   "term_dur_unit_rd",               :limit => 16
    t.integer  "term_dur_value",                 :limit => 4,  :precision => 4,  :scale => 0
    t.datetime "termination_date"
    t.datetime "term_start_date"
    t.string   "term_extent_dur_unit_rd",        :limit => 16
    t.integer  "term_extent_dur_value",          :limit => 4,  :precision => 4,  :scale => 0
    t.string   "termination_restriction_rd",     :limit => 16
    t.string   "board_sign_name",                :limit => 30
    t.datetime "board_sign_date"
    t.string   "document_template_name",         :limit => 30
    t.string   "grace_period_dur_unit_rd",       :limit => 16
    t.integer  "grace_period_dur_value",         :limit => 4,  :precision => 4,  :scale => 0
    t.datetime "release_date"
  end

  create_table "sm_characteristic_value", :primary_key => "characteristic_value_id", :force => true do |t|
    t.string   "service_char_code",      :limit => 5,                                 :null => false
    t.string   "value_type_ind",         :limit => 1,                                 :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
    t.integer  "update_number",          :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "d_value",                :limit => 30
    t.string   "c_minimum_value",        :limit => 30
    t.string   "c_maximum_value",        :limit => 30
    t.string   "c_default_value",        :limit => 30
    t.string   "measure_unit_code",      :limit => 5
    t.integer  "revision_number",        :limit => 10, :precision => 10, :scale => 0
  end

  add_index "sm_characteristic_value", ["measure_unit_code"], :name => "sm_char_value_ind2"
  add_index "sm_characteristic_value", ["service_char_code"], :name => "sm_char_value_ind1"

  create_table "sm_measure_unit", :primary_key => "measure_unit_code", :force => true do |t|
    t.string   "name",                   :limit => 30,                                 :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                 :null => false
    t.datetime "audit_update_date_time",                                               :null => false
    t.integer  "update_number",          :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.string   "descriptive_text",       :limit => 360
    t.integer  "revision_number",        :limit => 10,  :precision => 10, :scale => 0
  end

  create_table "sm_product_version", :id => false, :force => true do |t|
    t.string   "product_version_code",   :limit => 5,                                  :null => false
    t.string   "product_code",           :limit => 5,                                  :null => false
    t.datetime "effective_date",                                                       :null => false
    t.string   "effective_status",       :limit => 6,                                  :null => false
    t.string   "name",                   :limit => 60,                                 :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                 :null => false
    t.datetime "audit_update_date_time",                                               :null => false
    t.integer  "update_number",          :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.string   "descriptive_text",       :limit => 360
    t.integer  "revision_number",        :limit => 10,  :precision => 10, :scale => 0
  end

  create_table "sm_service_char_value", :id => false, :force => true do |t|
    t.string   "service_code",             :limit => 5,                                 :null => false
    t.string   "service_version_code",     :limit => 5,                                 :null => false
    t.string   "service_char_code",        :limit => 5,                                 :null => false
    t.string   "fixed_variable_indicator", :limit => 1,                                 :null => false
    t.string   "audit_update_user_id",     :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                :null => false
    t.integer  "update_number",            :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "value_type_ind",           :limit => 1,                                 :null => false
    t.string   "distinct_value",           :limit => 30
    t.string   "continuous_value",         :limit => 30
    t.string   "measure_unit_code",        :limit => 5
    t.integer  "revision_number",          :limit => 10, :precision => 10, :scale => 0
  end

  create_table "sm_service_characteristic", :primary_key => "service_char_code", :force => true do |t|
    t.string   "name",                      :limit => 30,                                 :null => false
    t.string   "audit_update_user_id",      :limit => 15,                                 :null => false
    t.datetime "audit_update_date_time",                                                  :null => false
    t.integer  "update_number",             :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.string   "datatype_value",            :limit => 16
    t.string   "descriptive_text",          :limit => 360
    t.string   "value_type_ind",            :limit => 1
    t.string   "characteristic_type_value", :limit => 16
    t.integer  "revision_number",           :limit => 10,  :precision => 10, :scale => 0
  end

  create_table "sm_service_usage_mode", :id => false, :force => true do |t|
    t.string   "service_code",           :limit => 5,                                 :null => false
    t.string   "usage_mode_value",       :limit => 16,                                :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
    t.integer  "update_number",          :limit => 10, :precision => 10, :scale => 0, :null => false
    t.integer  "revision_number",        :limit => 10, :precision => 10, :scale => 0
  end

  create_table "sm_service_version", :id => false, :force => true do |t|
    t.string   "service_code",           :limit => 5,                                  :null => false
    t.string   "service_version_code",   :limit => 5,                                  :null => false
    t.datetime "effective_date",                                                       :null => false
    t.string   "effective_status",       :limit => 6,                                  :null => false
    t.string   "name",                   :limit => 30,                                 :null => false
    t.string   "provisioned_indicator",  :limit => 1,                                  :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                 :null => false
    t.datetime "audit_update_date_time",                                               :null => false
    t.integer  "update_number",          :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.string   "descriptive_text",       :limit => 360
    t.integer  "revision_number",        :limit => 10,  :precision => 10, :scale => 0
  end

  create_table "sr_template", :id => false, :force => true do |t|
    t.string   "sr_template_name",           :limit => 30,                                 :null => false
    t.string   "in_progress_indicator",      :limit => 1,                                  :null => false
    t.string   "format_type_rd",             :limit => 16,                                 :null => false
    t.string   "message_type",               :limit => 60,                                 :null => false
    t.string   "response_ind",               :limit => 1,                                  :null => false
    t.string   "audit_update_user_id",       :limit => 15,                                 :null => false
    t.datetime "audit_update_date_time",                                                   :null => false
    t.integer  "update_number",              :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.string   "template_description",       :limit => 120
    t.binary   "command_cml_blob"
    t.string   "external_system_name",       :limit => 30
    t.string   "default_cml_ind",            :limit => 1
    t.datetime "effective_date",                                                           :null => false
    t.string   "effective_status",           :limit => 6
    t.binary   "command_xslt_blob"
    t.binary   "response_match_xslt_blob"
    t.binary   "response_xslt_blob"
    t.binary   "display_command_xslt_blob"
    t.binary   "display_response_xslt_blob"
    t.integer  "revision_number",            :limit => 10,  :precision => 10, :scale => 0
    t.string   "sr_schema_name",             :limit => 60
  end

# Could not dump table "sr_template_schema" because of following StandardError
#   Unknown type 'XMLTYPE' for column 'schema_xml'

  create_table "ssm_interface", :id => false, :force => true do |t|
    t.datetime "effective_date",                           :null => false
    t.string   "status",                     :limit => 6,  :null => false
    t.string   "state_rd",                   :limit => 16, :null => false
    t.string   "audit_update_user_id",       :limit => 16, :null => false
    t.datetime "audit_update_date_time",                   :null => false
    t.string   "account_number",             :limit => 20
    t.string   "price_plan_subscription_id", :limit => 16
    t.string   "transaction_status",         :limit => 6
    t.string   "price_plan_code",            :limit => 5
  end

  add_index "ssm_interface", ["state_rd", "effective_date"], :name => "scci_ind1", :tablespace => "indexes"

  create_table "ssm_statistic", :id => false, :force => true do |t|
    t.string   "source_identifier",       :limit => 10,                                :null => false
    t.string   "instance_name",           :limit => 30,                                :null => false
    t.datetime "process_start_datetime",                                               :null => false
    t.datetime "process_end_datetime",                                                 :null => false
    t.integer  "xref_version_number",     :limit => 10, :precision => 10, :scale => 0, :null => false
    t.integer  "total_psm_record_count",  :limit => 10, :precision => 10, :scale => 0
    t.integer  "total_ssm_in_rec",        :limit => 10, :precision => 10, :scale => 0
    t.integer  "total_ssm_err",           :limit => 10, :precision => 10, :scale => 0
    t.integer  "total_recurring_created", :limit => 10, :precision => 10, :scale => 0
    t.integer  "total_recurring_error",   :limit => 10, :precision => 10, :scale => 0
    t.integer  "total_line_tax_created",  :limit => 10, :precision => 10, :scale => 0
  end

  create_table "stream_definition", :primary_key => "stream_name", :force => true do |t|
    t.string "load_balance_ind", :limit => 1, :null => false
  end

  create_table "stream_definition_install", :primary_key => "stream_name", :force => true do |t|
    t.decimal "max_cpu_usage_number",                      :precision => 5,  :scale => 2, :null => false
    t.integer "max_res_mem_number",          :limit => 16, :precision => 16, :scale => 0, :null => false
    t.integer "load_balance_horizon_number", :limit => 5,  :precision => 5,  :scale => 0, :null => false
  end

  create_table "stream_job_use", :id => false, :force => true do |t|
    t.string  "stream_name",                :limit => 30,                                :null => false
    t.string  "job_name",                   :limit => 30,                                :null => false
    t.string  "generate_msg_ind",           :limit => 1,                                 :null => false
    t.decimal "msg_generation_rate_number",               :precision => 5,  :scale => 3, :null => false
    t.string  "error_threshold_ind",        :limit => 1,                                 :null => false
    t.integer "error_threshold_number",     :limit => 12, :precision => 12, :scale => 0, :null => false
  end

  add_index "stream_job_use", ["job_name"], :name => "sj_idx"

  create_table "stream_job_use_install", :id => false, :force => true do |t|
    t.string  "stream_name",              :limit => 30,                               :null => false
    t.string  "job_name",                 :limit => 30,                               :null => false
    t.integer "init_run_process_number",  :limit => 5,  :precision => 5, :scale => 0, :null => false
    t.integer "min_run_process_number",   :limit => 5,  :precision => 5, :scale => 0, :null => false
    t.integer "max_run_process_number",   :limit => 5,  :precision => 5, :scale => 0, :null => false
    t.integer "init_susp_process_number", :limit => 5,  :precision => 5, :scale => 0, :null => false
  end

  create_table "stream_relationship", :id => false, :force => true do |t|
    t.string "stream_name",         :limit => 30, :null => false
    t.string "relationship_rd",     :limit => 16, :null => false
    t.string "related_stream_name", :limit => 30, :null => false
  end

  add_index "stream_relationship", ["related_stream_name"], :name => "str_idx"

  create_table "stream_status", :id => false, :force => true do |t|
    t.string   "stream_name",            :limit => 30, :null => false
    t.string   "host_name",              :limit => 30, :null => false
    t.string   "status_rd",              :limit => 16, :null => false
    t.string   "load_balancing_ind",     :limit => 1,  :null => false
    t.datetime "audit_update_date_time",               :null => false
    t.datetime "start_date_time",                      :null => false
    t.datetime "end_date_time"
  end

  create_table "subscription_contract", :primary_key => "subscription_contract_id", :force => true do |t|
    t.string   "contract_code",              :limit => 10,                                :null => false
    t.string   "state_rd",                   :limit => 16,                                :null => false
    t.string   "contract_level",             :limit => 1,                                 :null => false
    t.string   "customer_number",            :limit => 20,                                :null => false
    t.string   "product_commitment_number",  :limit => 12
    t.integer  "product_commitment_version", :limit => 4,  :precision => 4,  :scale => 0
    t.string   "product_subscription_id",    :limit => 16
    t.string   "service_subscription_id",    :limit => 16
    t.datetime "create_date_time",                                                        :null => false
    t.datetime "start_date",                                                              :null => false
    t.datetime "end_date",                                                                :null => false
    t.datetime "sign_date_time",                                                          :null => false
    t.datetime "terminate_date",                                                          :null => false
    t.datetime "audit_update_date_time",                                                  :null => false
    t.string   "audit_update_user_id",       :limit => 15,                                :null => false
    t.integer  "update_number",              :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  add_index "subscription_contract", ["customer_number"], :name => "sc_ind1"

# Could not dump table "subscription_event_history" because of following StandardError
#   Unknown type 'XMLTYPE' for column 'event'

# Could not dump table "subscription_event_pending" because of following StandardError
#   Unknown type 'XMLTYPE' for column 'event'

# Could not dump table "subscription_event_transaction" because of following StandardError
#   Unknown type 'XMLTYPE' for column 'event'

  create_table "summary_attribute", :primary_key => "attribute_id", :force => true do |t|
    t.string   "rtti_path",              :limit => 360,                                :null => false
    t.string   "name",                   :limit => 30,                                 :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                 :null => false
    t.datetime "audit_update_date_time",                                               :null => false
    t.integer  "update_number",          :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.string   "descriptive_text",       :limit => 360
  end

  create_table "summary_group", :primary_key => "summary_group_id", :force => true do |t|
    t.string   "billing_name_1",         :limit => 30,                                 :null => false
    t.string   "billing_name_2",         :limit => 30,                                 :null => false
    t.string   "name",                   :limit => 30,                                 :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                 :null => false
    t.datetime "audit_update_date_time",                                               :null => false
    t.integer  "update_number",          :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.string   "descriptive_text",       :limit => 360
  end

  add_index "summary_group", ["name"], :name => "sumgp_uk", :unique => true, :tablespace => "indexes"

  create_table "summary_group_component", :id => false, :force => true do |t|
    t.string   "summary_group_id",       :limit => 16,                                :null => false
    t.string   "attribute_id",           :limit => 16,                                :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                              :null => false
    t.integer  "update_number",          :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  add_index "summary_group_component", ["attribute_id"], :name => "sgc_idx"

  create_table "switch_information", :id => false, :force => true do |t|
    t.string   "switch_id",                    :limit => 11,                                :null => false
    t.datetime "effective_date",                                                            :null => false
    t.string   "effective_status",             :limit => 6,                                 :null => false
    t.string   "enable_row_indicator",         :limit => 1,                                 :null => false
    t.string   "lata_string",                  :limit => 5,                                 :null => false
    t.integer  "vertical_coordinate_number",   :limit => 10, :precision => 10, :scale => 0, :null => false
    t.integer  "horizontal_coordinate_number", :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "switch_type",                  :limit => 2,                                 :null => false
    t.string   "wireless_indicator",           :limit => 1,                                 :null => false
    t.string   "audit_update_user_id",         :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                    :null => false
    t.integer  "update_number",                :limit => 10, :precision => 10, :scale => 0, :null => false
  end

  create_table "tapestry_job", :id => false, :force => true do |t|
    t.string   "lock_indicator",             :limit => 1,                                  :null => false
    t.string   "procedure_name",             :limit => 4000,                               :null => false
    t.datetime "next_date",                                                                :null => false
    t.string   "interval_string",                                                          :null => false
    t.string   "ignore_active_instance_ind", :limit => 1,                                  :null => false
    t.integer  "parallel_instance_number",   :limit => 3,    :precision => 3, :scale => 0, :null => false
    t.string   "parm1_string",               :limit => 4000
    t.string   "parm2_string",               :limit => 4000
    t.string   "parm3_string",               :limit => 4000
    t.string   "parm4_string",               :limit => 4000
    t.string   "parm5_string",               :limit => 4000
  end

  create_table "tapestry_job_data", :id => false, :force => true do |t|
    t.string "group_id",     :limit => 20,   :null => false
    t.string "type_string",  :limit => 10,   :null => false
    t.string "parm1_string", :limit => 4000
    t.string "parm2_string", :limit => 4000
    t.string "parm3_string", :limit => 4000
    t.string "parm4_string", :limit => 4000
    t.string "parm5_string", :limit => 4000
  end

  create_table "tapestry_job_error", :id => false, :force => true do |t|
    t.decimal  "job_number",                          :null => false
    t.decimal  "job_sequence_number",                 :null => false
    t.datetime "start_date_time",                     :null => false
    t.string   "procedure_name",      :limit => 4000, :null => false
    t.string   "message_string",      :limit => 4000
    t.string   "location_string"
  end

  create_table "tapestry_job_status", :id => false, :force => true do |t|
    t.decimal  "job_number",                        :null => false
    t.string   "procedure_name",    :limit => 4000, :null => false
    t.datetime "start_date_time",                   :null => false
    t.string   "status_string",     :limit => 9,    :null => false
    t.datetime "end_date_time"
    t.decimal  "parent_job_number"
  end

  add_index "tapestry_job_status", ["parent_job_number", "job_number"], :name => "tjs_ind1"
  add_index "tapestry_job_status", ["status_string", "job_number", "parent_job_number"], :name => "tjs_ind"

# Could not dump table "tapestry_queue" because of following StandardError
#   Unknown type 'HVF_MSG_TYPE' for column 'user_data'

  create_table "tapestry_statistic", :primary_key => "statistic_id", :force => true do |t|
    t.string   "process_name",      :limit => 30,                                :null => false
    t.integer  "process_id_number", :limit => 10, :precision => 10, :scale => 0, :null => false
    t.datetime "start_date_time",                                                :null => false
    t.datetime "end_date_time",                                                  :null => false
    t.string   "instance_name",     :limit => 30
    t.integer  "batch_id_number",   :limit => 10, :precision => 10, :scale => 0
    t.integer  "run_id_number",     :limit => 10, :precision => 10, :scale => 0
    t.integer  "group_id_number",   :limit => 10, :precision => 10, :scale => 0
  end

  add_index "tapestry_statistic", ["end_date_time"], :name => "tst_edt", :tablespace => "indexes"

  create_table "tapestry_statistic_detail", :id => false, :force => true do |t|
    t.string   "statistic_id",      :limit => 16,                                 :null => false
    t.string   "detail_id",         :limit => 16,                                 :null => false
    t.string   "group_code",        :limit => 10,                                 :null => false
    t.string   "stat_name_string",  :limit => 60,                                 :null => false
    t.string   "statistic_file_id", :limit => 16
    t.decimal  "value_number",                     :precision => 18, :scale => 6
    t.datetime "value_date_time"
    t.string   "value_text",        :limit => 360
  end

  add_index "tapestry_statistic_detail", ["statistic_id"], :name => "tsd_idx"

  create_table "tapestry_statistic_file", :id => false, :force => true do |t|
    t.string   "statistic_id",            :limit => 16,                                  :null => false
    t.string   "statistic_file_id",       :limit => 16,                                  :null => false
    t.string   "file_path",               :limit => 1024,                                :null => false
    t.string   "action_ind",              :limit => 1,                                   :null => false
    t.integer  "file_sequence_number",    :limit => 10,   :precision => 10, :scale => 0
    t.string   "destination_string",      :limit => 30
    t.integer  "file_size_number",        :limit => 19,   :precision => 19, :scale => 0
    t.datetime "file_creation_date_time"
  end

  add_index "tapestry_statistic_file", ["file_sequence_number"], :name => "tsf_fsn", :tablespace => "indexes"
  add_index "tapestry_statistic_file", ["statistic_id"], :name => "tsf_idx"

# Could not dump table "tapestry_xml_queue" because of following StandardError
#   Unknown type 'XMLTYPE' for column 'user_data'

  create_table "tariff_model_area", :primary_key => "tariff_model_area_version_id", :force => true do |t|
    t.string   "tariff_model_area_code", :limit => 5,                                  :null => false
    t.string   "name",                   :limit => 30,                                 :null => false
    t.datetime "effective_date",                                                       :null => false
    t.string   "effective_status",       :limit => 6,                                  :null => false
    t.integer  "calculation_id",         :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.string   "customizable_indicator", :limit => 1,                                  :null => false
    t.string   "test_mode_ind",          :limit => 1,                                  :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                 :null => false
    t.datetime "audit_update_date_time",                                               :null => false
    t.integer  "update_number",          :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.string   "rate_plan_indicator",    :limit => 1,                                  :null => false
    t.string   "descriptive_text",       :limit => 360
    t.string   "comment_id",             :limit => 16
    t.string   "measure_unit_code",      :limit => 5
    t.integer  "tma_option_group_id",    :limit => 10,  :precision => 10, :scale => 0
    t.string   "service_coverage_code",  :limit => 5
    t.string   "zonal_coverage_code",    :limit => 5
    t.string   "tariff_week_code",       :limit => 5
    t.string   "tariff_tier_taper_code", :limit => 5
    t.string   "base_value_string",      :limit => 30
    t.string   "sensitivity_code",       :limit => 5
    t.string   "change_group_id",        :limit => 30
  end

  add_index "tariff_model_area", ["calculation_id"], :name => "tma1_cal_fk_i", :tablespace => "indexes"
  add_index "tariff_model_area", ["change_group_id"], :name => "tma_idx"
  add_index "tariff_model_area", ["measure_unit_code"], :name => "tma1_mu_fk_i", :tablespace => "indexes"
  add_index "tariff_model_area", ["service_coverage_code"], :name => "tma1_sc1_fk_i", :tablespace => "indexes"
  add_index "tariff_model_area", ["tariff_model_area_code"], :name => "tma1_ind1", :tablespace => "indexes"
  add_index "tariff_model_area", ["tariff_tier_taper_code"], :name => "tma1_ttt_fk_i", :tablespace => "indexes"
  add_index "tariff_model_area", ["tariff_week_code"], :name => "tma1_tw1_fk_i", :tablespace => "indexes"
  add_index "tariff_model_area", ["zonal_coverage_code"], :name => "tma1_zc1_fk_i", :tablespace => "indexes"

  create_table "tariff_model_entry", :id => false, :force => true do |t|
    t.string   "tariff_model_entry_id",        :limit => 16,                                :null => false
    t.string   "tariff_model_area_version_id", :limit => 16,                                :null => false
    t.string   "audit_update_user_id",         :limit => 15,                                :null => false
    t.datetime "audit_update_date_time",                                                    :null => false
    t.integer  "update_number",                :limit => 10, :precision => 10, :scale => 0, :null => false
    t.integer  "grid_row_number",              :limit => 10, :precision => 10, :scale => 0, :null => false
    t.string   "tariff_zone_code",             :limit => 5
    t.string   "tariff_time_code",             :limit => 5
    t.integer  "band_sequence",                :limit => 10, :precision => 10, :scale => 0
    t.string   "service_group_code",           :limit => 5
    t.string   "sdc_code",                     :limit => 5
    t.string   "billing_name_1",               :limit => 60
    t.string   "billing_name_2",               :limit => 60
  end

  add_index "tariff_model_entry", ["tariff_model_area_version_id", "grid_row_number"], :name => "tme_ind1", :tablespace => "indexes"
  add_index "tariff_model_entry", ["tariff_model_area_version_id"], :name => "tme_tma_fk_ind1", :tablespace => "indexes"

  create_table "tariff_tier_taper", :primary_key => "tariff_tier_taper_version_id", :force => true do |t|
    t.string   "tariff_tier_taper_code", :limit => 5,                                  :null => false
    t.datetime "effective_date",                                                       :null => false
    t.string   "effective_status",       :limit => 6,                                  :null => false
    t.string   "name",                   :limit => 30,                                 :null => false
    t.string   "billing_name_1",         :limit => 30,                                 :null => false
    t.string   "test_mode_ind",          :limit => 1,                                  :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                 :null => false
    t.datetime "audit_update_date_time",                                               :null => false
    t.integer  "update_number",          :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.string   "billing_name_2",         :limit => 30
    t.string   "descriptive_text",       :limit => 360
    t.string   "change_group_id",        :limit => 30
  end

  add_index "tariff_tier_taper", ["change_group_id"], :name => "ttt_idx"
  add_index "tariff_tier_taper", ["tariff_tier_taper_code", "effective_date"], :name => "ttt_ind1", :tablespace => "indexes"

  create_table "tariff_time", :id => false, :force => true do |t|
    t.string   "tariff_time_code",       :limit => 5,                                  :null => false
    t.string   "tariff_week_version_id", :limit => 16,                                 :null => false
    t.string   "color_rd",               :limit => 16,                                 :null => false
    t.string   "name",                   :limit => 30,                                 :null => false
    t.string   "billing_name_1",         :limit => 30,                                 :null => false
    t.string   "audit_update_user_id",   :limit => 15,                                 :null => false
    t.datetime "audit_update_date_time",                                               :null => false
    t.integer  "update_number",          :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.string   "billing_name_2",         :limit => 30
    t.string   "descriptive_text",       :limit => 360
  end

  add_index "tariff_time", ["tariff_week_version_id"], :name => "tte_idx"

