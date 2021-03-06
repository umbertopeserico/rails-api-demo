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

ActiveRecord::Schema.define(version: 2019_06_07_103110) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "v1_flights", id: :string, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "departure_airport_id", null: false
    t.string "arrival_airport_id", null: false
    t.index ["departure_airport_id", "arrival_airport_id"], name: "index_v1_flights_departure_id_arrival_id_1", unique: true
    t.index ["departure_airport_id", "arrival_airport_id"], name: "index_v1_flights_departure_id_arrival_id_2", unique: true
  end

  create_table "v1_flights_airplanes", id: :string, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.integer "seats", default: 0, null: false
  end

  create_table "v1_flights_airports", id: :string, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.index "lower((name)::text)", name: "index_v1_flights_airports_on_LOWER_name", unique: true
  end

  create_table "v1_flights_executions", id: :string, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "departure_time", null: false
    t.datetime "arrival_time", null: false
    t.integer "price_cents", default: 0, null: false
    t.string "price_currency", default: "EUR", null: false
    t.string "assigned_airplane_id", null: false
    t.string "flight_id", null: false
    t.index ["assigned_airplane_id"], name: "index_v1_flights_executions_on_assigned_airplane_id"
    t.index ["flight_id"], name: "index_v1_flights_executions_on_flight_id"
  end

  create_table "v1_flights_reservations", id: :string, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "owner_id"
    t.string "execution_id", null: false
    t.index ["execution_id"], name: "index_v1_flights_reservations_on_execution_id"
    t.index ["owner_id"], name: "index_v1_flights_reservations_on_owner_id"
  end

  create_table "v1_passengers", id: :string, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "email", null: false
    t.string "password_digest", default: "", null: false
    t.index "lower((email)::text)", name: "index_v1_passengers_on_LOWER_email", unique: true
  end

  create_table "v1_passengers_preferences", id: :string, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "passenger_id", null: false
    t.string "language", null: false
    t.string "timezone", null: false
    t.string "currency", null: false
    t.index "lower((passenger_id)::text)", name: "index_v1_passengers_preferences_on_LOWER_passenger_id", unique: true
  end

  add_foreign_key "v1_flights", "v1_flights_airports", column: "arrival_airport_id", on_update: :cascade, on_delete: :restrict
  add_foreign_key "v1_flights", "v1_flights_airports", column: "departure_airport_id", on_update: :cascade, on_delete: :restrict
  add_foreign_key "v1_flights_executions", "v1_flights", column: "flight_id", on_update: :cascade, on_delete: :restrict
  add_foreign_key "v1_flights_executions", "v1_flights_airplanes", column: "assigned_airplane_id", on_update: :cascade, on_delete: :restrict
  add_foreign_key "v1_flights_reservations", "v1_flights_executions", column: "execution_id", on_update: :cascade, on_delete: :restrict
  add_foreign_key "v1_flights_reservations", "v1_passengers", column: "owner_id", on_update: :cascade, on_delete: :nullify
  add_foreign_key "v1_passengers_preferences", "v1_passengers", column: "passenger_id", on_update: :cascade, on_delete: :cascade
end
