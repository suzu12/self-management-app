class ChatBroadcastJob < ApplicationJob
  queue_as :default

  def perform(chat)
    ActionCable.server.broadcast "chat_channel_#{chat.team_id}", chat: render_chat(chat)
  end

  private

  def render_chat(chat)
    # ApplicationController.renderer.render partial: 'chats/chat', locals: { chat: chat }
    renderer = ApplicationController.renderer.new(
      # http_host: 'localhost:80'
      http_host: 'http://www.selfmanagers.net/', # 本番環境
      https: true # 本番環境
    )
    renderer.render(partial: 'chats/chat', locals: { chat: chat })
  end
end
