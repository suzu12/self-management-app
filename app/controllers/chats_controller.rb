class ChatsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_team, only: [:index, :create]
  before_action :move_to_index, only: [:index]

  def index
    @chat = Chat.new
    @chats = @team.chats.includes(:user)
  end

  def create
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

  def set_team
    @team = Team.find(params[:team_id])
  end

  def move_to_index
    redirect_to root_path unless user_signed_in? && current_user.has_entry?(@team)
  end
end
