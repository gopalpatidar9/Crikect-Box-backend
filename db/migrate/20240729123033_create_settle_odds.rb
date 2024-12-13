class CreateSettleOdds < ActiveRecord::Migration[7.0]
  def change
    create_table :settle_odds do |t|
      t.string :team_batting
      t.string :title
      t.string :back_condition
      t.float :back
      t.string :lay_condition
      t.float :lay
      t.boolean :status
      t.string :settle
      t.string :settle_type
      t.datetime :settle_titme
      t.boolean :verified
      t.datetime :verified_time
      t.integer :question_id
      t.references :match, null: false, foreign_key: true

      t.timestamps
    end
  end
end
