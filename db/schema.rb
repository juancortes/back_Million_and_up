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

ActiveRecord::Schema[7.0].define(version: 2023_04_06_013836) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "detail_sales", force: :cascade do |t|
    t.bigint "products_id", null: false
    t.integer "count"
    t.float "price"
    t.bigint "sales_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["products_id"], name: "index_detail_sales_on_products_id"
    t.index ["sales_id"], name: "index_detail_sales_on_sales_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "title", limit: 100
    t.float "price"
    t.text "description"
    t.string "category", limit: 50
    t.string "image", limit: 150
    t.float "rate"
    t.integer "count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sales", force: :cascade do |t|
    t.integer "total_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shopping_carts", force: :cascade do |t|
    t.bigint "products_id", null: false
    t.integer "count"
    t.float "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["products_id"], name: "index_shopping_carts_on_products_id"
  end

  add_foreign_key "detail_sales", "products", column: "products_id"
  add_foreign_key "detail_sales", "sales", column: "sales_id"
  add_foreign_key "shopping_carts", "products", column: "products_id"
end
