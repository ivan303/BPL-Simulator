# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150203153031) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clubs", force: true do |t|
    t.string   "name"
    t.integer  "stadion_id"
    t.integer  "budget"
    t.integer  "stats"
    t.integer  "coach_id"
    t.integer  "established"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "chosen",      default: false
  end

  create_table "coaches", force: true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.date     "birthdate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "matches", force: true do |t|
    t.string   "result"
    t.integer  "host_goals"
    t.integer  "visitor_goals"
    t.integer  "host_club_id"
    t.integer  "visitor_club_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "players", force: true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "commonname"
    t.string   "position"
    t.date     "birthdate"
    t.integer  "overallrating"
    t.integer  "potential"
    t.integer  "club_id"
    t.string   "nationality"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "schedules", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "0"
    t.string   "1"
    t.string   "2"
    t.string   "3"
    t.string   "4"
    t.string   "5"
    t.string   "6"
    t.string   "7"
    t.string   "8"
    t.string   "9"
    t.string   "10"
    t.string   "11"
    t.string   "12"
    t.string   "13"
    t.string   "14"
    t.string   "15"
    t.string   "16"
    t.string   "17"
    t.string   "18"
    t.string   "19"
  end

  create_table "season_infos", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "club_name"
    t.integer  "round"
  end

  create_table "stadions", force: true do |t|
    t.string   "name"
    t.integer  "capacity"
    t.integer  "year_of_construction"
    t.string   "city"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "stadiums", force: true do |t|
    t.string   "name"
    t.integer  "capacity"
    t.integer  "year_of_construction"
    t.string   "city"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

end
