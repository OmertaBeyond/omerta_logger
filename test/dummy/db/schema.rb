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

ActiveRecord::Schema.define(version: 20150206221348) do

  create_table "omerta_logger_domains", force: :cascade do |t|
    t.string   "name"
    t.string   "api_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "omerta_logger_families", force: :cascade do |t|
    t.integer  "ext_family_id"
    t.integer  "version_id"
    t.string   "name"
    t.integer  "worth"
    t.integer  "rank"
    t.integer  "user_count"
    t.integer  "hq"
    t.string   "color"
    t.integer  "bank"
    t.integer  "city"
    t.integer  "don_id"
    t.integer  "sotto_id"
    t.integer  "consig_id"
    t.datetime "first_seen"
    t.boolean  "alive"
    t.datetime "death_date"
    t.integer  "rip_topic"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "omerta_logger_families", ["version_id"], name: "index_omerta_logger_families_on_version_id"

  create_table "omerta_logger_family_name_histories", force: :cascade do |t|
    t.string   "name"
    t.datetime "date"
    t.integer  "family_id"
  end

  add_index "omerta_logger_family_name_histories", ["family_id"], name: "index_omerta_logger_family_name_histories_on_family_id"

  create_table "omerta_logger_family_rank_histories", force: :cascade do |t|
    t.datetime "date"
    t.integer  "rank"
    t.integer  "family_id"
  end

  add_index "omerta_logger_family_rank_histories", ["family_id"], name: "index_omerta_logger_family_rank_histories_on_family_id"

  create_table "omerta_logger_game_statistics", force: :cascade do |t|
    t.datetime "date"
    t.integer  "version_id"
    t.integer  "users_total"
    t.integer  "users_alive"
    t.integer  "users_dead"
    t.integer  "lackeys_working"
    t.integer  "users_online_now"
    t.integer  "users_online_today"
    t.integer  "users_online_week"
    t.integer  "registrations_today"
    t.integer  "registrations_week"
    t.integer  "bullets",             limit: 8
    t.integer  "money_pocket",        limit: 8
    t.integer  "money_bank",          limit: 8
    t.integer  "money_familybank",    limit: 8
    t.integer  "honorpoints"
    t.integer  "car_attempts"
    t.integer  "crime_attempts"
    t.integer  "bustouts"
    t.integer  "cars"
  end

  add_index "omerta_logger_game_statistics", ["version_id"], name: "index_omerta_logger_game_statistics_on_version_id"

  create_table "omerta_logger_hitlists", force: :cascade do |t|
    t.integer  "ext_hitlist_id"
    t.integer  "version_id"
    t.datetime "date"
    t.integer  "amount"
    t.integer  "target_id"
    t.integer  "hitlister_id"
  end

  create_table "omerta_logger_user_family_histories", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "family_id"
    t.datetime "date"
    t.integer  "family_role"
  end

  add_index "omerta_logger_user_family_histories", ["family_id"], name: "index_omerta_logger_user_family_histories_on_family_id"
  add_index "omerta_logger_user_family_histories", ["user_id"], name: "index_omerta_logger_user_family_histories_on_user_id"

  create_table "omerta_logger_user_name_histories", force: :cascade do |t|
    t.string   "name"
    t.datetime "date"
    t.integer  "user_id"
  end

  add_index "omerta_logger_user_name_histories", ["user_id"], name: "index_omerta_logger_user_name_histories_on_user_id"

  create_table "omerta_logger_user_online_times", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "start"
    t.datetime "end"
  end

  add_index "omerta_logger_user_online_times", ["user_id"], name: "index_omerta_logger_user_online_times_on_user_id"

  create_table "omerta_logger_user_rank_histories", force: :cascade do |t|
    t.datetime "date"
    t.integer  "rank"
    t.integer  "user_id"
  end

  add_index "omerta_logger_user_rank_histories", ["user_id"], name: "index_omerta_logger_user_rank_histories_on_user_id"

  create_table "omerta_logger_user_revives", force: :cascade do |t|
    t.datetime "date"
    t.integer  "user_id"
  end

  add_index "omerta_logger_user_revives", ["user_id"], name: "index_omerta_logger_user_revives_on_user_id"

  create_table "omerta_logger_users", force: :cascade do |t|
    t.integer  "ext_user_id"
    t.integer  "version_id"
    t.string   "name"
    t.integer  "gender"
    t.integer  "rank"
    t.integer  "honor_points"
    t.integer  "level"
    t.boolean  "donor"
    t.datetime "first_seen"
    t.datetime "last_seen"
    t.integer  "family_id"
    t.integer  "family_role"
    t.boolean  "alive"
    t.boolean  "akill"
    t.datetime "death_date"
    t.string   "death_family"
    t.boolean  "died_without_family"
    t.integer  "rip_topic"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "online_time_seconds", default: 0
  end

  add_index "omerta_logger_users", ["family_id"], name: "index_omerta_logger_users_on_family_id"
  add_index "omerta_logger_users", ["version_id"], name: "index_omerta_logger_users_on_version_id"

  create_table "omerta_logger_version_updates", force: :cascade do |t|
    t.integer  "version_id"
    t.datetime "generated"
    t.float    "duration"
  end

  add_index "omerta_logger_version_updates", ["version_id"], name: "index_omerta_logger_version_updates_on_version_id"

  create_table "omerta_logger_versions", force: :cascade do |t|
    t.string   "version"
    t.integer  "domain_id"
    t.datetime "start"
    t.datetime "end"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "omerta_logger_versions", ["domain_id"], name: "index_omerta_logger_versions_on_domain_id"

end
