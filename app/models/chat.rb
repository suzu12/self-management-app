class Chat < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :chat, optional: true

  has_one_attached :photo

  validates :content, presence: true, unless: :was_attached?
  def was_attached?
    photo.attached?
  end
end