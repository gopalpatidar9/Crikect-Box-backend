class CreateMatches < ActiveRecord::Migration[7.0]
  def change
    create_table :matches do |t|
      t.integer :mid
      t.string :title
      t.references :matchstatus, null: false, foreign_key: true
      t.string :status_str
      t.string :status_note
      t.boolean :odds_available
      t.datetime :start_time
      t.datetime :end_time
      t.string :result
      t.float :win_margin
      t.integer :winning_team_id
      t.integer :latest_inning_number
      t.references :competition, null: false, foreign_key: true

      t.timestamps
    end
  end
end
