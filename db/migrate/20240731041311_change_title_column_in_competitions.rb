class ChangeTitleColumnInCompetitions < ActiveRecord::Migration[7.0]
  def change
    change_column(:competitions, :title , :string)
  end
end
