class AddForeignKeyToNotifications < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :notifications, :users, column: :recipient_id
    add_foreign_key :notifications, :users, column: :sender_id

    add_index :notifications, :recipient_id
    add_index :notifications, :sender_id
  end
end
