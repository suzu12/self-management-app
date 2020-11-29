class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  has_one :profile, dependent: :destroy

  has_many :team_users
  has_many :teams, through: :team_users

  has_many :chats, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :following_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :followings, through: :following_relationships, source: :following

  has_many :follower_relationships, class_name: 'Relationship', foreign_key: 'following_id', dependent: :destroy
  has_many :followers, through: :follower_relationships, source: :follower

  validates :nickname, presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'は英字と数字の両方を含めて設定してください'

  delegate :birthday, :age, :gender, :bio, to: :profile, allow_nil: true

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

  def has_liked?(team)
    likes.exists?(team_id: team.id)
  end

  def follow!(user)
    following_relationships.create!(following_id: user.id)
  end

  def unfollow!(user)
    following_relationships.find_by!(following_id: user.id).destroy!
  end

  def followed?(user)
    followings.include?(user)
  end
end
