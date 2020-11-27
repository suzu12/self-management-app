class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_like
  before_action :like_counts

  def show
    like_status = current_user.has_liked?(@team)

    render json: { hasLiked: like_status, likeCount: like_counts }.to_json
  end

  def create
    @team.likes.create!(user_id: current_user.id)

    render json: { status: 'ok', likeCount: like_counts }.to_json
  end

  def destroy
    like = @team.likes.find_by!(user_id: current_user.id)
    like.destroy!

    render json: { status: 'ok', likeCount: like_counts }.to_json
  end

  private

  def set_like
    @team = Team.find(params[:team_id])
  end

  def like_counts
    @like_count = @team.likes.count
  end
end
