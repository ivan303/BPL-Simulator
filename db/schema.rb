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

ActiveRecord::Schema.define(version: 20150211163745) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clubs", force: true do |t|
    t.string   "name"
    t.integer  "stadion_id"
    t.integer  "budget"
    t.integer  "stats"
    t.integer  "coach_id"
    t.integer  "established"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.boolean  "chosen",       default: false
    t.integer  "points",       default: 0
    t.integer  "goals_scored", default: 0
    t.integer  "goals_lost",   default: 0
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
    t.integer  "round"
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
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.boolean  "injury",        default: false
    t.integer  "cost",          default: 0
  end

  add_index "players", ["injury"], name: "index_players_on_injury", using: :btree

  create_table "schedules", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "round"
    t.integer  "host"
    t.integer  "visitor"
  end

  create_table "scorers", force: true do |t|
    t.integer  "match_id"
    t.integer  "club_id"
    t.integer  "player_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "transfers", force: true do |t|
    t.integer  "player_id"
    t.integer  "sealing_club"
    t.integer  "buying_club"
    t.integer  "cost"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

end
