class ColumnRemoveInCompetitions < ActiveRecord::Migration[7.0]
  def change
    remove_column :competitions, :seasion
  end
end
