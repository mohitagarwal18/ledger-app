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

ActiveRecord::Schema.define(version: 2023_09_11_181103) do

  create_table "entities", force: :cascade do |t|
    t.integer "entity_type", default: 0, null: false
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.integer "activity_id", limit: 8
    t.datetime "date"
    t.integer "transaction_type", null: false
    t.string "method"
    t.float "amount"
    t.float "balance"
    t.json "source"
    t.integer "sequence_id"
    t.integer "entity_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["activity_id"], name: "index_transactions_on_activity_id", unique: true
    t.index ["entity_id"], name: "index_transactions_on_entity_id"
  end

  add_foreign_key "transactions", "entities"
end
