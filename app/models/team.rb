class Team < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :period

  has_one_attached :image

  has_many :team_users
  has_many :users, through: :team_users, dependent: :destroy

  has_many :chats, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :team_tag_relations
  has_many :tags, through: :team_tag_relations

  def update_tags(update_team_tags)
    current_tags = tags.pluck(:name) unless tags.nil?
    old_tags = current_tags - update_team_tags
    new_tags = update_team_tags - current_tags

    old_tags.each do |old_name|
      tags.delete Tag.find_by(name: old_name)
    end

    new_tags.each do |new_name|
      teams_tag = Tag.find_or_create_by(name: new_name)
      tags << teams_tag
    end
  end
end