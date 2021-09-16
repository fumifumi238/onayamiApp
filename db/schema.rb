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

ActiveRecord::Schema.define(version: 20_210_916_070_510) do
  create_table 'comments', charset: 'utf8mb4', force: :cascade do |t|
    t.text 'content'
    t.bigint 'user_id', null: false
    t.bigint 'micropost_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['micropost_id'], name: 'index_comments_on_micropost_id'
    t.index ['user_id'], name: 'index_comments_on_user_id'
  end

  create_table 'likes', charset: 'utf8mb4', force: :cascade do |t|
    t.bigint 'micropost_id', null: false
    t.bigint 'user_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['micropost_id'], name: 'index_likes_on_micropost_id'
    t.index ['user_id'], name: 'index_likes_on_user_id'
  end

  create_table 'microposts', charset: 'utf8mb4', force: :cascade do |t|
    t.text 'content'
    t.bigint 'user_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.boolean 'anonymous'
    t.index %w[user_id created_at], name: 'index_microposts_on_user_id_and_created_at'
    t.index ['user_id'], name: 'index_microposts_on_user_id'
  end

  create_table 'tag_relationships', charset: 'utf8mb4', force: :cascade do |t|
    t.bigint 'micropost_id', null: false
    t.bigint 'tag_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index %w[micropost_id tag_id], name: 'index_tag_relationships_on_micropost_id_and_tag_id', unique: true
    t.index ['micropost_id'], name: 'index_tag_relationships_on_micropost_id'
    t.index ['tag_id'], name: 'index_tag_relationships_on_tag_id'
  end

  create_table 'tags', charset: 'utf8mb4', force: :cascade do |t|
    t.string 'name', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'users', charset: 'utf8mb4', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.string 'name'
    t.boolean 'admin', default: false
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  add_foreign_key 'comments', 'microposts'
  add_foreign_key 'comments', 'users'
  add_foreign_key 'likes', 'microposts'
  add_foreign_key 'likes', 'users'
  add_foreign_key 'microposts', 'users'
  add_foreign_key 'tag_relationships', 'microposts'
  add_foreign_key 'tag_relationships', 'tags'
end
