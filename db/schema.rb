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

ActiveRecord::Schema.define(:version => 20120921041646) do

  create_table "addresses", :force => true do |t|
    t.string   "first_line"
    t.string   "second_line"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.string   "fax"
    t.integer  "provider_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "authorized_officials", :force => true do |t|
    t.integer  "name_id"
    t.string   "phone"
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "authorized_officials", ["name_id"], :name => "index_authorized_officials_on_name_id"

  create_table "individual_names", :force => true do |t|
    t.string   "first"
    t.string   "last"
    t.string   "middle"
    t.string   "prefix"
    t.string   "suffix"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "org_names", :force => true do |t|
    t.string   "legal_business_name"
    t.string   "name_type"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "providers", :force => true do |t|
    t.string   "type"
    t.integer  "name_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "specialties", :force => true do |t|
    t.integer  "provider_id"
    t.integer  "taxonomy_id"
    t.boolean  "is_primary"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "taxonomies", :force => true do |t|
    t.string   "code"
    t.string   "name"
    t.text     "description"
    t.integer  "category_id"
    t.integer  "parent_taxonomy_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "taxonomy_categories", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

end
