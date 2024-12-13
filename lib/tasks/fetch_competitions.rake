namespace :fetch_competitions do
  
  task test_rake_task: :environment do
    entity_sport = EntitySport.new
    entity_sport.fetch_competitions
    entity_sport.fetch_matches
    entity_sport.fetch_teama
    entity_sport.process_loaded_data
  end
end