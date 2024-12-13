class TeambSerializer < ActiveModel::Serializer
  attributes :id, :tid, :name, :short_name, :logoUrl, 
             :scores_full, :scores, :overs, :match_id, :mid
             
  # belongs_to :match, serializer: MatchSerializer
end
  
