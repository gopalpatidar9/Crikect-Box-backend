class CreateUserDetail < ActiveRecord::Migration[7.0]
  def change
    create_table :user_detail do |t|
      t.integer :parentuserid
      t.string :profilepicture
      t.boolean :depositrequestenabled
      t.boolean :chatsenabled
      t.boolean :CanAddUser
      t.boolean :BetEnabled
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
