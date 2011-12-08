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

ActiveRecord::Schema.define(:version => 20111208130452) do

  create_table "meetings", :force => true do |t|
    t.string   "subject"
    t.string   "local"
    t.string   "admin"
    t.string   "link_admin"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "extra_info"
    t.string   "meeting_date"
    t.text     "topics"
    t.datetime "duration",     :limit => 255
    t.text     "minutes"
    t.datetime "meeting_time"
    t.string   "timezone"
  end

  create_table "participations", :force => true do |t|
    t.string   "token"
    t.integer  "is_attending"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "meeting_id"
    t.string   "action_item"
    t.string   "deadline"
  end

  create_table "users", :force => true do |t|
    t.string   "mail"
    t.string   "nome"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "circles"
  end

end
