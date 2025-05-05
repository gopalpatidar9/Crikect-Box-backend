class AddSeasonToCompetitions < ActiveRecord::Migration[7.0]
  def change
    add_column :competitions, :season, :string
  end
end
