# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2024_08_31_084947) do
  create_table "addresses", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "firstname"
    t.string "lastname"
    t.string "address1"
    t.string "address2"
    t.string "city"
    t.string "zipcode"
    t.string "phone"
    t.string "state_name"
    t.string "alternative_phone"
    t.string "company"
    t.string "longitude"
    t.string "latitude"
    t.string "country_name"
    t.bigint "hotels_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hotels_id"], name: "index_addresses_on_hotels_id"
  end

  create_table "bookings", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "hotels_id"
    t.bigint "users_id"
    t.datetime "check_in"
    t.datetime "check_out"
    t.decimal "price", precision: 10
    t.string "status", default: "booked"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hotels_id"], name: "index_bookings_on_hotels_id"
    t.index ["users_id"], name: "index_bookings_on_users_id"
  end

  create_table "chats", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "senders_id"
    t.bigint "receivers_id"
    t.bigint "hotels_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hotels_id"], name: "index_chats_on_hotels_id"
    t.index ["receivers_id"], name: "index_chats_on_receivers_id"
    t.index ["senders_id"], name: "index_chats_on_senders_id"
  end

  create_table "hotel_properties", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "hotels_id"
    t.bigint "properties_id"
    t.boolean "display", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hotels_id"], name: "index_hotel_properties_on_hotels_id"
    t.index ["properties_id"], name: "index_hotel_properties_on_properties_id"
  end

  create_table "hotel_types", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", default: "hotel"
    t.boolean "active", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hotels", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name"
    t.text "description"
    t.bigint "hotel_type_id"
    t.integer "total_rooms", default: 0
    t.integer "available_rooms", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hotel_type_id"], name: "index_hotels_on_hotel_type_id"
    t.index ["user_id"], name: "index_hotels_on_user_id"
  end

  create_table "messages", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.text "body"
    t.bigint "senders_id"
    t.bigint "receivers_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["receivers_id"], name: "index_messages_on_receivers_id"
    t.index ["senders_id"], name: "index_messages_on_senders_id"
  end

  create_table "payments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "payment_intent_id"
    t.string "payment_method"
    t.string "payment_status"
    t.date "payment_date"
    t.integer "amount"
    t.bigint "booking_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["booking_id"], name: "index_payments_on_booking_id"
  end

  create_table "properties", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.boolean "active"
    t.string "unique_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reviews", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "users_id"
    t.bigint "hotels_id"
    t.integer "rating", default: 0
    t.boolean "display", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hotels_id"], name: "index_reviews_on_hotels_id"
    t.index ["users_id"], name: "index_reviews_on_users_id"
  end

  create_table "roles", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.boolean "active", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rooms", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "hotel_id"
    t.integer "no_of_people", default: 1
    t.decimal "price", precision: 10, default: "0"
    t.boolean "active", default: true
    t.string "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hotel_id"], name: "index_rooms_on_hotel_id"
  end

  create_table "user_roles", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id"], name: "index_user_roles_on_role_id"
    t.index ["user_id"], name: "index_user_roles_on_user_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "fullname"
    t.string "uid"
    t.string "avatar_url"
    t.string "provider"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "payments", "bookings"
end
