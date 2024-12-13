class CreateLiveOddsTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :live_odds_types do |t|
      t.string :odds_type

      t.timestamps
    end
  end
end
