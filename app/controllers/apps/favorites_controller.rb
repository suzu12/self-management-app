class Apps::FavoritesController < Apps::ApplicationController

  def index
    @teams = current_user.favorite_teams
  end
end
