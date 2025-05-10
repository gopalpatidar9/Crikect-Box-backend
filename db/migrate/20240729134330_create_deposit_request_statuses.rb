class CreateDepositRequestStatuses < ActiveRecord::Migration[7.0]
  def change
    create_table :deposit_request_statuses do |t|
      t.string :name
      t.integer :order
      t.boolean :is_active

      t.timestamps
    end
  end
end
