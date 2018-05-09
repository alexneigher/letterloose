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

ActiveRecord::Schema.define(version: 20171111211618) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "daily_wit_stops", force: :cascade do |t|
    t.integer  "description_id"
    t.integer  "user_id"
    t.boolean  "sent",           default: false
    t.datetime "sent_at"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.index ["description_id"], name: "index_daily_wit_stops_on_description_id", using: :btree
    t.index ["user_id"], name: "index_daily_wit_stops_on_user_id", using: :btree
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree
  end

  create_table "descriptions", force: :cascade do |t|
    t.text     "text"
    t.integer  "tweak_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "user_id"
    t.integer  "likes_count", default: 0
    t.index ["tweak_id"], name: "index_descriptions_on_tweak_id", using: :btree
    t.index ["user_id"], name: "index_descriptions_on_user_id", using: :btree
  end

  create_table "email_preferences", force: :cascade do |t|
    t.integer  "user_id"
    t.boolean  "wit_stop",             default: true
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.boolean  "upvote_notifications", default: true
    t.index ["user_id"], name: "index_email_preferences_on_user_id", using: :btree
  end

  create_table "likes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "description_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.boolean  "acknowledged",   default: false
    t.index ["description_id"], name: "index_likes_on_description_id", using: :btree
    t.index ["user_id"], name: "index_likes_on_user_id", using: :btree
  end

  create_table "titles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "category_id"
    t.integer  "user_id"
    t.index ["category_id"], name: "index_titles_on_category_id", using: :btree
    t.index ["user_id"], name: "index_titles_on_user_id", using: :btree
  end

  create_table "tweaks", force: :cascade do |t|
    t.string   "name"
    t.integer  "title_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.index ["title_id"], name: "index_tweaks_on_title_id", using: :btree
    t.index ["user_id"], name: "index_tweaks_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "username"
    t.string   "fullname"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "admin",                  default: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "daily_wit_stops", "descriptions"
  add_foreign_key "daily_wit_stops", "users"
  add_foreign_key "descriptions", "tweaks"
  add_foreign_key "email_preferences", "users"
  add_foreign_key "likes", "descriptions"
  add_foreign_key "likes", "users"
  add_foreign_key "tweaks", "titles"
end
