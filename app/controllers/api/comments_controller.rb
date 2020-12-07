class Api::CommentsController < Api::ApplicationController
  before_action :set_comment

  def index
    comments = @team.comments
    render json: comments
  end

  def create
    @comment = @team.comments.new(comment_params)
    @comment.save!

    render json: @comment
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_comment
    @team = Team.find(params[:team_id])
  end
end
