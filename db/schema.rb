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

ActiveRecord::Schema.define(version: 2022_03_04_193840) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "hardiness_zones", force: :cascade do |t|
    t.string "zipcode"
    t.string "zone"
    t.string "trange"
    t.string "zonetitle"
    t.datetime "created_at", precision: 6, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", precision: 6, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.string "last_frost"
    t.string "last_frost_short"
  end

  create_table "seed_catalogs", force: :cascade do |t|
    t.boolean "planted"
    t.bigint "user_id"
    t.bigint "seed_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["seed_id"], name: "index_seed_catalogs_on_seed_id"
    t.index ["user_id"], name: "index_seed_catalogs_on_user_id"
  end

  create_table "seeds", force: :cascade do |t|
    t.string "botanical_name"
    t.string "height"
    t.string "spacing"
    t.string "depth"
    t.string "spread"
    t.string "light_required"
    t.string "pollinator"
    t.string "yield"
    t.string "color"
    t.string "size"
    t.string "blooms"
    t.string "fruit"
    t.string "days_to_maturity"
    t.string "zone"
    t.string "germination"
    t.string "form"
    t.string "flower_form"
    t.string "soil_requirements"
    t.string "growth_rate"
    t.string "seed_count"
    t.string "pruning"
    t.string "foliage"
    t.string "name"
    t.string "category"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "planting_date"
  end

  create_table "user_zones", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "hardiness_zone_id"
    t.index ["hardiness_zone_id"], name: "index_user_zones_on_hardiness_zone_id"
    t.index ["user_id"], name: "index_user_zones_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "nickname"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
