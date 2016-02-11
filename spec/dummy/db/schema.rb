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

ActiveRecord::Schema.define(version: 20150529072537) do

  create_table "contacts", force: :cascade do |t|
    t.string   "composite_name"
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "prefix"
    t.string   "suffix"
    t.string   "nickname"
    t.string   "organization"
    t.string   "job_title"
    t.string   "department"
    t.date     "birthdate"
    t.text     "note"
    t.integer  "record_id",         default: 0
    t.datetime "creation_date"
    t.datetime "modification_date"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contacts", ["user_id", "record_id"], name: "index_contacts_on_user_id_and_record_id", unique: true
  add_index "contacts", ["user_id"], name: "index_contacts_on_user_id"

  create_table "emails", force: :cascade do |t|
    t.string   "label"
    t.string   "encrypted_email"
    t.integer  "contact_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "emails", ["encrypted_email"], name: "index_emails_on_encrypted_email"

  create_table "phones", force: :cascade do |t|
    t.string   "label"
    t.string   "encrypted_number"
    t.string   "cc_prefix"
    t.string   "extension"
    t.integer  "contact_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "phones", ["encrypted_number"], name: "index_phones_on_encrypted_number"

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "encrypted_number"
    t.string   "cc_prefix"
    t.datetime "last_contact_sync"
  end

  add_index "users", ["encrypted_number"], name: "index_users_on_encrypted_number"

end
