class TeamsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_team, only: [:show, :edit, :update, :destroy]

  def index
    @teams = Team.all.order('created_at DESC')
  end

  def new
    @team = TeamsTag.new
  end

  def show
    @team_user = TeamUser.new
  end

  def create
    @team = TeamsTag.new(team_params)
    if @team.valid?
      @team.save
      TeamUser.create(user_id: current_user.id, team_id: Team.last.id)
      redirect_to root_path, notice: '作成できました！'
    else
      flash.now[:error] = '作成に失敗しました'
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
    if user_signed_in? && current_user.has_made?(@team)
      @team.destroy!
      redirect_to root_path, notice: '削除することができました！'
    end
  end

  def search
    return nil if params[:keyword] == ''

    tag = Tag.where(['name LIKE ?', "%#{params[:keyword]}%"])
    render json: { keyword: tag }
  end

  private

  def team_params
    params.require(:teams_tag).permit(:category_id, :team_name, :introduction, :period_id, :image, :name)
  end

  def set_team
    @team = Team.find(params[:id])
  end
end
