class TeamUsersController < ApplicationController
  def create
    @team = Team.find(params[:team_id])
    @team_user = @team.team_users.new(user_id: current_user.id, team_id: params[:team_id])
    if @team_user.save
      redirect_to team_path(@team)
    else
      render :create
    end
  end
end
