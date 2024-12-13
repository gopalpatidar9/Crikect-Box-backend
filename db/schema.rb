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

ActiveRecord::Schema[7.0].define(version: 2024_08_13_144022) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "bet_statuses", force: :cascade do |t|
    t.string "name"
    t.integer "order"
    t.boolean "is_active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bets", force: :cascade do |t|
    t.integer "team_number"
    t.string "odd_type"
    t.float "odd_value"
    t.string "team_name"
    t.integer "team_id"
    t.integer "mid"
    t.decimal "amount"
    t.integer "user_id", null: false
    t.string "match_title"
    t.integer "bet_status_id", null: false
    t.decimal "potential_payout"
    t.integer "live_odds_type_id", null: false
    t.integer "match_id"
    t.datetime "completed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bet_status_id"], name: "index_bets_on_bet_status_id"
    t.index ["live_odds_type_id"], name: "index_bets_on_live_odds_type_id"
    t.index ["user_id"], name: "index_bets_on_user_id"
  end

  create_table "billing_preferences", force: :cascade do |t|
    t.integer "user_id", null: false
    t.float "commission_percentahe"
    t.integer "monthly_fee"
    t.boolean "payment_gateway_activated"
    t.datetime "last_commission_payment_time"
    t.datetime "last_monthly_fee_payment_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_billing_preferences_on_user_id"
  end

  create_table "carts", force: :cascade do |t|
    t.integer "team_number"
    t.string "odd_type"
    t.float "odd_value"
    t.string "team_name"
    t.integer "team_id"
    t.integer "mid"
    t.decimal "amount"
    t.integer "user_id", null: false
    t.string "match_title"
    t.integer "live_odds_type_id", null: false
    t.integer "match_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["live_odds_type_id"], name: "index_carts_on_live_odds_type_id"
    t.index ["match_id"], name: "index_carts_on_match_id"
    t.index ["user_id"], name: "index_carts_on_user_id"
  end

  create_table "chat_room_users", force: :cascade do |t|
    t.integer "chat_room_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chat_room_id"], name: "index_chat_room_users_on_chat_room_id"
    t.index ["user_id"], name: "index_chat_room_users_on_user_id"
  end

  create_table "chat_rooms", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "competitions", force: :cascade do |t|
    t.integer "cid"
    t.string "title"
    t.string "abbr"
    t.string "category"
    t.string "status"
    t.string "game_formate"
    t.datetime "date_start"
    t.datetime "date_end"
    t.string "country"
    t.integer "total_matches"
    t.integer "total_rounds"
    t.integer "total_teams"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "season"
  end

  create_table "deposit_request_statuses", force: :cascade do |t|
    t.string "name"
    t.integer "order"
    t.boolean "is_active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "deposit_requests", force: :cascade do |t|
    t.float "amount"
    t.integer "user_id", null: false
    t.integer "parent_user_id"
    t.text "message"
    t.datetime "last_updated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "deposit_request_status_id", null: false
    t.index ["deposit_request_status_id"], name: "index_deposit_requests_on_deposit_request_status_id"
    t.index ["user_id"], name: "index_deposit_requests_on_user_id"
  end

  create_table "live_odds_types", force: :cascade do |t|
    t.string "odds_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "match_statuses", force: :cascade do |t|
    t.string "name"
    t.integer "order"
    t.boolean "is_active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "matches", force: :cascade do |t|
    t.integer "mid"
    t.string "title"
    t.string "status_str"
    t.string "status_note"
    t.boolean "odds_available"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string "result"
    t.string "win_margin"
    t.integer "winning_team_id"
    t.integer "latest_inning_number"
    t.integer "competition_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "match_status_id", null: false
    t.index ["competition_id"], name: "index_matches_on_competition_id"
    t.index ["match_status_id"], name: "index_matches_on_match_status_id"
  end

  create_table "messages", force: :cascade do |t|
    t.integer "chat_room_id", null: false
    t.integer "user_id", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chat_room_id"], name: "index_messages_on_chat_room_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "recipient_id"
    t.integer "sender_id"
    t.text "message"
    t.string "notification_type"
    t.boolean "is_read"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipient_id"], name: "index_notifications_on_recipient_id"
    t.index ["sender_id"], name: "index_notifications_on_sender_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.boolean "is_active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "settle_odds", force: :cascade do |t|
    t.string "team_batting"
    t.string "title"
    t.string "back_condition"
    t.float "back"
    t.string "lay_condition"
    t.float "lay"
    t.boolean "status"
    t.string "settle"
    t.string "settle_type"
    t.datetime "settle_titme"
    t.boolean "verified"
    t.datetime "verified_time"
    t.integer "question_id"
    t.integer "match_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id"], name: "index_settle_odds_on_match_id"
  end

  create_table "teama_odds", force: :cascade do |t|
    t.string "live_odds_type"
    t.float "back"
    t.float "lay"
    t.float "back_volume"
    t.float "lay_volume"
    t.integer "match_id", null: false
    t.integer "mid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id"], name: "index_teama_odds_on_match_id"
  end

  create_table "teamas", force: :cascade do |t|
    t.integer "tid"
    t.string "name"
    t.string "short_name"
    t.string "logoUrl"
    t.integer "scores_full"
    t.integer "scores"
    t.integer "overs"
    t.integer "match_id", null: false
    t.integer "mid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id"], name: "index_teamas_on_match_id"
  end

  create_table "teamb_odds", force: :cascade do |t|
    t.string "live_odds_type"
    t.float "back"
    t.float "lay"
    t.float "back_volume"
    t.float "lay_volume"
    t.integer "match_id", null: false
    t.integer "mid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id"], name: "index_teamb_odds_on_match_id"
  end

  create_table "teambs", force: :cascade do |t|
    t.integer "tid"
    t.string "name"
    t.string "short_name"
    t.string "logoUrl"
    t.integer "scores_full"
    t.integer "scores"
    t.integer "overs"
    t.integer "match_id", null: false
    t.integer "mid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id"], name: "index_teambs_on_match_id"
  end

  create_table "transaction_types", force: :cascade do |t|
    t.string "name"
    t.integer "order"
    t.boolean "is_active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "wallet_id", null: false
    t.integer "transaction_type_id", null: false
    t.float "amount"
    t.text "description"
    t.integer "bet_id"
    t.integer "transferred_to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["transaction_type_id"], name: "index_transactions_on_transaction_type_id"
    t.index ["user_id"], name: "index_transactions_on_user_id"
    t.index ["wallet_id"], name: "index_transactions_on_wallet_id"
  end

  create_table "user_details", force: :cascade do |t|
    t.integer "parentuserid"
    t.string "profilepicture"
    t.boolean "deposit_request_enabled"
    t.boolean "chats_enabled"
    t.boolean "can_add_user"
    t.boolean "bet_enabled"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_details_on_user_id"
  end

  create_table "user_roles", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "role_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id"], name: "index_user_roles_on_role_id"
    t.index ["user_id"], name: "index_user_roles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "name"
    t.string "username"
    t.integer "mobilephone"
    t.string "email"
    t.integer "external_id"
    t.datetime "last_login"
    t.boolean "is_active"
    t.text "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "parent_user_id"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  create_table "wallets", force: :cascade do |t|
    t.integer "user_id", null: false
    t.float "balance"
    t.datetime "lastupdated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_wallets_on_user_id"
  end

  create_table "withdrawal_request_statuses", force: :cascade do |t|
    t.string "name"
    t.integer "order"
    t.boolean "is_active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "withdrawal_requests", force: :cascade do |t|
    t.string "name"
    t.integer "order"
    t.boolean "is_active"
    t.datetime "Request_datetime"
    t.datetime "response_datetime"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "withdrawal_request_status_id", null: false
    t.index ["withdrawal_request_status_id"], name: "index_withdrawal_requests_on_withdrawal_request_status_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "bets", "bet_statuses"
  add_foreign_key "bets", "live_odds_types"
  add_foreign_key "bets", "users"
  add_foreign_key "billing_preferences", "users"
  add_foreign_key "carts", "live_odds_types"
  add_foreign_key "carts", "matches"
  add_foreign_key "carts", "users"
  add_foreign_key "chat_room_users", "chat_rooms"
  add_foreign_key "chat_room_users", "users"
  add_foreign_key "deposit_requests", "deposit_request_statuses"
  add_foreign_key "deposit_requests", "users"
  add_foreign_key "matches", "competitions"
  add_foreign_key "matches", "match_statuses"
  add_foreign_key "messages", "chat_rooms"
  add_foreign_key "messages", "users"
  add_foreign_key "notifications", "users", column: "recipient_id"
  add_foreign_key "notifications", "users", column: "sender_id"
  add_foreign_key "settle_odds", "matches"
  add_foreign_key "teama_odds", "matches"
  add_foreign_key "teamas", "matches"
  add_foreign_key "teamb_odds", "matches"
  add_foreign_key "teambs", "matches"
  add_foreign_key "transactions", "transaction_types"
  add_foreign_key "transactions", "users"
  add_foreign_key "transactions", "wallets"
  add_foreign_key "user_details", "users"
  add_foreign_key "user_roles", "roles"
  add_foreign_key "user_roles", "users"
  add_foreign_key "wallets", "users"
  add_foreign_key "withdrawal_requests", "withdrawal_request_statuses"
end
