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

ActiveRecord::Schema[7.2].define(version: 2024_08_25_205432) do
  create_table "account_members", force: :cascade do |t|
    t.string "uuid", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uuid"], name: "index_account_members_on_uuid", unique: true
  end

  create_table "accounts", force: :cascade do |t|
    t.string "uuid", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uuid"], name: "index_accounts_on_uuid", unique: true
  end

  create_table "memberships", force: :cascade do |t|
    t.string "role", limit: 16, null: false
    t.integer "account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "member_id", null: false
    t.index ["account_id"], name: "index_memberships_on_account_id"
    t.index ["account_id"], name: "index_memberships_on_account_id_and_user_id", unique: true
  end

  create_table "task_items", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.datetime "completed_at"
    t.integer "task_list_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["completed_at"], name: "index_task_items_on_completed_at"
    t.index ["task_list_id"], name: "index_task_items_on_task_list_id"
  end

  create_table "task_lists", force: :cascade do |t|
    t.string "name"
    t.boolean "inbox", default: false, null: false
    t.integer "account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.index ["account_id"], name: "index_task_lists_inbox", unique: true, where: "inbox"
    t.index ["account_id"], name: "index_task_lists_on_account_id"
  end

  create_table "user_tokens", force: :cascade do |t|
    t.string "short", limit: 8, null: false
    t.string "checksum", limit: 64, null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["short"], name: "index_user_tokens_on_short", unique: true
    t.index ["user_id"], name: "index_user_tokens_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uuid", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["uuid"], name: "index_users_on_uuid", unique: true
  end

  add_foreign_key "memberships", "account_members", column: "member_id"
  add_foreign_key "memberships", "accounts"
  add_foreign_key "task_items", "task_lists"
  add_foreign_key "task_lists", "accounts"
  add_foreign_key "user_tokens", "users"
end
