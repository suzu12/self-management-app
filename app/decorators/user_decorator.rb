module UserDecorator
  def icon_image
    if profile&.icon&.attached?
      profile.icon
    else
      'default.svg'
    end
  end

  def team_count
    teams.count
  end

  def following_count
    followings.count
  end

  def follower_count
    followers.count
  end
end
