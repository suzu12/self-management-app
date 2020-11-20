class TeamsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show]
  before_action :set_team, only: [:show, :edit, :update, :destroy]

  def index
    @teams = Team.all.order('created_at DESC')
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    if @team.save
      redirect_to root_path, notice: '保存できました！'
    else
      flash.now[:error] = '保存に失敗しました'
      render :new
    end
  end
  
  def update
    if @team.update(team_params)
      redirect_to team_path(@team), notice: '編集できました！'
    else
      flash.now[:error] = '編集に失敗しました'
      render :edit
    end
  end
  
  def destroy
    @team.destroy!
    redirect_to root_path, notice: '削除することができました！'
  end
  

  private

  def team_params
    params.require(:team).permit(:category_id, :team_name, :introduction, :period_id, :image)
  end

  def set_team
    @team = Team.find(params[:id])
  end
end
