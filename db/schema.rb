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

ActiveRecord::Schema.define(:version => 20110213064818) do

  create_table "account", :force => true do |t|
    t.integer "user_id",                                                :null => false
    t.string  "currency", :limit => 128,                                :null => false
    t.decimal "count",                   :precision => 20, :scale => 4, :null => false
  end

  create_table "history", :force => true do |t|
    t.integer  "invest_id",                                 :null => false
    t.decimal  "local",      :precision => 20, :scale => 4, :null => false
    t.decimal  "rate",       :precision => 20, :scale => 4, :null => false
    t.decimal  "unit",       :precision => 20, :scale => 4, :null => false
    t.decimal  "price",      :precision => 20, :scale => 4, :null => false
    t.decimal  "commission", :precision => 20, :scale => 4, :null => false
    t.datetime "timestamp",                                 :null => false
  end

  create_table "invest", :force => true do |t|
    t.integer "account_id",                :null => false
    t.string  "name",       :limit => 128, :null => false
    t.string  "kind",       :limit => 128, :null => false
    t.string  "currency",   :limit => 128, :null => false
  end

  create_table "quote_histories", :force => true do |t|
    t.string   "quote_id"
    t.float    "price"
    t.string   "currency"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quotes", :force => true do |t|
    t.string   "quote_id"
    t.string   "name"
    t.string   "quote_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user", :force => true do |t|
    t.string "username", :limit => 128, :null => false
    t.string "password", :limit => 128, :null => false
    t.string "nickname", :limit => 128, :null => false
    t.string "email",    :limit => 128, :null => false
  end

end
