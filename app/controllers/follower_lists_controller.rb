class FollowerListsController < ApplicationController
  before_action :authenticate_user!

  def show
    @account = User.find(params[:account_id])
    follower_list = @account.followers.pluck(:id)
    @users = User.where(id: follower_list)
  end
end
