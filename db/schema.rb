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

ActiveRecord::Schema.define(version: 2024_03_17_160159) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.integer "resource_id"
    t.string "author_type"
    t.integer "author_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "cleaning_tasks", force: :cascade do |t|
    t.integer "room_id", null: false
    t.integer "user_id", null: false
    t.date "task_start", null: false
    t.boolean "done", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["room_id"], name: "index_cleaning_tasks_on_room_id"
    t.index ["user_id"], name: "index_cleaning_tasks_on_user_id"
  end

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

  create_table "historical_sums", force: :cascade do |t|
    t.float "food"
    t.float "invest"
    t.float "cleaning"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "restacks", force: :cascade do |t|
    t.integer "from_id"
    t.integer "to_id"
    t.integer "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id", null: false
    t.boolean "prompted"
    t.boolean "Cancelled"
    t.index ["user_id"], name: "index_restacks_on_user_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.boolean "active"
    t.boolean "deleted"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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
    t.boolean "deleted", default: false
    t.boolean "excepted", default: false
    t.integer "telegram_id"
  end

  add_foreign_key "cleaning_tasks", "rooms"
  add_foreign_key "cleaning_tasks", "users"
  add_foreign_key "finance_values", "users"
  add_foreign_key "restacks", "users"
end
