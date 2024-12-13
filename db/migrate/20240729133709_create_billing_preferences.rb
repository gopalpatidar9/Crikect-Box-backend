class CreateBillingPreferences < ActiveRecord::Migration[7.0]
  def change
    create_table :billing_preferences do |t|
      t.references :user, null: false, foreign_key: true
      t.float :commission_percentahe
      t.integer :monthly_fee
      t.boolean :payment_gateway_activated
      t.datetime :last_commission_payment_time
      t.datetime :last_monthly_fee_payment_time

      t.timestamps
    end
  end
end
