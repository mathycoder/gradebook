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

ActiveRecord::Schema.define(version: 2019_07_25_135611) do

  create_table "admins", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "assignments", force: :cascade do |t|
    t.string "name"
    t.datetime "date"
    t.integer "learning_target_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "grades", force: :cascade do |t|
    t.decimal "score"
    t.integer "student_id"
    t.integer "assignment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "klass_learning_targets", force: :cascade do |t|
    t.integer "klass_id"
    t.integer "learning_target_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "klass_students", force: :cascade do |t|
    t.integer "klass_id"
    t.integer "student_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "klasses", force: :cascade do |t|
    t.string "name"
    t.string "subject"
    t.string "grade"
    t.integer "period"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "learning_targets", force: :cascade do |t|
    t.string "name"
    t.string "level1"
    t.string "level2"
    t.string "level3"
    t.string "level4"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "standard_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "email"
    t.string "type"
    t.string "password"
  end

  create_table "standards", force: :cascade do |t|
    t.string "name"
    t.string "grade"
    t.string "grade_id"
    t.string "api_standard_id"
    t.string "standard_notation"
    t.string "alt_standard_notation"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "students", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.integer "grade"
    t.integer "klass"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teacher_klasses", force: :cascade do |t|
    t.integer "teacher_id"
    t.integer "klass_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teachers", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "picture_url"
    t.integer "uid"
  end

end
