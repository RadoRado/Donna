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

ActiveRecord::Schema.define(version: 20150828202245) do

  create_table "contacts", force: :cascade do |t|
    t.string  "name"
    t.string  "email"
    t.integer "user_id"
  end

  add_index "contacts", ["user_id"], name: "index_contacts_on_user_id"

  create_table "ping_rules", force: :cascade do |t|
    t.integer  "times_a_month"
    t.integer  "consecutive_months"
    t.string   "schedule"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "contact_id"
    t.integer  "user_id"
  end

  add_index "ping_rules", ["contact_id"], name: "index_ping_rules_on_contact_id"
  add_index "ping_rules", ["user_id"], name: "index_ping_rules_on_user_id"

  create_table "pings", force: :cascade do |t|
    t.datetime "target_week"
    t.datetime "target_day"
    t.integer  "ping_rule_id"
  end

  add_index "pings", ["ping_rule_id"], name: "index_pings_on_ping_rule_id"

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.string "password"
    t.string "password_salt"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
