class Profile < ApplicationRecord
  enum gender: { male: 0, female: 1 }

  has_one_attached :icon
  belongs_to :user

  def age
    return unless birthday.present?

    years = Time.zone.now.year - birthday.year
    days = Time.zone.now.yday - birthday.yday

    if days < 0
      "#{years - 1}歳"
    else
      "#{years}歳"
    end
  end
end
