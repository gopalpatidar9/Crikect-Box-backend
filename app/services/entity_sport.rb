require 'httparty'
class EntitySport
  include HTTParty
  base_uri 'https://rest.entitysport.com/v2'
  API_KEY ='ec471071441bb2ac538a0ff901abd249' 

  def fetch_competitions
    competitions = self.class.get('/competitions', query: {token: API_KEY})

    if competitions.success?  
      competitions.parsed_response
      save_and_update_competitions(competitions['response']['items'])
      puts "completed competitions"
    else
      { error: competitions.parsed_response['error'] || competitions.message }
    end
  end
  
  def save_and_update_competitions(competitions)
    competitions.each do |competition_data|
      @competition = Competition.find_by(cid: competition_data['cid'])
      if @competition
        @competition.update(competition_params(competition_data))
      else
        Competition.create(competition_params(competition_data))
      end
      @competition
    end
  end

  def fetch_matches
    matches = self.class.get('/matches', query: {token: API_KEY})

    if matches.success?
      matches.parsed_response
      save_and_update_matches(matches['response']['items'])
      puts "completed matches"
    else 
       {error: matches.parsed_response['error'] || matches.message}     
    end
  end

  def save_and_update_matches(matches)
    matches.each do |match_data|
      competition_data = match_data['competition']
      competitions = Competition.find_by(cid: match_data['competition']['cid'])
      if competitions 
        competitions.update(competition_params(competition_data))
      else
        Competition.create(competition_params(competition_data))
      end
      @match = Match.find_by(mid: match_data['match_id'])
      if @match
        @match.update(matches_params(match_data))
      else  
        Match.create(matches_params(match_data).merge(competition_id: competitions.id))
      end
    end 
  end

  def fetch_teama
    teams = self.class.get('/matches', query: {token: API_KEY})

    if teams.success?
      teams.parsed_response
      save_and_update_teams(teams['response']['items'])
      puts "completed teams"
    else 
      {error: teams.parsed_response['error'] || teams.message}
    end
  end

  def save_and_update_teams(matches)
    matches.each do |match_data|
      match = Match.find_by(mid: match_data['match_id'])
      if match
        match.update(matches_params(match_data))
        save_and_update_team(match, match_data['teama'], 'A')
        save_and_update_team(match, match_data['teamb'], 'B')
      else
        Match.create(matches_params(team))
        save_and_update_team(match, team['teama'], 'A')
        save_and_update_team(match, team['teamb'], 'B')
      end
    end
  end

  def save_and_update_team(match, team_data , team_type )
    team_class = team_type == 'A' ? Teama : Teamb
    team = team_class.find_by(tid: team_data['team_id'])
    if team
      team.update(team_params(team_data).merge(match_id: match.id , mid: match.mid))
    else  
      team_class.create(team_params(team_data).merge(match_id: match.id , mid: match.mid))
    end
  end

  def process_loaded_data
    file_path = Rails.root.join('lib', 'assets', 'mathc_data.json')
    file_contents = File.read(file_path)
    @data = JSON.parse(file_contents)
  
    if @data['response']['live_odds'] || @data['response']['match_info']
      live_odds = @data['response']['live_odds']
      match_info = @data['response']['match_info']
      save_and_update_live_odds(live_odds , match_info)
      puts "live_odds completed"
    end
  end

  def save_and_update_live_odds(live_odds, match_info)
    odds_types = ['matchodds', 'tiedmatch', 'bookmaker'] 
    teams_odds = ['teama', 'teamb']

    odds_types.each do |type|
      if live_odds[type]
        odds_type_record = LiveOddsType.find_by(odds_type: type)
      
        competition = find_or_create_competition(match_info['competition'])
        match = find_or_create_match(match_info, competition.id)
        find_or_create_team(match, match_info['teama'], 'A' )
        find_or_create_team(match, match_info['teamb'], 'B' )
        
        teams_odds.each do |team_odd|
          if live_odds[type][team_odd]

            if team_odd == 'teama' 
              teama_odds = TeamaOdd.find_by(mid: match.mid, live_odds_type: odds_type_record.odds_type)
              if teama_odds
                teama_odds.update(odds_params(live_odds[type][team_odd]).merge(
                  match_id: match.id,
                  mid: match.mid,
                  live_odds_type: odds_type_record.odds_type
                ))
              else
                TeamaOdd.create(odds_params(live_odds[type][team_odd]).merge(
                  match_id: match.id,
                  mid: match.mid,
                  live_odds_type: odds_type_record.odds_type
                ))
              end
            end
            if team_odd == 'teamb' 
              teamb_odds = TeambOdd.find_by(mid: match.mid , live_odds_type: odds_type_record.odds_type)
              if teamb_odds
                teamb_odds.update(odds_params(live_odds[type][team_odd]).merge(
                  match_id: match.id,
                  mid: match.mid,
                  live_odds_type: odds_type_record.odds_type
                ))
              else
                TeambOdd.create(odds_params(live_odds[type][team_odd]).merge(
                  match_id: match.id,
                  mid: match.mid, 
                  live_odds_type: odds_type_record.odds_type
                ))
              end
            end
          end
        end
      end  
    end
  end

  private

  def find_or_create_competition(competition_info)
    competition = Competition.find_by(cid: competition_info['cid'])
    if competition
      competition.update(competition_params(competition_info))
    else
      competition = Competition.create(competition_params(competition_info))
    end
    competition
  end
  
  def find_or_create_match(match_info, competition_id)
    match = Match.find_by(mid: match_info['match_id'])
    if match
      match.update(matches_params(match_info).merge(competition_id: competition_id))
    else
       match = Match.create(matches_params(match_info).merge(competition_id: competition_id))
    end
    match
  end
  
  def find_or_create_team(match, team_info, team_type )

    team_class = team_type == 'A' ?  Teama : Teamb
    team = team_class.find_by(tid: team_info['team_id'], match_id: match.id)
    if team
      team.update(team_params(team_info).merge(match_id: match.id, mid: match.mid))
    else
      team_class.create(team_params(team_info).merge(match_id: match.id, mid: match.mid))
    end
  end

  def competition_params(competition_data)
    {  
      cid: competition_data['cid'],
      title: competition_data['title'],
      abbr: competition_data['abbr'],
      category: competition_data['category'], 
      game_formate: competition_data['game_format'],
      status: competition_data['status'], 
      season: competition_data['season'],
      country: competition_data['country'], 
      date_start: competition_data['datestart'],
      date_end: competition_data['dateend'], 
      total_matches: competition_data['total_matches'],
      total_rounds: competition_data['total_rounds'], 
      total_teams: competition_data['total_teams']
    }  
  end

  def matches_params(match_data)
    {
      mid: match_data['match_id'],
      title: match_data['title'],
      status_str: match_data['status_str'],
      status_note: match_data['status_note'],
      odds_available: match_data['odds_available'],
      start_time: match_data['date_start_ist'],
      end_time: match_data['date_end_ist'],
      result: match_data['result'],
      win_margin: match_data['win_margin'],
      winning_team_id: match_data['winning_team_id'],
      latest_inning_number: match_data['latest_inning_number'],
      match_status_id: match_data['status']
    }
  end

  def team_params(teama_data)
    {
      tid: teama_data['team_id'],
      name: teama_data['name'],
      short_name: teama_data['short_name'],
      logoUrl: teama_data['logo_url'],
      scores_full: teama_data['scores_full'],
      scores: teama_data['scores'],
      overs: teama_data['overs'],
    }
  end

  def odds_params(odds_data)
    {
      back: odds_data['back'],
      lay: odds_data['lay'],
      back_volume: odds_data['back_volume'],
      lay_volume: odds_data['lay_volume'],
    }
  end
end
