class Profile < ApplicationRecord
  enum gender: { male: 0, female: 1 }

  has_one_attached :icon
  belongs_to :user
end
