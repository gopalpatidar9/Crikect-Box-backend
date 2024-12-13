class ChangeColumnInCompetitions < ActiveRecord::Migration[7.0]
  def change
  change_column(:competitions, :status, :string)
  end
end
