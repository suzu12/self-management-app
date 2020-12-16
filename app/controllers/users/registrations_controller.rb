class Users::RegistrationsController < Devise::RegistrationsController
  def create
    @user = User.new(sign_up_params)
    if params[:sns_auth] == 'true'
      pass = Devise.friendly_token
      params[:user][:password] = pass
      params[:user][:password_confirmation] = pass
    else
      render :new and return unless @user.valid?
    end
    session['devise.regist_data'] = { user: @user.attributes }
    session['devise.regist_data'][:user]['password'] = params[:user][:password]
    @nickname = @user.build_nickname
    render :new_nickname
  end

  def create_nickname
    @user = User.new(session['devise.regist_data']['user'])
    @nickname = Nickname.new(nickname_params)
    render :new_nickname and return unless @nickname.valid?

    @user.build_nickname(@nickname.attributes)
    @user.save
    session['devise.regist_data']['user'].clear
    sign_in(:user, @user)
    redirect_to root_path, notice: '作成できました！'
  end

  private

  def nickname_params
    params.require(:nickname).permit(:nickname)
  end
end
