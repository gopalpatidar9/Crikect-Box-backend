class CreateTeamaOdds < ActiveRecord::Migration[7.0]
  def change
    create_table :teama_odds do |t|
      t.string :live_odds_type
      t.float :back
      t.float :lay
      t.float :back_volume
      t.float :lay_volume
      t.references :match, null: false, foreign_key: true
      t.integer :mid

      t.timestamps
    end
  end
end
