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

ActiveRecord::Schema[8.0].define(version: 2025_08_05_185208) do
  create_table "ages", force: :cascade do |t|
    t.integer "age", null: false
    t.decimal "multiplier", precision: 10, scale: 2, default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "claim_destinations", force: :cascade do |t|
    t.integer "claim_id", null: false
    t.integer "destination_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["claim_id"], name: "index_claim_destinations_on_claim_id"
    t.index ["destination_id"], name: "index_claim_destinations_on_destination_id"
  end

  create_table "claim_snows", force: :cascade do |t|
    t.integer "claim_id", null: false
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["claim_id"], name: "index_claim_snows_on_claim_id"
  end

  create_table "claims", force: :cascade do |t|
    t.integer "trip_type_id", null: false
    t.integer "age_id", null: false
    t.date "trip_start_date"
    t.date "trip_end_date"
    t.integer "excess_id", null: false
    t.boolean "has_cruise", default: false, null: false
    t.string "policy"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["age_id"], name: "index_claims_on_age_id"
    t.index ["excess_id"], name: "index_claims_on_excess_id"
    t.index ["trip_type_id"], name: "index_claims_on_trip_type_id"
  end

  create_table "configuration_base_configs", force: :cascade do |t|
    t.decimal "base_number", precision: 10, scale: 15, default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "configuration_covers", force: :cascade do |t|
    t.string "level", null: false
    t.decimal "multiplier", precision: 10, scale: 2, default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "configuration_cruises", force: :cascade do |t|
    t.integer "region_id", null: false
    t.integer "amount_cents", default: 0, null: false
    t.string "amount_currency", default: "USD", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["region_id"], name: "index_configuration_cruises_on_region_id"
  end

  create_table "configuration_durations", force: :cascade do |t|
    t.integer "minimum", null: false
    t.decimal "multiplier", precision: 10, scale: 2, default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "configuration_excesses", force: :cascade do |t|
    t.integer "excess_cents", default: 0, null: false
    t.string "excess_currency", default: "USD", null: false
    t.decimal "multiplier", precision: 10, scale: 2, default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "configuration_regions", force: :cascade do |t|
    t.integer "region_number"
    t.decimal "multiplier", precision: 10, scale: 2, default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "configuration_scheme_types", force: :cascade do |t|
    t.boolean "one_way", default: false, null: false
    t.decimal "multiplier", precision: 10, scale: 2, default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "configuration_snows", force: :cascade do |t|
    t.integer "region_id", null: false
    t.integer "amount_cents", default: 0, null: false
    t.string "amount_currency", default: "USD", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["region_id"], name: "index_configuration_snows_on_region_id"
  end

  create_table "destinations", force: :cascade do |t|
    t.string "country_code"
    t.string "country"
    t.integer "zone_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["zone_id"], name: "index_destinations_on_zone_id"
  end

  create_table "premiums", force: :cascade do |t|
    t.integer "claim_id", null: false
    t.integer "cover_id", null: false
    t.integer "base_amount_cents", default: 0, null: false
    t.string "base_amount_currency", default: "USD", null: false
    t.integer "final_amount_cents", default: 0, null: false
    t.string "final_amount_currency", default: "USD", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["claim_id", "cover_id"], name: "index_premiums_on_claim_id_and_cover_id", unique: true
    t.index ["claim_id"], name: "index_premiums_on_claim_id"
    t.index ["cover_id"], name: "index_premiums_on_cover_id"
  end

  add_foreign_key "claim_destinations", "claims"
  add_foreign_key "claim_snows", "claims"
  add_foreign_key "claims", "ages"
  add_foreign_key "claims", "configuration_excesses", column: "excess_id"
  add_foreign_key "claims", "configuration_scheme_types", column: "trip_type_id"
  add_foreign_key "configuration_cruises", "configuration_regions", column: "region_id"
  add_foreign_key "configuration_snows", "configuration_regions", column: "region_id"
  add_foreign_key "destinations", "configuration_regions", column: "zone_id"
  add_foreign_key "premiums", "claims"
  add_foreign_key "premiums", "configuration_covers", column: "cover_id"
end
