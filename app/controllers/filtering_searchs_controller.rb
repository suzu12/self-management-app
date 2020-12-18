class FilteringSearchsController < ApplicationController
  def index
    if params[:search] != '' && params[:category_id] != ''
      @teams = Team.where(['team_name LIKE ? OR introduction LIKE ? AND category_id LIKE ?', "%#{params[:search]}%",
                           "%#{params[:search]}%", params[:category_id].to_s])

      tag_id = Tag.where('name LIKE ?', "%#{params[:search]}%").pluck(:id)
      team_id = TeamTagRelation.where(tag_id: tag_id).pluck(:team_id)
      @tags = Team.where(id: team_id)

    elsif params[:search].present?
      @teams = Team.where(['team_name LIKE ? OR introduction LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%"])

      tag_id = Tag.where('name LIKE ?', "%#{params[:search]}%").pluck(:id)
      team_id = TeamTagRelation.where(tag_id: tag_id).pluck(:team_id)
      @tags = Team.where(id: team_id)

    elsif params[:category_id].present?
      @teams = Team.where(category_id: params[:category_id])

    else
      @teams = Team.all.order('created_at DESC')
    end
  end
end
