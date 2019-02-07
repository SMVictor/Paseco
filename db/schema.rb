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

ActiveRecord::Schema.define(version: 2019_02_06_224526) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "customers", force: :cascade do |t|
    t.string "business_name"
    t.string "tradename"
    t.string "representative_id"
    t.string "representative_name"
    t.string "legal_document"
    t.string "start_date"
    t.string "end_date"
    t.string "contact"
    t.string "email"
    t.string "email_1"
    t.string "email_2"
    t.string "phone_number"
    t.string "phone_number_1"
    t.string "payment_method"
    t.string "payment_conditions"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "employees", force: :cascade do |t|
    t.string "name"
    t.string "gender"
    t.string "id_type"
    t.string "identification"
    t.string "birthday"
    t.string "start_date"
    t.string "end_date"
    t.string "province"
    t.string "canton"
    t.string "district"
    t.string "other"
    t.string "phone"
    t.string "phone_1"
    t.string "emergency_contact"
    t.string "emergency_number"
    t.string "payment_method"
    t.string "bank"
    t.string "account"
    t.string "ccss_number"
    t.string "social_security"
    t.string "daily_viatical"
    t.string "ccss_type"
    t.bigint "position_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["position_id"], name: "index_employees_on_position_id"
  end

  create_table "employees_stalls", id: false, force: :cascade do |t|
    t.bigint "stall_id", null: false
    t.bigint "employee_id", null: false
    t.index ["stall_id", "employee_id"], name: "index_employees_stalls_on_stall_id_and_employee_id"
  end

  create_table "payments", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payrole_lines", force: :cascade do |t|
    t.string "min_salary"
    t.string "extra_hours"
    t.string "daily_viatical"
    t.string "ccss_deduction"
    t.string "net_salary"
    t.string "extra_payments"
    t.string "deductions"
    t.bigint "role_id"
    t.bigint "employee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_payrole_lines_on_employee_id"
    t.index ["role_id"], name: "index_payrole_lines_on_role_id"
  end

  create_table "positions", force: :cascade do |t|
    t.string "name"
    t.string "salary"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "requirements", force: :cascade do |t|
    t.string "name"
    t.string "shifts"
    t.string "hours"
    t.string "workers"
    t.bigint "stall_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stall_id"], name: "index_requirements_on_stall_id"
  end

  create_table "role_lines", force: :cascade do |t|
    t.string "date"
    t.string "substall"
    t.string "hours"
    t.bigint "role_id"
    t.bigint "employee_id"
    t.bigint "stall_id"
    t.bigint "shift_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "comment"
    t.string "extra_payments"
    t.string "extra_payments_description"
    t.string "deductions"
    t.string "deductions_description"
    t.string "state"
    t.index ["employee_id"], name: "index_role_lines_on_employee_id"
    t.index ["role_id"], name: "index_role_lines_on_role_id"
    t.index ["shift_id"], name: "index_role_lines_on_shift_id"
    t.index ["stall_id"], name: "index_role_lines_on_stall_id"
  end

  create_table "role_lines_copies", force: :cascade do |t|
    t.string "date"
    t.string "substall"
    t.string "hours"
    t.integer "employee_id"
    t.integer "shift_id"
    t.integer "stall_id"
    t.integer "role_id"
    t.string "comment"
    t.string "action"
    t.bigint "role_line_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_line_id"], name: "index_role_lines_copies_on_role_line_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "start_date"
    t.string "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles_stalls", id: false, force: :cascade do |t|
    t.bigint "stall_id", null: false
    t.bigint "role_id", null: false
    t.index ["stall_id", "role_id"], name: "index_roles_stalls_on_stall_id_and_role_id"
  end

  create_table "shifts", force: :cascade do |t|
    t.string "name"
    t.string "time"
    t.string "cost"
    t.string "extra_time_cost"
    t.bigint "payment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["payment_id"], name: "index_shifts_on_payment_id"
  end

  create_table "stalls", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "province"
    t.string "canton"
    t.string "district"
    t.string "other"
    t.string "daily_viatical"
    t.string "extra_shift"
    t.string "min_salary"
    t.string "substalls"
    t.bigint "customer_id"
    t.bigint "payment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_stalls_on_customer_id"
    t.index ["payment_id"], name: "index_stalls_on_payment_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "name", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
