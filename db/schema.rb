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

ActiveRecord::Schema.define(:version => 20160524122926) do

  create_table "COURIER_SERVICEABLE_LOCATIONS", :id => false, :force => true do |t|
    t.string    "pin_code",               :limit => 16, :default => "",       :null => false
    t.string    "courier_code",           :limit => 6,                        :null => false
    t.string    "fulfillment_manager_id", :limit => 64,                       :null => false
    t.string    "status",                 :limit => 32, :default => "Active"
    t.boolean   "is24Hrs",                              :default => false
    t.boolean   "is_cod_available",                     :default => false
    t.string    "routing_code",           :limit => 32
    t.string    "created_by"
    t.timestamp "creation_date"
    t.string    "last_updated_by"
    t.timestamp "last_updated",                                               :null => false
  end

  add_index "COURIER_SERVICEABLE_LOCATIONS", ["is_cod_available"], :name => "is_cod_available"

  create_table "account_couriers", :force => true do |t|
    t.string   "name"
    t.string   "account_number"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.text     "cal_courier_info"
  end

  create_table "account_ledger_summaries", :force => true do |t|
    t.integer  "client_id"
    t.integer  "current_balance_in_cents", :default => 0, :null => false
    t.string   "created_by"
    t.string   "updated_by"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.integer  "account_holder_id",                       :null => false
    t.string   "account_holder_type",                     :null => false
  end

  add_index "account_ledger_summaries", ["client_id"], :name => "index_account_ledger_summaries_on_client_id", :unique => true

  create_table "account_ledgers", :force => true do |t|
    t.integer  "ledgerable_id",                           :null => false
    t.string   "ledgerable_type",                         :null => false
    t.integer  "amount_in_cents",          :default => 0, :null => false
    t.integer  "client_id"
    t.integer  "running_balance_in_cents", :default => 0, :null => false
    t.string   "created_by"
    t.string   "updated_by"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.string   "account_nature",                          :null => false
    t.integer  "account_holder_id",                       :null => false
    t.string   "account_holder_type",                     :null => false
  end

  add_index "account_ledgers", ["ledgerable_id", "ledgerable_type"], :name => "index_account_ledgers_on_ledgerable_id_and_ledgerable_type", :unique => true

  create_table "addresses", :force => true do |t|
    t.string   "name"
    t.text     "address1"
    t.text     "address2"
    t.string   "city"
    t.string   "zip"
    t.string   "state"
    t.string   "country"
    t.string   "mobile"
    t.string   "landline"
    t.string   "email"
    t.string   "created_by"
    t.string   "updated_by"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "alerters", :force => true do |t|
    t.integer  "alertable_id",       :null => false
    t.string   "alertable_type",     :null => false
    t.integer  "user_id"
    t.string   "message"
    t.datetime "last_alert_time"
    t.integer  "on_hold_days"
    t.boolean  "is_task_finished"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "alert_type"
    t.text     "additional_details"
  end

  add_index "alerters", ["alertable_id", "alertable_type"], :name => "index_alerters_on_alertable_id_and_alertable_type"

  create_table "api_keys", :force => true do |t|
    t.string  "access_token"
    t.integer "client_id"
  end

  add_index "api_keys", ["access_token"], :name => "index_api_keys_on_access_token"
  add_index "api_keys", ["client_id"], :name => "index_api_keys_on_client_id", :unique => true

  create_table "attachments", :force => true do |t|
    t.string   "file_location"
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.string   "details"
    t.string   "created_by"
    t.string   "updated_by"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "awb_generation_requests", :force => true do |t|
    t.integer  "package_id"
    t.string   "client_tax_number"
    t.integer  "client_id"
    t.integer  "weight"
    t.integer  "source_address_id"
    t.integer  "destination_address_id"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.string   "courier_awb"
    t.integer  "caller_courier_relation_id"
    t.integer  "warehouse_id"
  end

  create_table "awb_generator_callers", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "awb_pools", :force => true do |t|
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.string   "awb_number"
    t.integer  "caller_courier_relation_id"
    t.boolean  "is_used"
    t.boolean  "is_cod"
    t.string   "zone_code"
  end

  add_index "awb_pools", ["caller_courier_relation_id"], :name => "index_awb_pools_on_caller_courier_relation_id"

  create_table "bill_plan_histories", :force => true do |t|
    t.integer  "bill_plan_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "client_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "bill_plans", :force => true do |t|
    t.string   "name"
    t.string   "currency_code",               :limit => 3, :default => "INR"
    t.integer  "rate_plan_id"
    t.datetime "created_at",                                                  :null => false
    t.datetime "updated_at",                                                  :null => false
    t.date     "start_date",                                                  :null => false
    t.date     "end_date",                                                    :null => false
    t.string   "octroi_bill_plan_type"
    t.string   "billable_plan_type",                                          :null => false
    t.string   "billable_type",                                               :null => false
    t.integer  "billable_id",                                                 :null => false
    t.integer  "surface_rate_plan_id"
    t.integer  "return_air_rate_plan_id"
    t.integer  "return_surface_rate_plan_id"
  end

  create_table "billable_courier_shipments", :force => true do |t|
    t.string   "pickup_zip"
    t.string   "pickup_city"
    t.string   "pickup_state"
    t.string   "destination_zip"
    t.string   "destination_city"
    t.string   "destination_state"
    t.boolean  "is_cod"
    t.integer  "cod_amount_in_cents",                   :default => 0
    t.integer  "order_value_in_cents",                  :default => 0
    t.float    "weight"
    t.string   "courier_awb"
    t.string   "caller_reference_number"
    t.string   "caller"
    t.datetime "created_at",                                               :null => false
    t.datetime "updated_at",                                               :null => false
    t.integer  "estimated_cost_in_cents",               :default => 0
    t.string   "mapped_zone"
    t.string   "shipment_type"
    t.string   "shipment_mode"
    t.string   "product_category"
    t.text     "cal_response"
    t.string   "courier_code"
    t.integer  "estimated_cost_exclusive_tax_in_cents"
    t.float    "length_in_inch"
    t.float    "breadth_in_inch"
    t.float    "height_in_inch"
    t.string   "product_details"
    t.boolean  "is_mis_uploaded",                       :default => false
    t.text     "lbh_in_inch"
    t.float    "volume_in_cubic_feet"
    t.integer  "package_count"
    t.boolean  "is_insured"
  end

  add_index "billable_courier_shipments", ["caller_reference_number"], :name => "index_billable_courier_shipments_on_caller_reference_number"
  add_index "billable_courier_shipments", ["courier_awb"], :name => "index_billable_courier_shipments_on_courier_awb"
  add_index "billable_courier_shipments", ["courier_code"], :name => "index_billable_courier_shipments_on_courier_code"
  add_index "billable_courier_shipments", ["created_at"], :name => "index_billable_courier_shipments_on_created_at"
  add_index "billable_courier_shipments", ["shipment_type"], :name => "index_billable_courier_shipments_on_shipment_type"

  create_table "billable_shipments", :force => true do |t|
    t.integer  "package_id"
    t.integer  "awb_generation_request_id"
    t.string   "shipment_type"
    t.string   "courier_awb"
    t.integer  "client_id"
    t.integer  "courier_id"
    t.boolean  "is_settled",                :default => false
    t.datetime "shipped_at"
    t.string   "created_by"
    t.string   "updated_by"
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
    t.integer  "pickup_address_id",                            :null => false
    t.integer  "destination_address_id",                       :null => false
    t.boolean  "is_cod",                    :default => false, :null => false
    t.integer  "cod_amount_in_cents",       :default => 0,     :null => false
    t.integer  "order_value_in_cents",      :default => 0,     :null => false
    t.float    "billable_weight"
    t.integer  "bill_plan_id"
    t.integer  "courier_bill_plan_id"
    t.integer  "estimated_cost_in_cents",   :default => 0,     :null => false
    t.string   "shipment_mode",                                :null => false
    t.string   "status"
  end

  add_index "billable_shipments", ["courier_awb"], :name => "index_billable_shipments_on_courier_awb", :unique => true
  add_index "billable_shipments", ["status", "client_id"], :name => "index_billable_shipments_on_status_and_client_id"

  create_table "cal_invoice_items", :force => true do |t|
    t.integer  "courier_id"
    t.integer  "freight_charge_in_cents",                     :default => 0, :null => false
    t.integer  "fuel_surcharge_in_cents",                     :default => 0, :null => false
    t.integer  "cod_charge_in_cents",                         :default => 0, :null => false
    t.integer  "total_cost_in_cents",                         :default => 0, :null => false
    t.string   "created_by"
    t.string   "updated_by"
    t.datetime "created_at",                                                 :null => false
    t.datetime "updated_at",                                                 :null => false
    t.integer  "mapped_zone"
    t.integer  "full_liability_insurance_charge_in_cents",    :default => 0, :null => false
    t.integer  "limited_liability_insurance_charge_in_cents", :default => 0, :null => false
    t.integer  "pod_charge_in_cents",                         :default => 0, :null => false
    t.integer  "billable_shipment_id",                                       :null => false
  end

  create_table "caller_courier_relations", :force => true do |t|
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.integer  "caller_id"
    t.integer  "courier_id"
    t.text     "account_info"
    t.boolean  "is_awb_cod_specific"
  end

  create_table "charge_details", :force => true do |t|
    t.integer  "chargeable_id"
    t.string   "chargeable_type"
    t.string   "charge_type",     :null => false
    t.integer  "charge_in_cents", :null => false
    t.string   "created_by"
    t.string   "updated_by"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "charge_details", ["chargeable_id", "chargeable_type", "charge_type"], :name => "unique_key", :unique => true
  add_index "charge_details", ["chargeable_id", "chargeable_type"], :name => "index_charge_details_on_chargeable_id_and_chargeable_type"

  create_table "charge_names", :force => true do |t|
    t.string   "charge_name"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "client_courier_relations", :force => true do |t|
    t.integer  "client_id"
    t.integer  "courier_id"
    t.string   "cod_account_number"
    t.string   "non_cod_account_number"
    t.boolean  "is_active"
    t.string   "created_by"
    t.string   "updated_by"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.string   "pool_zone_code"
    t.integer  "warehouse_id",           :null => false
  end

  add_index "client_courier_relations", ["client_id", "courier_id", "warehouse_id"], :name => "uniqueness", :unique => true
  add_index "client_courier_relations", ["warehouse_id"], :name => "index_client_courier_relations_on_warehouse_id"

  create_table "client_service_codes", :force => true do |t|
    t.string   "service_code",                   :null => false
    t.integer  "client_id",                      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",       :default => true
  end

  add_index "client_service_codes", ["client_id", "service_code"], :name => "index_client_service_codes_on_client_id_and_service_code", :unique => true

  create_table "clients", :force => true do |t|
    t.string   "name"
    t.boolean  "is_active",                   :default => true
    t.integer  "billing_address_id"
    t.integer  "warehouse_address_id"
    t.string   "client_tin_number"
    t.string   "created_by"
    t.string   "updated_by"
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
    t.string   "service_code"
    t.string   "client_code"
    t.string   "insurance_type"
    t.integer  "billing_cycle_days",                             :null => false
    t.integer  "octroi_billing_cycle_days",                      :null => false
    t.integer  "credit_limit_in_cents",       :default => 0,     :null => false
    t.boolean  "cod_enabled"
    t.boolean  "is_invoice_printing_enabled", :default => false
    t.boolean  "can_add_packages",            :default => false
    t.boolean  "is_invoicing_enabled",        :default => true
    t.boolean  "is_bulk_printing_enabled",    :default => false
    t.string   "custom_id"
    t.boolean  "package_privacy",             :default => false
  end

  add_index "clients", ["client_code"], :name => "index_clients_on_client_code", :unique => true

  create_table "cod_payables", :force => true do |t|
    t.integer  "package_id",                                  :null => false
    t.integer  "courier_id",                                  :null => false
    t.string   "courier_awb",                                 :null => false
    t.string   "reference_number",                            :null => false
    t.integer  "cod_amount_in_cents",                         :null => false
    t.integer  "cod_amount_received_in_cents", :default => 0, :null => false
    t.integer  "settled_cod_amount_in_cents",  :default => 0, :null => false
    t.integer  "client_id",                                   :null => false
    t.string   "ibl_status"
    t.string   "created_by"
    t.string   "updated_by"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
    t.string   "status"
    t.string   "cod_courier_code"
    t.integer  "confirmed_amount_in_cents",    :default => 0
  end

  add_index "cod_payables", ["package_id"], :name => "index_cod_payables_on_package_id", :unique => true

  create_table "cod_payment_advice_items", :force => true do |t|
    t.integer  "cod_payment_advice_id", :null => false
    t.integer  "cod_payable_id",        :null => false
    t.integer  "amount_in_cents",       :null => false
    t.string   "created_by"
    t.string   "updated_by"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.text     "payment_details"
  end

  add_index "cod_payment_advice_items", ["cod_payable_id"], :name => "index_cod_payment_advice_items_on_cod_payable_id"
  add_index "cod_payment_advice_items", ["cod_payment_advice_id"], :name => "index_cod_payment_advice_items_on_cod_payment_advice_id"

  create_table "cod_payment_advices", :force => true do |t|
    t.string   "reference_number",                       :null => false
    t.integer  "client_id",                              :null => false
    t.string   "status",                                 :null => false
    t.integer  "amount_in_cents",                        :null => false
    t.integer  "due_amount_in_cents",                    :null => false
    t.string   "description",                            :null => false
    t.boolean  "is_settled",          :default => false, :null => false
    t.string   "created_by"
    t.string   "updated_by"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  create_table "cod_receiveds", :force => true do |t|
    t.string   "payment_reference_number"
    t.integer  "courier_id",               :null => false
    t.integer  "amount_in_cents",          :null => false
    t.string   "bank_name"
    t.string   "bank_location"
    t.string   "uploaded_file_path"
    t.string   "created_by"
    t.string   "updated_by"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "comments", :force => true do |t|
    t.text     "comment"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.string   "created_by"
    t.datetime "created_at"
  end

  create_table "courier_contact_client_courier_relation_maps", :force => true do |t|
    t.integer  "courier_contact_id"
    t.integer  "client_courier_relation_id"
    t.string   "created_by"
    t.string   "updated_by"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  add_index "courier_contact_client_courier_relation_maps", ["client_courier_relation_id", "courier_contact_id"], :name => "uniqueness", :unique => true

  create_table "courier_contacts", :force => true do |t|
    t.integer  "courier_id"
    t.string   "name"
    t.string   "email_id"
    t.string   "contact_no"
    t.string   "created_by"
    t.string   "updated_by"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "courier_invoice_items", :force => true do |t|
    t.string   "courier_invoice_id",                :null => false
    t.string   "courier_awb",                       :null => false
    t.string   "reference_number"
    t.integer  "billable_courier_shipment_id"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.text     "invoice_item_info"
    t.integer  "total_cost_exclusive_tax_in_cents"
    t.string   "awb_type"
    t.string   "parent_awb"
    t.integer  "total_cost_inclusive_tax_in_cents"
    t.float    "chargeable_weight_in_kg"
    t.text     "cost_with_courier_supplied_weight"
    t.float    "actual_weight_in_kg"
  end

  add_index "courier_invoice_items", ["billable_courier_shipment_id"], :name => "index_courier_invoice_items_on_billable_courier_shipment_id", :unique => true
  add_index "courier_invoice_items", ["courier_awb", "awb_type"], :name => "index_courier_invoice_items_on_courier_awb_and_awb_type", :unique => true
  add_index "courier_invoice_items", ["courier_invoice_id"], :name => "index_courier_invoice_items_on_courier_invoice_id"
  add_index "courier_invoice_items", ["reference_number"], :name => "index_courier_invoice_items_on_reference_number"

  create_table "courier_invoices", :force => true do |t|
    t.integer  "account_courier_id",                              :null => false
    t.string   "status",                                          :null => false
    t.string   "invoice_number",                                  :null => false
    t.date     "invoice_date",                                    :null => false
    t.date     "due_date",                                        :null => false
    t.string   "account_number"
    t.integer  "total_freight_charge_in_cents",    :default => 0
    t.integer  "total_fuel_surcharge_in_cents",    :default => 0
    t.integer  "total_cod_charge_in_cents",        :default => 0
    t.integer  "total_ess_charge_in_cents",        :default => 0
    t.integer  "total_discount_in_cents",          :default => 0
    t.integer  "total_adjustment_factor_in_cents", :default => 0
    t.integer  "total_tax_in_cents",               :default => 0
    t.integer  "total_count",                      :default => 0
    t.string   "created_by"
    t.string   "updated_by"
    t.datetime "created_at",                                      :null => false
    t.datetime "updated_at",                                      :null => false
    t.integer  "total_cost_in_cents",              :default => 0
    t.integer  "volume_discount_in_cents",         :default => 0, :null => false
    t.integer  "insurance_charge_in_cents",        :default => 0, :null => false
    t.integer  "unsettled_amount_in_cents",        :default => 0
    t.integer  "rov_charge_in_cents",              :default => 0
  end

  create_table "courier_mis", :force => true do |t|
    t.float    "actual_weight"
    t.string   "courier_awb"
    t.string   "reference_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "chargeable_weight"
    t.string   "awb_type"
    t.datetime "bcs_date"
    t.boolean  "is_auto_uploaded",  :default => false
  end

  add_index "courier_mis", ["courier_awb", "reference_number"], :name => "index_courier_mis_on_courier_awb_and_reference_number", :unique => true
  add_index "courier_mis", ["courier_awb"], :name => "index_courier_mis_on_courier_awb"

  create_table "courier_mis_histories", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "courier_awb"
    t.string   "reference_number"
    t.float    "actual_weight"
    t.integer  "courier_mis_id"
    t.float    "chargeable_weight"
    t.string   "awb_type"
    t.string   "file_path"
  end

  create_table "courier_octroi_invoice_items", :force => true do |t|
    t.string   "courier_awb",                                       :null => false
    t.integer  "billable_shipment_id",                              :null => false
    t.datetime "shipment_date"
    t.integer  "package_id"
    t.integer  "octroi_tax_in_cents",            :default => 0,     :null => false
    t.integer  "octroi_service_charge_in_cents", :default => 0,     :null => false
    t.integer  "octroi_service_tax_in_cents",    :default => 0,     :null => false
    t.integer  "total_octroi_amount_in_cents",   :default => 0,     :null => false
    t.datetime "created_at",                                        :null => false
    t.datetime "updated_at",                                        :null => false
    t.integer  "courier_octroi_invoice_id"
    t.float    "chargeable_weight"
    t.boolean  "is_processed",                   :default => false
    t.boolean  "is_erroneous",                   :default => true
  end

  add_index "courier_octroi_invoice_items", ["billable_shipment_id"], :name => "index_courier_octroi_invoice_items_on_billable_shipment_id"
  add_index "courier_octroi_invoice_items", ["courier_awb"], :name => "index_courier_octroi_invoice_items_on_courier_awb"
  add_index "courier_octroi_invoice_items", ["package_id"], :name => "index_courier_octroi_invoice_items_on_package_id"

  create_table "courier_octroi_invoices", :force => true do |t|
    t.string   "courier_octroi_invoice_number",                       :null => false
    t.integer  "courier_id",                                          :null => false
    t.datetime "invoice_date",                                        :null => false
    t.datetime "due_date",                                            :null => false
    t.integer  "total_octroi_tax_in_cents",            :default => 0, :null => false
    t.integer  "total_octroi_service_charge_in_cents", :default => 0, :null => false
    t.integer  "total_octroi_service_tax_in_cents",    :default => 0, :null => false
    t.integer  "invoice_amount_in_cents",              :default => 0, :null => false
    t.string   "updated_by"
    t.string   "created_by"
    t.datetime "created_at",                                          :null => false
    t.datetime "updated_at",                                          :null => false
    t.integer  "item_count",                           :default => 0, :null => false
    t.integer  "primary_education_cess_in_cents",      :default => 0
    t.integer  "secondary_education_cess_in_cents",    :default => 0
  end

  add_index "courier_octroi_invoices", ["courier_id"], :name => "index_courier_octroi_invoices_on_courier_id"
  add_index "courier_octroi_invoices", ["courier_octroi_invoice_number"], :name => "index_courier_octroi_invoices_on_courier_octroi_invoice_number"

  create_table "couriers", :force => true do |t|
    t.string   "name"
    t.string   "contact_number"
    t.string   "image_url"
    t.string   "track_url"
    t.boolean  "is_active"
    t.string   "courier_code_for_awb_generation"
    t.string   "courier_code_for_tracking"
    t.string   "created_by"
    t.string   "updated_by"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.boolean  "is_awb_generation_api_available"
    t.integer  "account_courier_id"
    t.string   "cod_courier_code"
    t.string   "courier_code",                    :null => false
  end

  add_index "couriers", ["courier_code_for_awb_generation"], :name => "index_couriers_on_courier_code_for_awb_generation"
  add_index "couriers", ["courier_code_for_tracking"], :name => "index_couriers_on_courier_code_for_tracking"

  create_table "cron_job_schedulers", :force => true do |t|
    t.string   "cron_name"
    t.string   "time_to_run"
    t.string   "created_by"
    t.string   "updated_by"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0, :null => false
    t.integer  "attempts",   :default => 0, :null => false
    t.text     "handler",                   :null => false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "dispute_users", :force => true do |t|
    t.integer  "user_id",        :null => false
    t.string   "dispute_client"
    t.string   "zone"
    t.string   "created_by"
    t.string   "updated_by"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "disputes", :force => true do |t|
    t.integer  "disputable_id"
    t.string   "disputable_type"
    t.string   "disputable_url"
    t.string   "zone"
    t.string   "max_value_in_cents"
    t.text     "possible_loss_bearers"
    t.string   "dispute_user"
    t.string   "dispute_type"
    t.string   "details"
    t.string   "status"
    t.integer  "settlement_proof_id"
    t.string   "created_by"
    t.string   "updated_by"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  create_table "instrument_ledger_mappings", :force => true do |t|
    t.integer  "credit_instrument_ledger_id",                :null => false
    t.integer  "debit_instrument_ledger_id",                 :null => false
    t.integer  "amount_in_cents",             :default => 0, :null => false
    t.string   "created_by"
    t.string   "updated_by"
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
  end

  add_index "instrument_ledger_mappings", ["credit_instrument_ledger_id"], :name => "index_instrument_ledger_mappings_on_from_instrument_ledger_id"
  add_index "instrument_ledger_mappings", ["debit_instrument_ledger_id"], :name => "index_instrument_ledger_mappings_on_to_instrument_ledger_id"

  create_table "instrument_ledgers", :force => true do |t|
    t.integer  "client_id"
    t.integer  "instrument_id",                                :null => false
    t.string   "instrument_type",                              :null => false
    t.integer  "amount_in_cents",                              :null => false
    t.integer  "unmapped_amount_in_cents", :default => 0,      :null => false
    t.boolean  "is_settled",               :default => false
    t.string   "created_by"
    t.string   "updated_by"
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
    t.string   "instrument_nature",        :default => "null"
    t.string   "reference_number",                             :null => false
    t.integer  "account_holder_id",                            :null => false
    t.string   "account_holder_type",                          :null => false
  end

  add_index "instrument_ledgers", ["client_id"], :name => "index_instrument_ledgers_on_client_id"
  add_index "instrument_ledgers", ["id", "instrument_nature"], :name => "index_instrument_ledgers_on_id_and_instrument_nature"
  add_index "instrument_ledgers", ["instrument_id", "instrument_type"], :name => "index_instrument_ledgers_on_instrument_id_and_instrument_type"

  create_table "invoice_items", :force => true do |t|
    t.integer  "client_id",             :null => false
    t.integer  "invoice_id"
    t.integer  "billable_id",           :null => false
    t.string   "billable_type",         :null => false
    t.integer  "total_charge_in_cents", :null => false
    t.string   "created_by"
    t.string   "updated_by"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.integer  "bill_plan_id",          :null => false
    t.string   "mapped_zone"
  end

  add_index "invoice_items", ["billable_id", "billable_type", "client_id"], :name => "billable_id_billable_type_client_id"
  add_index "invoice_items", ["billable_id", "billable_type"], :name => "index_invoice_items_on_billable_id_and_billable_type", :unique => true
  add_index "invoice_items", ["invoice_id"], :name => "index_invoice_items_on_invoice_id"

  create_table "invoices", :force => true do |t|
    t.integer  "client_id",                              :null => false
    t.string   "invoice_number",                         :null => false
    t.date     "invoice_date"
    t.date     "due_date"
    t.integer  "amount_in_cents",                        :null => false
    t.integer  "due_amount_in_cents",                    :null => false
    t.boolean  "is_paid",             :default => false
    t.string   "created_by"
    t.string   "updated_by"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "status",                                 :null => false
  end

  add_index "invoices", ["client_id"], :name => "index_invoices_on_client_id"
  add_index "invoices", ["invoice_number"], :name => "index_invoices_on_invoice_number", :unique => true

  create_table "loss_bearers", :force => true do |t|
    t.integer  "dispute_id"
    t.string   "loss_bearer_type"
    t.string   "loss_bearer_name"
    t.integer  "amount_in_cents"
    t.text     "comment"
    t.string   "created_by"
    t.string   "updated_by"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "manifest_items", :force => true do |t|
    t.integer  "manifest_id", :null => false
    t.integer  "package_id",  :null => false
    t.string   "courier_awb"
    t.string   "status"
    t.string   "created_by"
    t.string   "updated_by"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "manifest_items", ["manifest_id"], :name => "index_manifest_items_on_manifest_id"
  add_index "manifest_items", ["status"], :name => "index_manifest_items_on_status"

  create_table "manifests", :force => true do |t|
    t.integer  "client_id",       :null => false
    t.integer  "courier_id",      :null => false
    t.string   "status"
    t.string   "created_by"
    t.string   "updated_by"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "warehouse_id"
    t.string   "pickup_man_info"
    t.datetime "pickup_time"
  end

  add_index "manifests", ["client_id", "status", "warehouse_id"], :name => "index_manifests_on_client_id_and_status_and_warehouse_id"
  add_index "manifests", ["client_id"], :name => "index_manifests_on_client_id"
  add_index "manifests", ["courier_id"], :name => "index_manifests_on_courier_id"
  add_index "manifests", ["status"], :name => "index_manifests_on_status"

  create_table "ndr_histories", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "courier_awb"
    t.string   "status"
    t.string   "ndr_report_id"
    t.string   "courier_code"
    t.string   "file_path"
    t.date     "upload_date"
  end

  create_table "ndr_reports", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "courier_awb"
    t.string   "status"
    t.string   "courier_code"
    t.date     "upload_date"
    t.string   "shipment_mode"
    t.datetime "courier_updated_at"
  end

  add_index "ndr_reports", ["courier_awb"], :name => "index_ndr_reports_on_courier_awb"
  add_index "ndr_reports", ["courier_code", "upload_date"], :name => "dashboard_grp_key"

  create_table "note_items", :force => true do |t|
    t.integer  "reference_id",                   :null => false
    t.string   "reference_type"
    t.integer  "note_id",                        :null => false
    t.string   "created_by"
    t.string   "updated_by"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "amount_in_cents", :default => 0
    t.string   "description"
    t.string   "courier_awb",                    :null => false
  end

  add_index "note_items", ["note_id"], :name => "index_note_items_on_note_id"
  add_index "note_items", ["reference_id", "reference_type"], :name => "index_note_items_on_reference_id_and_reference_type"

  create_table "notes", :force => true do |t|
    t.string   "note_type",                 :null => false
    t.integer  "amount_in_cents",           :null => false
    t.integer  "unsettled_amount_in_cents", :null => false
    t.string   "note_number",               :null => false
    t.integer  "client_id"
    t.string   "description"
    t.string   "created_by"
    t.string   "updated_by"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "account_holder_id",         :null => false
    t.string   "account_holder_type",       :null => false
    t.string   "status"
  end

  add_index "notes", ["client_id"], :name => "index_notes_on_client_id"

  create_table "octroi_invoice_items", :force => true do |t|
    t.integer  "courier_octroi_invoice_item_id"
    t.integer  "client_id",                      :null => false
    t.integer  "octroi_invoice_id"
    t.integer  "bill_plan_id",                   :null => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "amount_in_cents",                :null => false
  end

  add_index "octroi_invoice_items", ["client_id"], :name => "index_octroi_invoice_items_on_client_id"
  add_index "octroi_invoice_items", ["courier_octroi_invoice_item_id"], :name => "index_octroi_invoice_items_on_courier_octroi_invoice_item_id"
  add_index "octroi_invoice_items", ["octroi_invoice_id"], :name => "index_octroi_invoice_items_on_octroi_invoice_id"

  create_table "octroi_invoices", :force => true do |t|
    t.string   "invoice_number",      :null => false
    t.integer  "client_id",           :null => false
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.datetime "invoice_date"
    t.datetime "due_date"
    t.integer  "amount_in_cents"
    t.string   "status"
    t.integer  "due_amount_in_cents", :null => false
  end

  add_index "octroi_invoices", ["client_id"], :name => "index_octroi_invoices_on_client_id"

  create_table "packages", :force => true do |t|
    t.string   "external_id"
    t.string   "awb_number"
    t.integer  "address_id"
    t.boolean  "is_cod",                      :default => false
    t.integer  "cod_amount_in_cents",         :default => 0
    t.string   "status"
    t.float    "weight"
    t.string   "product_category"
    t.text     "notes"
    t.integer  "client_id"
    t.integer  "courier_id"
    t.string   "courier_awb"
    t.datetime "last_leeched_at"
    t.string   "last_leeched_courier_status"
    t.datetime "delivery_date"
    t.integer  "order_value_in_cents",        :default => 0
    t.string   "item_details"
    t.integer  "item_count"
    t.string   "client_tin_number"
    t.string   "shipment_mode"
    t.datetime "tracking_history_updated_at"
    t.string   "created_by"
    t.string   "updated_by"
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
    t.datetime "shipped_at"
    t.float    "courier_weight"
    t.string   "return_courier_awb"
    t.integer  "client_service_code_id"
    t.integer  "warehouse_id"
    t.text     "comment"
    t.integer  "mother_package_id"
    t.integer  "dispute_id"
  end

  add_index "packages", ["awb_number"], :name => "index_packages_on_awb_number"
  add_index "packages", ["client_id", "status"], :name => "index_packages_on_client_id_and_status"
  add_index "packages", ["client_id"], :name => "index_packages_on_client_id"
  add_index "packages", ["courier_awb"], :name => "index_packages_on_courier_awb"
  add_index "packages", ["courier_id"], :name => "index_packages_on_courier_id"
  add_index "packages", ["external_id"], :name => "index_packages_on_external_id"
  add_index "packages", ["mother_package_id"], :name => "index_packages_on_mother_package_id"
  add_index "packages", ["status"], :name => "index_packages_on_status"

  create_table "payments", :force => true do |t|
    t.integer  "client_id"
    t.string   "payment_type",              :null => false
    t.integer  "amount_in_cents",           :null => false
    t.string   "currency_code",             :null => false
    t.string   "payment_mode",              :null => false
    t.date     "payment_date",              :null => false
    t.string   "reference_number",          :null => false
    t.string   "bank_name"
    t.string   "bank_location"
    t.string   "created_by"
    t.string   "updated_by"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "unsettled_amount_in_cents", :null => false
    t.string   "description",               :null => false
    t.integer  "account_holder_id",         :null => false
    t.string   "account_holder_type",       :null => false
  end

  add_index "payments", ["client_id", "payment_type"], :name => "index_payments_on_client_id_and_payment_type"

  create_table "pickup_initiator_comments", :force => true do |t|
    t.text     "comment"
    t.integer  "pickup_initiator_id"
    t.integer  "user_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "pickup_initiator_comments", ["pickup_initiator_id"], :name => "index_pickup_initiator_comments_on_pickup_initiator_id"

  create_table "pickup_initiators", :force => true do |t|
    t.integer  "courier_id",   :null => false
    t.integer  "client_id",    :null => false
    t.datetime "pickup_time",  :null => false
    t.string   "status",       :null => false
    t.integer  "count",        :null => false
    t.string   "created_by"
    t.string   "updated_by"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.float    "total_weight"
    t.integer  "warehouse_id"
    t.integer  "manifest_id"
  end

  add_index "pickup_initiators", ["client_id"], :name => "index_pickup_initiators_on_client_id"
  add_index "pickup_initiators", ["manifest_id"], :name => "index_pickup_initiators_on_manifest_id"
  add_index "pickup_initiators", ["pickup_time"], :name => "index_pickup_initiators_on_pickup_time"
  add_index "pickup_initiators", ["status"], :name => "index_pickup_initiators_on_status"

  create_table "pickup_requests", :force => true do |t|
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.integer  "client_id"
    t.string   "client_tax_number"
    t.integer  "caller_courier_relation_id"
    t.integer  "number_of_packages"
  end

  create_table "rate_plan_charges", :force => true do |t|
    t.integer  "rate_plan_id"
    t.string   "charge_name",           :null => false
    t.string   "charge_type"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.string   "mapped_zone"
    t.string   "slab_attr"
    t.string   "rate_plan_charge_type", :null => false
  end

  create_table "rate_plan_items", :force => true do |t|
    t.string   "formula",                                :null => false
    t.string   "mapped_zone"
    t.integer  "slab_value",                             :null => false
    t.integer  "fixed_rate_in_cents", :default => 0,     :null => false
    t.float    "percent_rate",        :default => 0.0,   :null => false
    t.boolean  "is_additional_slab",  :default => false, :null => false
    t.string   "created_by"
    t.string   "updated_by"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.integer  "rate_plan_charge_id",                    :null => false
  end

  create_table "rate_plans", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",                                                          :null => false
    t.datetime "updated_at",                                                          :null => false
    t.string   "rate_plan_type",                                                      :null => false
    t.decimal  "management_commission", :precision => 10, :scale => 0, :default => 0
  end

  create_table "report_upload_statuses", :force => true do |t|
    t.string "courier_code"
    t.date   "upload_date"
  end

  create_table "roles", :force => true do |t|
    t.string   "role"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "service_codes", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "service_codes", ["name"], :name => "index_service_codes_on_name", :unique => true

  create_table "shipping_agents", :force => true do |t|
    t.string   "display_name"
    t.string   "code"
    t.string   "html_validation_status"
    t.string   "debug_json_output"
    t.string   "delivery_checker_method"
    t.string   "last_delivered_tracking_number"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "state_events", :force => true do |t|
    t.integer  "stateful_id"
    t.string   "stateful_type"
    t.string   "previous_state"
    t.string   "current_state"
    t.string   "event"
    t.boolean  "is_active",      :default => true
    t.string   "created_by"
    t.string   "updated_by"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  add_index "state_events", ["created_at"], :name => "index_state_events_on_created_at"
  add_index "state_events", ["stateful_type"], :name => "index_state_events_on_stateful_type"

  create_table "third_party_request_responses", :force => true do |t|
    t.integer  "awb_generation_request_id"
    t.integer  "package_id"
    t.integer  "courier_id"
    t.string   "status"
    t.text     "response"
    t.text     "request_body"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.boolean  "response_state"
    t.integer  "request_id"
    t.string   "request_type"
  end

  create_table "ticket_assignment_attrs", :force => true do |t|
    t.integer "ticket_client_id"
    t.string  "attr_1"
    t.string  "attr_2"
    t.string  "attr_3"
    t.string  "attr_4"
    t.string  "attr_5"
    t.string  "attr_6"
  end

  add_index "ticket_assignment_attrs", ["ticket_client_id"], :name => "index_ticket_assignment_attrs_on_ticket_client_id"

  create_table "ticket_assignment_rules", :force => true do |t|
    t.string   "attr_1",           :limit => 128
    t.string   "attr_2",           :limit => 128
    t.string   "attr_3",           :limit => 128
    t.string   "attr_4",           :limit => 128
    t.string   "attr_5",           :limit => 128
    t.string   "attr_6",           :limit => 128
    t.integer  "team_id"
    t.boolean  "is_active",                       :default => true
    t.string   "ticketable_type"
    t.string   "created_by"
    t.string   "updated_by"
    t.datetime "created_at",                                        :null => false
    t.datetime "updated_at",                                        :null => false
    t.integer  "ticket_client_id"
    t.string   "client"
    t.string   "ticket_type"
    t.integer  "priority"
  end

  add_index "ticket_assignment_rules", ["is_active", "client", "ticket_type", "ticketable_type", "attr_1", "attr_2"], :name => "assignment_key"
  add_index "ticket_assignment_rules", ["is_active"], :name => "index_ticket_assignment_rules_on_is_active"

  create_table "ticket_attachments", :force => true do |t|
    t.string   "data_file_name", :null => false
    t.integer  "ticket_id"
    t.string   "created_by"
    t.string   "details"
    t.datetime "created_at"
  end

  add_index "ticket_attachments", ["ticket_id"], :name => "index_ticket_attachments_on_ticket_id"

  create_table "ticket_attribute_parameter_mappings", :force => true do |t|
    t.string "ticketable_type"
    t.string "attr_name"
    t.string "parameter_name"
  end

  add_index "ticket_attribute_parameter_mappings", ["ticketable_type", "attr_name"], :name => "uniq1", :unique => true
  add_index "ticket_attribute_parameter_mappings", ["ticketable_type", "parameter_name"], :name => "uniq2", :unique => true

  create_table "ticket_clients", :force => true do |t|
    t.string "client_name"
    t.string "created_by"
    t.string "updated_by"
  end

  create_table "ticket_comments", :force => true do |t|
    t.text     "comment"
    t.integer  "ticket_id"
    t.string   "created_by"
    t.string   "updated_by"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "ticket_comments", ["ticket_id"], :name => "index_ticket_comments_on_ticket_id"

  create_table "ticket_teams", :force => true do |t|
    t.string   "name"
    t.boolean  "is_active"
    t.boolean  "is_external"
    t.string   "created_by"
    t.string   "updated_by"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "ticket_client_id"
  end

  create_table "ticket_teams_ticket_users", :id => false, :force => true do |t|
    t.integer "ticket_team_id"
    t.integer "ticket_user_id"
  end

  create_table "ticket_types", :force => true do |t|
    t.string  "ticket_category"
    t.string  "ticket_type"
    t.boolean "is_active"
  end

  create_table "ticket_users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.boolean  "is_active"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "ticket_client_id"
  end

  create_table "ticket_value_configs", :force => true do |t|
    t.integer "ticket_client_id"
    t.string  "attr_name"
    t.string  "value"
  end

  add_index "ticket_value_configs", ["ticket_client_id", "attr_name"], :name => "config_key"

  create_table "tickets", :force => true do |t|
    t.integer  "ticketable_id"
    t.string   "ticketable_type"
    t.string   "reference_id"
    t.text     "details"
    t.string   "status"
    t.integer  "ticket_type_id"
    t.integer  "current_owner_id"
    t.integer  "external_ticket_user_id"
    t.integer  "external_ticket_team_id"
    t.integer  "assigned_ticket_team_id"
    t.integer  "assigned_ticket_user_id"
    t.integer  "creator_id"
    t.string   "client"
    t.string   "resolve_code"
    t.string   "priority"
    t.integer  "sla"
    t.string   "attr_1",                  :limit => 128
    t.string   "attr_2",                  :limit => 128
    t.string   "attr_3",                  :limit => 128
    t.string   "attr_4",                  :limit => 128
    t.string   "attr_5",                  :limit => 128
    t.string   "attr_6",                  :limit => 128
    t.string   "created_by"
    t.string   "updated_by"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.integer  "ticket_client_id"
    t.string   "ticket_issue_type"
    t.string   "ticket_type"
    t.string   "link"
    t.integer  "dispute_id"
  end

  add_index "tickets", ["current_owner_id"], :name => "index_tickets_on_current_owner_id"
  add_index "tickets", ["status"], :name => "index_tickets_on_status"
  add_index "tickets", ["ticket_client_id"], :name => "index_tickets_on_ticket_client_id"
  add_index "tickets", ["ticketable_id", "ticketable_type"], :name => "index_tickets_on_ticketable_id_and_ticketable_type"

  create_table "tracking_details", :force => true do |t|
    t.integer  "shipping_agent_id"
    t.string   "tracking_number"
    t.string   "courier_status"
    t.datetime "delivery_time"
    t.string   "more_details"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.datetime "history_last_updated_at"
  end

  add_index "tracking_details", ["tracking_number", "shipping_agent_id"], :name => "index_tracking_details_on_tracking_number_and_shipping_agent_id", :unique => true

  create_table "tracking_histories", :force => true do |t|
    t.integer  "tracking_detail_id"
    t.string   "location"
    t.string   "detailed_status"
    t.string   "mapped_status"
    t.datetime "status_datetime"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "tracking_histories", ["tracking_detail_id"], :name => "index_tracking_histories_on_tracking_detail_id"

  create_table "user_role_maps", :force => true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "username"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "client_id"
    t.string   "courier_id"
    t.integer  "warehouse_id"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "value_added_services", :force => true do |t|
    t.string   "name",       :null => false
    t.integer  "package_id", :null => false
    t.string   "created_by"
    t.string   "updated_by"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "value_added_services", ["name", "package_id"], :name => "index_value_added_services_on_name_and_package_id", :unique => true

  create_table "versions", :force => true do |t|
    t.string   "item_type",                        :null => false
    t.integer  "item_id",                          :null => false
    t.string   "event",                            :null => false
    t.string   "whodunnit"
    t.text     "object",     :limit => 2147483647
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id", :length => {"item_type"=>191, "item_id"=>nil}

  create_table "warehouses", :force => true do |t|
    t.string   "name"
    t.integer  "client_id"
    t.integer  "address_id"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.boolean  "is_active",        :default => true
    t.boolean  "can_add_packages", :default => false
    t.string   "tin_number"
  end

  add_index "warehouses", ["client_id"], :name => "index_warehouses_on_client_id"
  add_index "warehouses", ["name", "client_id"], :name => "index_warehouses_on_name_and_client_id", :unique => true

  create_table "weight_slabs", :force => true do |t|
    t.integer  "rate_plan_item_id"
    t.integer  "weight_slab"
    t.string   "payment_mode"
    t.boolean  "is_additional_slab"
    t.integer  "freight_charge_in_cents"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

end
