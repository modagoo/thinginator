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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20130924165713) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "classifications", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "collections", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "content_booleans", force: true do |t|
    t.boolean  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "content_datetimes", force: true do |t|
    t.datetime "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "content_files", force: true do |t|
    t.string   "value_file_name"
    t.string   "value_content_type"
    t.string   "value_file_size"
    t.datetime "value_updated_at"
    t.string   "value_fingerprint"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "content_fixnums", force: true do |t|
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "content_integers", force: true do |t|
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "content_lists", force: true do |t|
    t.text     "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "content_markdowns", force: true do |t|
    t.text     "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "content_strings", force: true do |t|
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "content_texts", force: true do |t|
    t.text     "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contents", force: true do |t|
    t.integer  "thing_id"
    t.integer  "property_id"
    t.integer  "contentable_id"
    t.string   "contentable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "data_lists", force: true do |t|
    t.integer  "list_id"
    t.integer  "property_id"
    t.boolean  "multiple"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "data_types", force: true do |t|
    t.string   "friendly_name"
    t.string   "name"
    t.text     "help"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "list_values", force: true do |t|
    t.text     "value"
    t.integer  "list_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lists", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "properties", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.text     "help"
    t.boolean  "hide"
    t.integer  "data_type_id"
    t.integer  "collection_id"
    t.integer  "validation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "property_validations", force: true do |t|
    t.integer  "validation_type_id"
    t.integer  "property_id"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "things", force: true do |t|
    t.integer  "collection_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "firstname"
    t.string   "lastname"
    t.boolean  "admin",      default: false
    t.boolean  "superuser",  default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "validation_types", force: true do |t|
    t.string   "friendly_name"
    t.string   "name"
    t.text     "help"
    t.boolean  "requires_value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "validations", force: true do |t|
    t.integer  "validation_type_id"
    t.integer  "property_id"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
