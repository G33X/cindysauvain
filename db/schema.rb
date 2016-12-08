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

ActiveRecord::Schema.define(version: 20160728210904) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "casein_admin_users", force: :cascade do |t|
    t.string   "login",                           null: false
    t.string   "name"
    t.string   "email"
    t.integer  "access_level",        default: 0, null: false
    t.string   "crypted_password",                null: false
    t.string   "password_salt",                   null: false
    t.string   "persistence_token"
    t.string   "single_access_token"
    t.string   "perishable_token"
    t.integer  "login_count",         default: 0, null: false
    t.integer  "failed_login_count",  default: 0, null: false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.string   "time_zone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: :cascade do |t|
    t.string   "title"
    t.string   "speaker"
    t.string   "building"
    t.string   "address"
    t.string   "zip"
    t.string   "city"
    t.string   "image"
    t.text     "details"
    t.datetime "date_from"
    t.datetime "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title_fr"
    t.string   "building_fr"
    t.string   "details_fr"
    t.string   "website"
    t.string   "additionnal_website"
    t.string   "country"
    t.string   "country_fr"
  end

  create_table "letsencrypt_plugin_challenges", force: :cascade do |t|
    t.text     "response"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "letsencrypt_plugin_settings", force: :cascade do |t|
    t.text     "private_key"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "medias", force: :cascade do |t|
    t.string   "media_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "media_link"
    t.string   "image_url"
    t.integer  "image_width"
    t.integer  "image_height"
    t.text     "caption"
    t.integer  "likes"
    t.integer  "media_date"
  end

  create_table "news", force: :cascade do |t|
    t.string   "title"
    t.text     "text"
    t.string   "type"
    t.date     "date"
    t.string   "image"
    t.string   "video"
    t.string   "author"
    t.integer  "likes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "video_src"
    t.string   "title_fr"
    t.string   "text_fr"
    t.boolean  "hidden",     default: false, null: false
  end

  create_table "testimonials", force: :cascade do |t|
    t.string   "name"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
    t.string   "image_pos"
    t.text     "text_fr"
  end

end
