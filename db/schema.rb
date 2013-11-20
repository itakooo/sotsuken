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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20131112001156) do

  create_table "accounts", :force => true do |t|
    t.string   "student_id"
    t.string   "name"
    t.integer  "major"
    t.string   "password"
    t.boolean  "admin"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "draws", :force => true do |t|
    t.string   "txt"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "emp_briefings", :force => true do |t|
    t.integer  "emp_id"
    t.date     "day"
    t.string   "location"
    t.text     "details"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "emp_briefings", ["emp_id"], :name => "index_emp_briefings_on_emp_id"

  create_table "emp_essays", :force => true do |t|
    t.integer  "emp_selection_id"
    t.integer  "time"
    t.text     "details"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "emp_essays", ["emp_selection_id"], :name => "index_emp_essays_on_emp_selection_id"

  create_table "emp_interviews", :force => true do |t|
    t.integer  "emp_selection_id"
    t.integer  "candidates"
    t.integer  "examiners"
    t.integer  "time"
    t.text     "details"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "emp_interviews", ["emp_selection_id"], :name => "index_emp_interviews_on_emp_selection_id"

  create_table "emp_selections", :force => true do |t|
    t.integer  "emp_id"
    t.integer  "glouping"
    t.date     "start"
    t.date     "end"
    t.string   "location"
    t.date     "result_date"
    t.boolean  "result"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "emp_selections", ["emp_id"], :name => "index_emp_selections_on_emp_id"

  create_table "emp_submissions", :force => true do |t|
    t.integer  "emp_id"
    t.boolean  "graduate"
    t.boolean  "result"
    t.boolean  "resume"
    t.boolean  "recommendation"
    t.boolean  "medical"
    t.string   "other"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "emp_submissions", ["emp_id"], :name => "index_emp_submissions_on_emp_id"

  create_table "emp_tests", :force => true do |t|
    t.integer  "emp_selection_id"
    t.integer  "kind"
    t.text     "details"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "emp_tests", ["emp_selection_id"], :name => "index_emp_tests_on_emp_selection_id"

  create_table "emp_webtests", :force => true do |t|
    t.integer  "emp_id"
    t.date     "day"
    t.string   "location"
    t.text     "details"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "emp_webtests", ["emp_id"], :name => "index_emp_webtests_on_emp_id"

  create_table "emps", :force => true do |t|
    t.integer  "account_id"
    t.string   "name"
    t.string   "location"
    t.boolean  "glouping"
    t.date     "submit"
    t.text     "entrysheet"
    t.text     "impression"
    t.text     "advice"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "emps", ["account_id"], :name => "index_emps_on_account_id"

  create_table "uni_apps", :force => true do |t|
    t.integer  "uni_id"
    t.date     "start"
    t.date     "end"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "uni_apps", ["uni_id"], :name => "index_uni_apps_on_uni_id"

  create_table "uni_exams", :force => true do |t|
    t.integer  "uni_id"
    t.date     "start"
    t.date     "end"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "uni_exams", ["uni_id"], :name => "index_uni_exams_on_uni_id"

  create_table "uni_interviews", :force => true do |t|
    t.integer  "uni_id"
    t.integer  "candidates"
    t.integer  "examiners"
    t.integer  "time"
    t.text     "deatails"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "uni_interviews", ["uni_id"], :name => "index_uni_interviews_on_uni_id"

  create_table "uni_results", :force => true do |t|
    t.integer  "uni_id"
    t.date     "day"
    t.boolean  "result"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "uni_results", ["uni_id"], :name => "index_uni_results_on_uni_id"

  create_table "uni_subjects", :force => true do |t|
    t.integer  "uni_id"
    t.string   "subject"
    t.text     "details"
    t.integer  "time"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "uni_subjects", ["uni_id"], :name => "index_uni_subjects_on_uni_id"

  create_table "uni_submissions", :force => true do |t|
    t.integer  "uni_id"
    t.boolean  "result"
    t.boolean  "survey"
    t.boolean  "recommendation"
    t.string   "other"
    t.boolean  "reason"
    t.text     "reason_details"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "uni_submissions", ["uni_id"], :name => "index_uni_submissions_on_uni_id"

  create_table "unis", :force => true do |t|
    t.integer  "account_id"
    t.string   "name"
    t.string   "major"
    t.string   "location"
    t.boolean  "glouping"
    t.text     "impression"
    t.text     "advice"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "gmaps"
  end

  add_index "unis", ["account_id"], :name => "index_unis_on_account_id"

end
