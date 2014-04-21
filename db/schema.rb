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

ActiveRecord::Schema.define(version: 20140419203009) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "courses", force: true do |t|
    t.string   "subject",                        null: false
    t.integer  "teacher_id"
    t.string   "status",      default: "Active", null: false
    t.string   "school_year"
    t.integer  "period"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "rows"
    t.integer  "columns"
  end

  add_index "courses", ["teacher_id"], name: "index_courses_on_teacher_id", using: :btree

  create_table "enrollments", force: true do |t|
    t.integer  "student_id", null: false
    t.integer  "course_id",  null: false
    t.integer  "seat",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "enrollments", ["course_id"], name: "index_enrollments_on_course_id", using: :btree
  add_index "enrollments", ["student_id", "course_id"], name: "index_enrollments_on_student_id_and_course_id", unique: true, using: :btree
  add_index "enrollments", ["student_id"], name: "index_enrollments_on_student_id", using: :btree

  create_table "requests", force: true do |t|
    t.integer  "teacher_id"
    t.integer  "principal_id"
    t.string   "status",       default: "Pending", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "requests", ["principal_id"], name: "index_requests_on_principal_id", using: :btree
  add_index "requests", ["teacher_id"], name: "index_requests_on_teacher_id", using: :btree

  create_table "schools", force: true do |t|
    t.string   "name",         null: false
    t.string   "location",     null: false
    t.string   "phone_number"
    t.integer  "principal_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "schools", ["principal_id"], name: "index_schools_on_principal_id", using: :btree

  create_table "students", force: true do |t|
    t.string   "first_name",    null: false
    t.string   "last_name",     null: false
    t.string   "nickname"
    t.string   "dob"
    t.integer  "school_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "student_photo"
  end

  add_index "students", ["first_name"], name: "index_students_on_first_name", using: :btree

  create_table "teacher_assignments", force: true do |t|
    t.integer  "teacher_id"
    t.integer  "school_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "first_name",                             null: false
    t.string   "last_name",                              null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                  default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
