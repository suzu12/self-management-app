class TeamsTag
  include ActiveModel::Model
  attr_accessor :category_id, :team_name, :introduction, :period_id, :image, :name, :user_id

  with_options presence: true do
    validates :category_id
    validates :team_name, length: { maximum: 15 }
    validates :period_id
    validates :introduction, length: { maximum: 400 }
    validates :name
    validates :user_id
    validates :image
  end

  validates :category_id, numericality: { other_than: 1, message: 'を選択してください' }
  validates :period_id, numericality: { other_than: 1, message: 'を選択してください' }

  def save
    team = Team.create(category_id: category_id, team_name: team_name, introduction: introduction, period_id: period_id,
                       image: image)
    tags = split_tag_list.map { |name| Tag.find_or_create_by(name: name) }

    tags.each do |tag|
      TeamTagRelation.create(team_id: team.id, tag_id: tag.id)
    end

    TeamUser.create(team_id: team.id, user_id: user_id)
  end

  private

  def split_tag_list
    name.split(',')
  end
end
