# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_02_26_143418) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "assigned_courses", force: :cascade do |t|
    t.boolean "pass", default: false, null: false
    t.float "assessment_score"
    t.datetime "date_completed"
    t.integer "progress_status", default: 0
    t.bigint "user_id", null: false
    t.bigint "course_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "progress_id"
    t.integer "row_order"
    t.index ["course_id"], name: "index_assigned_courses_on_course_id"
    t.index ["progress_id"], name: "index_assigned_courses_on_progress_id"
    t.index ["user_id"], name: "index_assigned_courses_on_user_id"
  end

  create_table "badges", force: :cascade do |t|
    t.integer "rank", default: 0
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_badges_on_user_id"
  end

  create_table "certificates", force: :cascade do |t|
    t.string "title"
    t.integer "source", default: 0, null: false
    t.datetime "date_awarded"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_certificates_on_user_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "title"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.string "author"
    t.string "url"
    t.integer "category", default: 0
    t.float "impact", default: 0.0
    t.index ["slug"], name: "index_courses_on_slug", unique: true
    t.index ["user_id"], name: "index_courses_on_user_id"
  end

  create_table "leaderboards", force: :cascade do |t|
    t.bigint "assigned_course_id", null: false
    t.bigint "user_skill_map_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assigned_course_id"], name: "index_leaderboards_on_assigned_course_id"
    t.index ["user_skill_map_id"], name: "index_leaderboards_on_user_skill_map_id"
  end

  create_table "levels", force: :cascade do |t|
    t.integer "lvl", default: 1
    t.float "points", default: 0.0
    t.string "levelable_type", null: false
    t.bigint "levelable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["levelable_type", "levelable_id"], name: "index_levels_on_levelable"
  end

  create_table "progresses", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "row_order"
  end

  create_table "role_skill_maps", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.float "management_skill", default: 0.0
    t.float "technical_skill", default: 0.0
    t.float "communication_skill", default: 0.0
    t.float "financial_skill", default: 0.0
    t.float "analytical_skill", default: 0.0
    t.float "work_ethics", default: 0.0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["slug"], name: "index_role_skill_maps_on_slug", unique: true
  end

  create_table "user_skill_maps", force: :cascade do |t|
    t.float "management_skill", default: 0.0
    t.float "technical_skill", default: 0.0
    t.float "communication_skill", default: 0.0
    t.float "financial_skill", default: 0.0
    t.float "analytical_skill", default: 0.0
    t.float "work_ethics", default: 0.0
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_skill_maps_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "username"
    t.string "first_name"
    t.string "last_name"
    t.integer "role", default: 0
    t.string "uid"
    t.string "avatar_url"
    t.string "provider"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "assigned_courses", "courses"
  add_foreign_key "assigned_courses", "progresses"
  add_foreign_key "assigned_courses", "users"
  add_foreign_key "badges", "users"
  add_foreign_key "certificates", "users"
  add_foreign_key "courses", "users"
  add_foreign_key "leaderboards", "assigned_courses"
  add_foreign_key "leaderboards", "user_skill_maps"
  add_foreign_key "user_skill_maps", "users"
end
