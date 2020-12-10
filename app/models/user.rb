class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  has_one :profile, dependent: :destroy

  has_many :team_users
  has_many :teams, through: :team_users

  has_many :chats, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :favorite_teams, through: :likes, source: :team

  has_many :following_relationships, class_name: 'Relationship', foreign_key: 'following_id', dependent: :destroy
  has_many :followings, through: :following_relationships, source: :follower

  has_many :follower_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :followers, through: :follower_relationships, source: :following

  has_many :sns_credentials

  validates :nickname, presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'は英字と数字の両方を含めて設定してください'

  delegate :birthday, :age, :gender, :bio, to: :profile, allow_nil: true

  def self.from_omniauth(auth)
    sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create
    user = User.where(email: auth.info.email).first_or_initialize(
      email: auth.info.email
    )

    if user.persisted?
      sns.user = user
      sns.save(validate: false)
    end
    { user: user, sns: sns }
  end

  def has_entry?(team)
    teams.exists?(id: team.id)
  end

  def team_creator?(team)
    team_user = TeamUser.where(team_id: team.id).pluck(:user_id).first
  end

  def which_profile
    profile || build_profile
  end

  def has_liked?(team)
    likes.exists?(team_id: team.id)
  end

  def follow!(user)
    following_relationships.create!(follower_id: user.id)
  end

  def unfollow!(user)
    following_relationships.find_by!(follower_id: user.id).destroy!
  end

  def followed?(user)
    followings.include?(user)
  end
end
