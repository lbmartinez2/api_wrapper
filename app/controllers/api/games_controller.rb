module Api
  class GamesController < ApplicationController
    def index
      games = Rawg::Client.games
      render json: games
    end

    def show
      game_details = Rawg::Client.game_details(params[:id])
      render json: game_details
    end
  end
end