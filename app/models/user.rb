class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  has_one :profile, dependent: :destroy
  has_many :team_users
  has_many :teams, through: :team_users
  has_many :chats, dependent: :destroy

  validates :nickname, presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'は英字と数字の両方を含めて設定してください'

  def has_made?(team)
    teams.exists?(id: team.id)
  end

  def icon_image
    if profile&.icon&.attached?
      profile.icon
    else
      'default.png'
    end
  end

  def which_profile
    profile || build_profile
  end
end
