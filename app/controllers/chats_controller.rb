class ChatsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_team, only: [:index]
  before_action :move_to_index, only: [:index]

  def index
    @chat = Chat.new
    @chats = @team.chats.includes(:user)
  end

  private

  def set_team
    @team = Team.find(params[:team_id])
  end

  def move_to_index
    redirect_to root_path unless user_signed_in? && current_user.has_entry?(@team)
  end
end
