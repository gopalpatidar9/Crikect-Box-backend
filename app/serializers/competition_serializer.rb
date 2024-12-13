class CompetitionSerializer < ActiveModel::Serializer
  attributes :id, :cid, :title, :abbr, :category, :status,   
             :game_formate, :date_start, :date_end, :country, 
             :total_matches, :total_rounds, :total_teams, :season

  # has_many :matches  #, serializer: MatchSerializer
end
  

