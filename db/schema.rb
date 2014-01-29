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

ActiveRecord::Schema.define(version: 20140129002034) do

  create_table "comments", force: true do |t|
    t.integer  "user_id"
    t.integer  "commentable_id",   null: false
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "commentable_type", null: false
  end

  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type", using: :btree

  create_table "content_needs", force: true do |t|
    t.integer "content_id"
    t.integer "need_id"
  end

  add_index "content_needs", ["content_id", "need_id"], name: "index_content_needs_on_content_id_and_need_id", using: :btree

  create_table "content_plan_contents", force: true do |t|
    t.integer  "content_plan_id"
    t.integer  "content_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "content_plan_needs", force: true do |t|
    t.integer "content_plan_id"
    t.integer "need_id"
  end

  add_index "content_plan_needs", ["content_plan_id", "need_id"], name: "index_content_plan_needs_on_content_plan_id_and_need_id", using: :btree

  create_table "content_plans", force: true do |t|
    t.string   "ref_no"
    t.string   "title"
    t.text     "details"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "due_quarter"
    t.integer  "due_year"
  end

  create_table "content_users", force: true do |t|
    t.integer "content_id"
    t.integer "user_id"
  end

  add_index "content_users", ["content_id", "user_id"], name: "index_content_users_on_content_id_and_user_id", using: :btree

  create_table "contents", force: true do |t|
    t.text     "url"
    t.string   "content_type"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "platform"
    t.integer  "size"
    t.string   "title",        null: false
    t.text     "description"
  end

  create_table "organisationables", force: true do |t|
    t.string   "organisation_id"
    t.integer  "organisationable_id"
    t.string   "organisationable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "organisationables", ["organisation_id"], name: "index_organisationables_on_organisation_id", using: :btree
  add_index "organisationables", ["organisationable_id", "organisationable_type"], name: "organisationables", using: :btree
  add_index "organisationables", ["organisationable_type", "organisation_id"], name: "organisationable_type", using: :btree
  add_index "organisationables", ["organisationable_type"], name: "index_organisationables_on_organisationable_type", using: :btree

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: true do |t|
    t.string "name"
  end

  create_table "tasks", force: true do |t|
    t.string   "title"
    t.boolean  "done"
    t.integer  "content_plan_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",               default: "",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "uid"
    t.string   "organisation_slug"
    t.string   "permissions"
    t.boolean  "remotely_signed_out", default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["organisation_slug"], name: "index_users_on_organisation_slug", using: :btree
  add_index "users", ["uid"], name: "index_users_on_uid", using: :btree

  create_table "versions", force: true do |t|
    t.string   "item_type",      null: false
    t.integer  "item_id",        null: false
    t.string   "event",          null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
    t.text     "object_changes"
    t.string   "user_name"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
