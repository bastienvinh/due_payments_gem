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

ActiveRecord::Schema.define(version: 20161213142758) do

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
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "landlords", force: :cascade do |t|
    t.string   "firstname",               null: false
    t.string   "lastname",                null: false
    t.string   "address",                 null: false
    t.string   "zip_code",     limit: 9,  null: false
    t.string   "phone_number", limit: 15
    t.string   "email",                   null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "last_periods_estates", id: false, force: :cascade do |t|
    t.integer  "estates_id"
    t.datetime "last_updated"
  end

  create_table "periods", force: :cascade do |t|
    t.string   "name",                                     null: false
    t.integer  "number_of_days", limit: 4
    t.boolean  "recycle_period",           default: false, null: false
    t.datetime "before_date"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

end
