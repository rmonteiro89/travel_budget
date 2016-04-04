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

ActiveRecord::Schema.define(version: 20160320212156) do

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "categories", ["user_id"], name: "index_categories_on_user_id"

  create_table "expenses", force: :cascade do |t|
    t.date     "date"
    t.string   "description"
    t.integer  "amount_cents",    default: 0,     null: false
    t.string   "amount_currency", default: "USD", null: false
    t.integer  "trip_id"
    t.integer  "category_id"
    t.integer  "users_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "expenses", ["category_id"], name: "index_expenses_on_category_id"
  add_index "expenses", ["trip_id"], name: "index_expenses_on_trip_id"
  add_index "expenses", ["users_id"], name: "index_expenses_on_users_id"

  create_table "trips", force: :cascade do |t|
    t.integer  "exchange_rate_cents",    default: 0,     null: false
    t.string   "exchange_rate_currency", default: "USD", null: false
    t.string   "currency"
    t.string   "country"
    t.string   "city"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  create_table "trips_users", force: :cascade do |t|
    t.integer "user_id"
    t.integer "trip_id"
  end

  add_index "trips_users", ["trip_id"], name: "index_trips_users_on_trip_id"
  add_index "trips_users", ["user_id"], name: "index_trips_users_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "currency"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
