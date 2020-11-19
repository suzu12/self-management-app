class TeamsController < ApplicationController
  # before_action :authenticate_user! only: [:index]

  def index
    @teams = Team.all.order('created_at DESC')
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    if @team.save
      redirect_to root_path, notice: '保存できました'
    else
      flash.now[:error] = '保存に失敗しました'
      render :new
    end
  end

  private

  def team_params
    params.require(:team).permit(:category_id, :team_name, :introduction, :period_id, :image)
  end
end
