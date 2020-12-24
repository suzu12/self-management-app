class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_channel_#{params['team']}"
  end

  def unsubscribed
  end

  def speak(data)
    Chat.create!(
      content: data['chat'],
      user_id: current_user.id,
      team_id: params['team']
    )
  end
end
