class CreateCarts < ActiveRecord::Migration[7.0]
  def change
    create_table :carts do |t|
      t.integer :team_number
      t.string :odd_type
      t.float :odd_value
      t.string :team_name
      t.integer :team_id
      t.integer :mid
      t.decimal :amount
      t.references :user, null: false, foreign_key: true
      t.string :match_title
      t.references :live_odds_type, null: false, foreign_key: true
      t.references :match, null: false, foreign_key: true

      t.timestamps
    end
  end
end
