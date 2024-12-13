class CreateDepositRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :deposit_requests do |t|
      t.float :amount
      t.references :user, null: false, foreign_key: true
      t.integer :parent_user_id
      t.text :message
      t.references :depositreqeststatus, null: false, foreign_key: true
      t.datetime :last_updated

      t.timestamps
    end
  end
end
