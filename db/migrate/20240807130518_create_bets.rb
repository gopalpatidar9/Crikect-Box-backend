class CreateBets < ActiveRecord::Migration[7.0]
  def change
    create_table :bets do |t|
      t.integer :team_number
      t.string :odd_type
      t.float :odd_value
      t.string :team_name
      t.integer :team_id
      t.integer :mid
      t.decimal :amount
      t.references :user, null: false, foreign_key: true
      t.string :match_title
      t.references :bet_status, null: false, foreign_key: true
      t.decimal :potential_payout
      t.references :live_odds_type, null: false, foreign_key: true
      t.integer :match_id
      t.datetime :completed_at

      t.timestamps
    end
  end
end
