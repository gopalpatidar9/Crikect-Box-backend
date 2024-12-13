class CreateTeambs < ActiveRecord::Migration[7.0]
  def change
    create_table :teambs do |t|
      t.integer :tid
      t.string :name
      t.string :short_name
      t.string :logoUrl
      t.integer :scores_full
      t.integer :scores
      t.integer :overs
      t.references :match, null: false, foreign_key: true
      t.integer :mid

      t.timestamps
    end
  end
end
