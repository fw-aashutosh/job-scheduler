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

ActiveRecord::Schema[7.1].define(version: 2024_08_02_101624) do
  create_table "job_schedules", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.string "interval_type"
    t.integer "interval_value"
    t.string "time_of_day"
    t.integer "job_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_job_schedules_on_job_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "task_execution_id"
    t.index ["task_execution_id"], name: "index_jobs_on_task_execution_id"
  end

  create_table "task_executions", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "job_id"
    t.index ["job_id"], name: "index_task_executions_on_job_id"
  end

  add_foreign_key "job_schedules", "jobs"
  add_foreign_key "jobs", "task_executions"
  add_foreign_key "task_executions", "jobs"
end
