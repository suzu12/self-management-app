class Team < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :period

  has_one_attached :image
  has_many :team_users
  has_many :users, through: :team_users, dependent: :destroy
  has_many :chats, dependent: :destroy
  has_many :likes, dependent: :destroy

  with_options presence: true do
    validates :category_id
    validates :team_name, length: { maximum: 15 }
    validates :period_id
    validates :introduction, length: { maximum: 400 }
  end

  validates :category_id, numericality: { other_than: 1, message: 'を選択してください' }
  validates :period_id, numericality: { other_than: 1, message: 'を選択してください' }
end
