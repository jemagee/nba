class GamesController < ApplicationController
  include GamesHelper
  def index
  end

  def fetch
    @date = "#{params[:game_date][:month]}/#{params[:game_date][:day]}/#{params[:game_date][:year]}"
    @civil = Date.civil(params[:game_date][:year].to_i, params[:game_date][:month].to_i, params[:game_date][:day].to_i)
    @parsing = get_games(@civil)
    parsing = @parsing
    if parsing[0]["rowSet"].length > 0
    	add_games(parsing)
    	update_participants(parsing)
    	#get_player_stats(parsing) - do this as part of updating the participants?
    	#get_player_shots(parsing)
    	#get_play_by_play(parsing)
    end
  end

end