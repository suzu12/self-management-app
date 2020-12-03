class TimelinesController < ApplicationController
  before_action :authenticate_user!

  def show
    user_ids = current_user.followings.pluck(:id)
    team_ids = TeamUser.where(user_id: user_ids)
    @teams = Team.where(id: team_ids)
  end
end
