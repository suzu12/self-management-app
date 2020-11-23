class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @nickname = @user.nickname
    @birthday = @user.birthday
    @gender = @user.gender
    @bio = @user.bio
  end

  def update
    @profile.assign_attributes(profile_params)
    if @profile.save
      redirect_to profile_path, notice: 'プロフィール更新を更新しました！'
    else
      flash.now[:error] = '更新できませんでした'
      render :edit
    end
  end

  private

  def set_profile
    @profile = current_user.which_profile
  end

  def profile_params
    params.require(:profile).permit(:bio, :gender, :birthday, :icon)
  end
end
