class Chat < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :chat, optional: true

  has_one :nickname
  has_one :nickname, through: :user
  has_one_attached :photo

  validates :content, presence: true, unless: :was_attached?
  def was_attached?
    photo.attached?
  end

  validates :user_id, presence: true
  validates :team_id, presence: true
end
