class MatchSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :mid, :title, :status_str, :status_note,
             :odds_available, :start_time, :end_time, :result, :win_margin,
             :winning_team_id, :latest_inning_number, :competition_id, 
             :match_status_id, :competition_data, :teama, :teamb,
             :teamaodds, :teambodds

  attribute :custom_data do
     "add custom"
  end

  def competition_data
    competition = object.competition
    return unless competition
    {
      id: competition.id,
      cid: competition.cid,
      title: competition.title,
      abbr: competition.abbr,
      category: competition.category,
      status: competition.status,
      game_formate: competition.game_formate,
      date_start: competition.date_start,
      date_end: competition.date_end,
      country: competition.country,
      total_matches: competition.total_matches,
      total_rounds: competition.total_rounds,
      total_teams: competition.total_teams,
      season: competition.season
    }
  end

  def teama
    teama = object.teama
    return unless teama
    {
      id: teama.id,
      tid: teama.tid,
      name: teama.name,
      short_name: teama.short_name,
      logoUrl: teama.logoUrl,
      scores_full: teama.scores_full,
      scores: teama.scores,
      overs: teama.overs,
      match_id: teama.match_id,
      mid: teama.mid
    }
  end

  def teamb
    teamb = object.teamb
    return unless teamb
    {
      id: teamb.id,
      tid: teamb.tid,
      name: teamb.name,
      short_name: teamb.short_name,
      logoUrl: teamb.logoUrl,
      scores_full: teamb.scores_full,
      scores: teamb.scores,
      overs: teamb.overs,
      match_id: teamb.match_id,
      mid: teamb.mid
    }
  end

  def teamaodds
    object.teama_odds.map do |teama_odd|
      {
        id: teama_odd.id, 
        live_odds_type: teama_odd.live_odds_type, 
        back: teama_odd.back, 
        lay: teama_odd.lay, 
        back_volume: teama_odd.back_volume,
        lay_volume: teama_odd.lay_volume, 
        match_id: teama_odd.match_id, 
        mid: teama_odd.mid
      }
    end
  end

  def teambodds
    object.teamb_odds.map do |teamb_odd|
      {
        id: teamb_odd.id, 
        live_odds_type: teamb_odd.live_odds_type, 
        back: teamb_odd.back, 
        lay: teamb_odd.lay, 
        back_volume: teamb_odd.back_volume,
        lay_volume: teamb_odd.lay_volume, 
        match_id: teamb_odd.match_id, 
        mid: teamb_odd.mid
      }
    end  
  end

  # belongs_to :competition, serializer: CompetitionSerializer
  # has_one :teama  #, serializer: TeamaSerializer 
  # has_one :teamb  #, serializer: TeambSerializer
  # has_many :teama_odds  #, serializer: TeamaOddSerializer 
  # has_many :teamb_odds  #, serializer: TeambOddSerializer
end


