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

ActiveRecord::Schema.define(:version => 20130417060846) do

  create_table "addresses", :force => true do |t|
    t.string   "street_number"
    t.string   "street_name"
    t.string   "postal_code"
    t.string   "city",          :default => "Paris"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.integer  "store_id"
    t.integer  "district"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "gmaps"
  end

  add_index "addresses", ["store_id"], :name => "index_addresses_on_store_id"

  create_table "boards", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.string   "districts_serialized"
  end

  create_table "boards_categories", :id => false, :force => true do |t|
    t.integer "board_id"
    t.integer "category_id"
  end

  add_index "boards_categories", ["board_id"], :name => "index_boards_categories_on_board_id"

  create_table "boards_tags", :id => false, :force => true do |t|
    t.integer "board_id"
    t.integer "tag_id"
  end

  add_index "boards_tags", ["board_id"], :name => "index_boards_tags_on_board_id"

  create_table "categories", :force => true do |t|
    t.string  "title"
    t.string  "permalink"
    t.text    "description"
    t.integer "parent_id"
  end

  create_table "categories_associations", :force => true do |t|
    t.integer "store_id",    :null => false
    t.integer "category_id", :null => false
  end

  add_index "categories_associations", ["category_id"], :name => "index_categories_associations_on_category_id"
  add_index "categories_associations", ["store_id"], :name => "index_categories_associations_on_store_id"

  create_table "categories_parents", :force => true do |t|
    t.string "title"
    t.string "permalink"
  end

  create_table "connections", :force => true do |t|
    t.string   "uid"
    t.string   "provider"
    t.string   "token"
    t.string   "secret"
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.string   "token_type"
    t.integer  "blog_id"
    t.string   "blog_url"
    t.string   "scope"
    t.string   "blogger_user_id"
    t.string   "blogger_user_name"
    t.string   "blogger_user_password"
  end

  create_table "deals", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "slots"
    t.decimal  "normal_price",     :precision => 9, :scale => 2
    t.decimal  "discount_price",   :precision => 9, :scale => 2
    t.date     "starts_at"
    t.date     "ends_at"
    t.datetime "created_at",                                                        :null => false
    t.datetime "updated_at",                                                        :null => false
    t.integer  "store_id"
    t.integer  "tag_id"
    t.boolean  "admin_validation",                               :default => false
  end

  add_index "deals", ["store_id"], :name => "index_deals_on_store_id"

  create_table "deals_wishlists", :id => false, :force => true do |t|
    t.integer "wishlist_id", :null => false
    t.integer "deal_id",     :null => false
  end

  add_index "deals_wishlists", ["wishlist_id", "deal_id"], :name => "index_deals_wishlists_on_wishlist_id_and_deal_id", :unique => true

  create_table "news", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.integer  "store_id"
    t.integer  "tag_id"
    t.boolean  "admin_validation", :default => false
  end

  add_index "news", ["store_id"], :name => "index_news_on_store_id"

  create_table "options", :force => true do |t|
    t.integer "user_id",                    :null => false
    t.string  "key",                        :null => false
    t.boolean "value",   :default => false
  end

  add_index "options", ["user_id", "key"], :name => "index_options_on_user_id_and_key", :unique => true

  create_table "pictures", :force => true do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "decorated_type"
    t.integer  "decorated_id"
    t.integer  "store_id"
  end

  add_index "pictures", ["decorated_id", "decorated_type"], :name => "index_pictures_on_decorated_id_and_decorated_type"

  create_table "products", :force => true do |t|
    t.string   "name"
    t.decimal  "price",            :precision => 9, :scale => 2
    t.text     "description"
    t.datetime "created_at",                                                        :null => false
    t.datetime "updated_at",                                                        :null => false
    t.integer  "store_id"
    t.integer  "tag_id"
    t.boolean  "admin_validation",                               :default => false
  end

  add_index "products", ["store_id"], :name => "index_products_on_store_id"

  create_table "products_wishlists", :id => false, :force => true do |t|
    t.integer "wishlist_id", :null => false
    t.integer "product_id",  :null => false
  end

  add_index "products_wishlists", ["product_id", "wishlist_id"], :name => "index_products_wishlists_on_product_id_and_wishlist_id", :unique => true

  create_table "rails_admin_histories", :force => true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 8
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "schedule_items", :force => true do |t|
    t.time     "start_at"
    t.time     "end_at"
    t.integer  "store_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "day_cd"
    t.integer  "status_cd",      :default => 1, :null => false
    t.time     "pause_start_at"
    t.time     "pause_end_at"
  end

  create_table "stores", :force => true do |t|
    t.string   "name"
    t.string   "phone"
    t.text     "description"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.integer  "user_id"
    t.integer  "wizard_step",       :default => 1
    t.boolean  "admin_validation",  :default => false
    t.string   "website_url"
    t.string   "facebook_url"
  end

  add_index "stores", ["user_id"], :name => "index_stores_on_user_id"

  create_table "tags", :force => true do |t|
    t.string  "name"
    t.integer "group_id"
    t.integer "category_id"
  end

  create_table "tags_groups", :force => true do |t|
    t.string "name"
  end

  create_table "user_follows", :id => false, :force => true do |t|
    t.integer "store_id"
    t.integer "user_id"
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
    t.integer  "role_cd",                :default => 0
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "provider"
    t.string   "uid"
    t.string   "token"
    t.datetime "token_expires_in"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "secret_token"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "variants", :force => true do |t|
    t.integer  "variable_id"
    t.string   "name",          :default => "variant", :null => false
    t.integer  "stock",         :default => 0,         :null => false
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.string   "variable_type", :default => "Product", :null => false
  end

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

  create_table "wishlists", :force => true do |t|
    t.integer "user_id", :null => false
  end

end
