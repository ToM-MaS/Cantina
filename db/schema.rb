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

ActiveRecord::Schema.define(:version => 20110122171701) do

  create_table "codecs", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "manufacturers", :force => true do |t|
    t.string   "name"
    t.string   "ieee_name"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ouis", :force => true do |t|
    t.string   "value"
    t.integer  "manufacturer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "phone_key_function_definitions", :force => true do |t|
    t.string   "name"
    t.string   "type_of_class"
    t.string   "regex_validation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "phone_key_to_function_mappings", :force => true do |t|
    t.integer  "phone_model_key_id"
    t.integer  "phone_key_function_definition_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "phone_keys", :force => true do |t|
    t.integer  "phone_model_key_id"
    t.integer  "phone_key_function_definition_id"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sip_account_id"
  end

  create_table "phone_model_codecs", :force => true do |t|
    t.integer  "phone_model_id"
    t.integer  "codec_id"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "phone_model_keys", :force => true do |t|
    t.string   "name"
    t.integer  "phone_model_id"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "phone_model_mac_addresses", :force => true do |t|
    t.integer  "phone_model_id"
    t.string   "starts_with"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "phone_models", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.integer  "manufacturer_id"
    t.integer  "max_number_of_sip_accounts"
    t.integer  "number_of_keys"
    t.integer  "max_number_of_phone_book_entries"
    t.string   "default_http_user"
    t.string   "default_http_password"
    t.integer  "http_port"
    t.string   "reboot_request_path"
    t.boolean  "ssl"
    t.integer  "http_request_timeout"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "phones", :force => true do |t|
    t.string   "mac_address"
    t.integer  "phone_model_id"
    t.string   "ip_address"
    t.string   "http_user"
    t.string   "http_password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "provisioning_log_entries", :force => true do |t|
    t.integer  "phone_id"
    t.string   "memo"
    t.boolean  "succeeded"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reboot_requests", :force => true do |t|
    t.integer  "phone_id"
    t.datetime "start"
    t.datetime "end"
    t.boolean  "successful"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sip_account_codecs", :force => true do |t|
    t.integer  "codec_id"
    t.integer  "sip_account_id"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sip_accounts", :force => true do |t|
    t.string   "name"
    t.integer  "phone_id"
    t.string   "auth_user"
    t.string   "user"
    t.string   "password"
    t.string   "registrar"
    t.integer  "registrar_port"
    t.string   "outbound_proxy"
    t.integer  "outbound_proxy_port"
    t.string   "sip_proxy"
    t.integer  "sip_proxy_port"
    t.string   "realm"
    t.string   "screen_name"
    t.string   "display_name"
    t.integer  "registration_expiry_time"
    t.string   "dtmf_mode"
    t.string   "remote_password"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
