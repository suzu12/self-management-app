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
end
