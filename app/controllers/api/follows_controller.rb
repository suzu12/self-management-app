class Api::FollowsController < Api::ApplicationController
  before_action :authenticate_user!
  before_action :set_follow_user

  def index
    follow_status = current_user.followed?(@user)

    render json: { followed: follow_status }
  end

  def create
    current_user.follow!(@user)
    follower_count = @user.followers.count

    render json: { status: 'ok', followerCount: follower_count }
  end

  private

  def set_follow_user
    @user = User.find(params[:account_id])
  end
end
