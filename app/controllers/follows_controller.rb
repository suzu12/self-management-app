class FollowsController < ApplicationController
  before_action :authenticate_user!

  def create
    user = User.find(params[:account_id])
    current_user.follow!(user)
    redirect_to account_path(user)
  end
end
