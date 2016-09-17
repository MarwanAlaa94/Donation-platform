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

ActiveRecord::Schema.define(version: 20160917123825) do

  create_table "messages", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "subject"
    t.text     "contect"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "reply"
  end

  create_table "need_images", force: :cascade do |t|
    t.string   "caption"
    t.integer  "need_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.index ["need_id"], name: "index_need_images_on_need_id"
  end

  create_table "needs", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.date     "start_date"
    t.date     "end_date"
    t.boolean  "in_progress"
    t.float    "money"
    t.integer  "urgent_rate"
    t.boolean  "achievment_flag"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "organization_id"
    t.float    "donated_money"
    t.index ["organization_id"], name: "index_needs_on_organization_id"
  end

  create_table "needs_users", id: false, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "need_id", null: false
    t.index ["user_id", "need_id"], name: "index_needs_users_on_user_id_and_need_id"
  end

  create_table "org_images", force: :cascade do |t|
    t.string   "caption"
    t.integer  "organization_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "organization_searches", force: :cascade do |t|
    t.string   "org_name"
    t.string   "email"
    t.string   "info"
    t.string   "website_URL"
    t.string   "contacts"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "organizations", force: :cascade do |t|
    t.string   "org_name"
    t.string   "email"
    t.string   "password"
    t.string   "info"
    t.string   "website_URL"
    t.string   "contacts"
    t.string   "logo_url"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "password_digest"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.boolean  "isApproved",         default: false
  end

  create_table "payments", force: :cascade do |t|
    t.string   "need_name"
    t.integer  "need_id"
    t.integer  "org_id"
    t.integer  "user_id"
    t.float    "donated_money"
    t.string   "comment"
    t.boolean  "is_recieved"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "user_name"
    t.integer  "user_number"
    t.string   "user_address"
  end

  create_table "users", force: :cascade do |t|
    t.string   "user_name"
    t.string   "email"
    t.string   "password"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "password_digest"
    t.string   "avatar"
    t.boolean  "isAdmin",         default: false
  end

end
