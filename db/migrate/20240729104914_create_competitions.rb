class CreateCompetitions < ActiveRecord::Migration[7.0]
  def change
    create_table :competitions do |t|
      t.integer :cid
      t.integer :title
      t.string :abbr
      t.string :category
      t.boolean :status
      t.string :game_formate
      t.integer :seasion
      t.datetime :date_start
      t.datetime :date_end
      t.string :country
      t.integer :total_matches
      t.integer :total_rounds
      t.integer :total_teams

      t.timestamps
    end
  end
end
