class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :team

  has_one :nickname
  has_one :nickname, through: :user
  has_one_attached :photo

  validates :content, presence: true, unless: :was_attached?
  def was_attached?
    photo.attached?
  end

  after_create_commit { ChatBroadcastJob.perform_later self }
end
