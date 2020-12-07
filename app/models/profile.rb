class Profile < ApplicationRecord
  enum gender: { male: 0, female: 1 }

  has_one_attached :icon
  belongs_to :user

  with_options presence: true do
    validates :bio
    validates :birthday
    validates :gender
  end
end
