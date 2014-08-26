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

ActiveRecord::Schema.define(version: 20140826202524) do

  create_table "omerta_logger_domains", force: true do |t|
    t.string   "name"
    t.string   "api_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "omerta_logger_families", force: true do |t|
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

  create_table "omerta_logger_user_family_histories", force: true do |t|
    t.integer  "user_id"
    t.integer  "family_id"
    t.datetime "date"
    t.integer  "family_role"
  end

  add_index "omerta_logger_user_family_histories", ["family_id"], name: "index_omerta_logger_user_family_histories_on_family_id"
  add_index "omerta_logger_user_family_histories", ["user_id"], name: "index_omerta_logger_user_family_histories_on_user_id"

  create_table "omerta_logger_user_rank_histories", force: true do |t|
    t.datetime "date"
    t.integer  "rank"
    t.integer  "user_id"
  end

  add_index "omerta_logger_user_rank_histories", ["user_id"], name: "index_omerta_logger_user_rank_histories_on_user_id"

  create_table "omerta_logger_users", force: true do |t|
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

  create_table "omerta_logger_versions", force: true do |t|
    t.string   "version"
    t.integer  "domain_id"
    t.datetime "start"
    t.datetime "end"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "omerta_logger_versions", ["domain_id"], name: "index_omerta_logger_versions_on_domain_id"

end
