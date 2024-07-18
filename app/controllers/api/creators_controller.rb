module Api
  class CreatorsController < ApplicationController
    def index
      creators = Rawg::Client.creators
      render json: creators
    end

    def show
      creator_details = Rawg::Client.creator_details(params[:id])
      render json: creator_details
    end
  end
end