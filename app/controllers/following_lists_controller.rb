class FollowingListsController < ApplicationController
  before_action :authenticate_user!

  def show
    @account = User.find(params[:account_id])
    following_list = @account.followings.pluck(:id)
    @users = User.where(id: following_list)
  end
end
