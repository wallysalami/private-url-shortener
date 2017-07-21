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

ActiveRecord::Schema.define(version: 20170721150812) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "shortened_url_accesses", force: :cascade do |t|
    t.bigint "shortened_url_id", null: false
    t.string "ip", null: false
    t.string "referer"
    t.string "country_name"
    t.string "region_code"
    t.string "region_name"
    t.string "city"
    t.string "time_zone"
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shortened_url_id"], name: "index_shortened_url_accesses_on_shortened_url_id"
  end

  create_table "shortened_urls", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "short_uri", null: false
    t.string "destination_url", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["short_uri"], name: "index_shortened_urls_on_short_uri"
    t.index ["user_id"], name: "index_shortened_urls_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "full_name", null: false
    t.string "username", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "shortened_url_accesses", "shortened_urls"
  add_foreign_key "shortened_urls", "users"
end
