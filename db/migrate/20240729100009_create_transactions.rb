class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :wallet, null: false, foreign_key: true
      t.references :transaction_type, null: false, foreign_key: true
      t.float :amount
      t.text :description
      t.integer :bet_id
      t.integer :transferred_to

      t.timestamps
    end
  end
end
