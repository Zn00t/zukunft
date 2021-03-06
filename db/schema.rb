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

ActiveRecord::Schema.define(version: 2022_02_07_100132) do

  create_table "finance_values", force: :cascade do |t|
    t.string "name"
    t.float "sum"
    t.integer "rate"
    t.float "food"
    t.float "invest"
    t.integer "cleaning"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
    t.boolean "cleaned"
    t.date "away"
    t.index ["user_id"], name: "index_finance_values_on_user_id"
  end

  create_table "restacks", force: :cascade do |t|
    t.integer "from_id"
    t.integer "to_id"
    t.integer "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id", null: false
    t.boolean "prompted"
    t.index ["user_id"], name: "index_restacks_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "admin"
    t.boolean "active"
    t.integer "rate", default: 0, null: false
    t.float "food", default: 0.0, null: false
    t.float "invest", default: 0.0, null: false
    t.integer "cleaning", default: 0, null: false
    t.boolean "cleaned", default: false, null: false
    t.date "away"
  end

  add_foreign_key "finance_values", "users"
  add_foreign_key "restacks", "users"
end
