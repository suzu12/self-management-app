class AccountsController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @nickname = @user.nickname.nickname
    redirect_to profile_path if @user == current_user
  end
end
