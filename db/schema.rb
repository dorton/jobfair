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

ActiveRecord::Schema.define(version: 20160715055145) do

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "campus"
    t.boolean  "email_option",           default: false
    t.boolean  "super_admin"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true

  create_table "events", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
    t.string   "location"
    t.date     "date"
    t.integer  "admin_id"
    t.integer  "user_id"
    t.string   "event_type"
  end

  create_table "locationadmins", force: :cascade do |t|
    t.integer  "location_id"
    t.integer  "admin_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "locationadmins", ["admin_id"], name: "index_locationadmins_on_admin_id"
  add_index "locationadmins", ["location_id"], name: "index_locationadmins_on_location_id"

  create_table "locationevents", force: :cascade do |t|
    t.integer  "location_id"
    t.integer  "event_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "locationevents", ["event_id"], name: "index_locationevents_on_event_id"
  add_index "locationevents", ["location_id"], name: "index_locationevents_on_location_id"

  create_table "locations", force: :cascade do |t|
    t.string   "city"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_events", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "userlocations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "location_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "userlocations", ["location_id"], name: "index_userlocations_on_location_id"
  add_index "userlocations", ["user_id"], name: "index_userlocations_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "note"
    t.integer  "event_id"
    t.string   "company"
    t.string   "interest"
    t.string   "avatar"
    t.string   "bio"
    t.string   "employment_name"
    t.string   "twitter_handle"
    t.string   "twitter_id"
    t.string   "linkedin_handle"
    t.string   "employment_domain"
    t.boolean  "fuzzy"
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "student",           default: false
  end

end
