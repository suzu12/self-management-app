class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_like

  def show
    like_status = current_user.has_liked?(@team)
    render json: { hasLiked: like_status }
  end

  def create
    @team.likes.create!(user_id: current_user.id)
    render json: { status: 'ok' }
  end

  def destroy
    like = @team.likes.find_by!(user_id: current_user.id)
    like.destroy!

    render json: { status: 'ok' }
  end

  private

  def set_like
    @team = Team.find(params[:team_id])
  end
end
