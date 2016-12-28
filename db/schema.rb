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

ActiveRecord::Schema.define(version: 20161223111301) do

  create_table "duepayments", force: :cascade do |t|
    t.integer  "estate_id"
    t.integer  "period_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "estates", force: :cascade do |t|
    t.integer  "estate_code"
    t.string   "name"
    t.integer  "landlord_id"
    t.decimal  "price_per_acre",    precision: 20, scale: 2
    t.integer  "acre"
    t.string   "zip_code"
    t.string   "address"
    t.string   "geolocalisation"
    t.string   "coordinate_points"
    t.text     "description"
    t.decimal  "total_price",       precision: 20, scale: 2
    t.boolean  "enable",                                     default: true
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
  end

  create_table "landlords", force: :cascade do |t|
    t.string   "firstname",                              null: false
    t.string   "lastname",                               null: false
    t.string   "address",                                null: false
    t.string   "zip_code",     limit: 9,                 null: false
    t.string   "email",                                  null: false
    t.string   "phone_number", limit: 15
    t.boolean  "enable",                  default: true, null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  create_table "last_periods_estates", id: false, force: :cascade do |t|
    t.integer  "estates_id"
    t.datetime "last_updated"
  end

  create_table "periods", force: :cascade do |t|
    t.string   "name",                                       null: false
    t.integer  "number_of_days",   limit: 4, default: 0
    t.integer  "number_of_months", limit: 2, default: 0
    t.boolean  "recycle_period",             default: false, null: false
    t.datetime "before_date"
    t.boolean  "enable",                     default: true
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  create_table "reminders", force: :cascade do |t|
    t.integer  "estate_id"
    t.integer  "period_id"
    t.datetime "date_to_pay"
    t.datetime "date_to_notify"
    t.integer  "status_id"
    t.boolean  "enable",         default: true, null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["estate_id"], name: "index_reminders_on_estate_id"
    t.index ["period_id"], name: "index_reminders_on_period_id"
  end

  create_table "status_reminder", id: false, force: :cascade do |t|
    t.integer "status_id"
    t.string  "name"
    t.index ["status_id"], name: "index_status_reminder_on_status_id"
  end

end
