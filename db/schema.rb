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

ActiveRecord::Schema.define(:version => 20130327031808) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                                                                                                                         :default => "",      :null => false
    t.string   "encrypted_password",                                                                                                            :default => "",      :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                                                                                                                 :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                                                                                                                         :null => false
    t.datetime "updated_at",                                                                                                                                         :null => false
    t.enum     "role",                   :limit => [:SUPER_ADMIN, :ADMIN, :DEV, :FIN, :PLM, :SALES, :MATERIAL_CONTROLLER, :POST_SALES, :OTHER], :default => :OTHER
    t.string   "user_name"
    t.string   "telephone"
    t.string   "organization",                                                                                                                  :default => "other"
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true
  add_index "admin_users", ["user_name"], :name => "index_admin_users_on_user_name", :unique => true

  create_table "categories", :force => true do |t|
    t.enum     "category_type",    :limit => [:CATEGORY_LEVEL1, :CATEGORY_LEVEL2, :CATEGORY_LEVEL3, :CATEGORY_LEVEL4]
    t.string   "level1"
    t.string   "level2"
    t.string   "level3"
    t.string   "level4"
    t.string   "name"
    t.string   "comment"
    t.string   "updated_by_email"
    t.datetime "created_at",                                                                                           :null => false
    t.datetime "updated_at",                                                                                           :null => false
  end

  add_index "categories", ["category_type"], :name => "index_categories_on_category_type"
  add_index "categories", ["level1", "level2", "level3", "level4"], :name => "index_categories_on_level1_and_level2_and_level3_and_level4", :unique => true

  create_table "category1sts", :force => true do |t|
    t.string   "category_encoding"
    t.string   "category_name"
    t.string   "category_comment"
    t.string   "updated_by_email"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "category1sts", ["category_encoding"], :name => "index_category1sts_on_category_encoding"

  create_table "category2nds", :force => true do |t|
    t.string   "category_encoding"
    t.string   "category_name"
    t.string   "category_comment"
    t.string   "updated_by_email"
    t.integer  "category1st_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "category3rds", :force => true do |t|
    t.string   "category_encoding"
    t.string   "category_name"
    t.string   "category_comment"
    t.string   "updated_by_email"
    t.integer  "category2nd_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "category3rds", ["category2nd_id"], :name => "index_category3rds_on_category2nd_id"

  create_table "category4ths", :force => true do |t|
    t.string   "category_encoding"
    t.string   "category_name"
    t.string   "category_comment"
    t.string   "updated_by_email"
    t.integer  "category3rd_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "category4ths", ["category3rd_id"], :name => "index_category4ths_on_category3rd_id"

  create_table "component_categories", :force => true do |t|
    t.string   "name"
    t.string   "comment"
    t.string   "updated_by_email"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.string   "ancestry"
    t.integer  "ancestry_depth",   :default => 0
  end

  add_index "component_categories", ["ancestry"], :name => "index_component_categories_on_ancestry"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
