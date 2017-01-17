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

ActiveRecord::Schema.define(version: 20170117101240) do

  create_table "ckeditor_assets", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.string   "data_fingerprint"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
    t.index ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree
  end

  create_table "objective_validations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "objective_id"
    t.integer  "user_id"
    t.boolean  "passed"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["objective_id"], name: "index_objective_validations_on_objective_id", using: :btree
    t.index ["user_id"], name: "index_objective_validations_on_user_id", using: :btree
  end

  create_table "objectives", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.date     "date"
    t.integer  "status"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.integer  "project_id"
    t.text     "description",    limit: 65535
    t.boolean  "passed",                       default: false
    t.integer  "objective_type"
    t.index ["project_id"], name: "index_objectives_on_project_id", using: :btree
  end

  create_table "project_fundings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.integer  "spices"
    t.string   "comment"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "status",     default: 0
    t.index ["project_id"], name: "index_project_fundings_on_project_id", using: :btree
    t.index ["user_id"], name: "index_project_fundings_on_user_id", using: :btree
  end

  create_table "projects", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.text     "description", limit: 65535
    t.integer  "spices"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "user_id"
    t.integer  "status"
    t.index ["user_id"], name: "index_projects_on_user_id", using: :btree
  end

  create_table "sessions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "session_id",               null: false
    t.text     "data",       limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
    t.index ["updated_at"], name: "index_sessions_on_updated_at", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",      default: "", null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "role",       default: 0
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

  add_foreign_key "objective_validations", "objectives"
  add_foreign_key "objective_validations", "users"
  add_foreign_key "objectives", "projects"
  add_foreign_key "project_fundings", "projects"
  add_foreign_key "project_fundings", "users"
  add_foreign_key "projects", "users"
end
