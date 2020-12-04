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
      redirect_to root_path, notice: '作成できました！'
    else
      flash.now[:error] = '作成に失敗しました'
      render :new
    end
  end

  def edit
    @tag = @team.tags.pluck(:name).join(',')
  end

  def update
    if @team.update(update_team_params)
      @team.update_tags(params[:team][:name].split(','))
      redirect_to team_path(@team), notice: '編集できました！'
    else
      flash.now[:error] = '編集に失敗しました'
      render :edit
    end
  end

  def destroy
    if user_signed_in? && current_user.has_made?(@team)
      team = TeamTagRelation.find_by(team_id: @team)
      team.destroy
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
    params.require(:teams_tag).permit(:category_id, :team_name, :introduction, :period_id, :image, :name).merge(user_id: current_user.id)
  end

  def update_team_params
    params.require(:team).permit(:category_id, :team_name, :introduction, :period_id, :image)
  end

  def set_team
    @team = Team.find(params[:id])
  end
end
