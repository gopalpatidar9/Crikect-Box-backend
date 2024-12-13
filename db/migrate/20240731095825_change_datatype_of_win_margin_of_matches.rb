class ChangeDatatypeOfWinMarginOfMatches < ActiveRecord::Migration[7.0]
  def change
    change_column(:matches, :win_margin, :string )
  end
end
