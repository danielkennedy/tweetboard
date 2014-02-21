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

ActiveRecord::Schema.define(version: 20140220205329) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "notes", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reports", force: true do |t|
    t.string   "positive_tweet_1"
    t.string   "positive_tweet_2"
    t.string   "positive_tweet_3"
    t.string   "negative_tweet_1"
    t.string   "negative_tweet_2"
    t.string   "negative_tweet_3"
    t.integer  "score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "settings", force: true do |t|
    t.string   "twitter_consumer_key"
    t.string   "twitter_consumer_secret"
    t.string   "twitter_access_token"
    t.string   "twitter_access_token_secret"
    t.string   "alchemy_api_key"
    t.string   "twitter_search_string"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tweets", force: true do |t|
    t.string   "text"
    t.string   "user"
    t.string   "handle"
    t.integer  "follower_count"
    t.integer  "retweet_count"
    t.integer  "favorite_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
