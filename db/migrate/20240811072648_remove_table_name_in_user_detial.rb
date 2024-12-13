class RemoveTableNameInUserDetial < ActiveRecord::Migration[7.0]
  def change
    rename_table :user_detail, :user_details
  end
end
