class ChatsController < ApplicationController
  before_action :authenticate_user!

  def index
    @team = Team.find(params[:team_id])
    @chat = Chat.new
    @chats = @team.chats.includes(:user)
  end

  def create
    @team = Team.find(params[:team_id])
    @chat = @team.chats.new(chat_params)
    if @chat.save
      redirect_to team_chats_path(@team)
    else
      @chats = @team.chats.includes(:user)
      render :index
    end
  end

  private

  def chat_params
    params.require(:chat).permit(:content, :photo).merge(user_id: current_user.id)
  end
end
