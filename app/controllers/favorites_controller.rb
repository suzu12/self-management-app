class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
    @teams = current_user.favorite_teams
  end
end
