class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.integer :recipient_id
      t.integer :sender_id
      t.text :message
      t.string :type
      t.boolean :is_read

      t.timestamps
    end
  end
end
