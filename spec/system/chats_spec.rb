require 'rails_helper'

RSpec.describe 'Chats', type: :system do
  let!(:user) { create(:user) }
  before do
    @team = FactoryBot.build(:teams_tag, user_id: user.id, image: fixture_file_upload('spec/fixtures/images/test_image.png'))
    @team_id = @team.save.team_id
  end

  context 'ログインしている場合' do
    before do
      sign_in user
    end

    it 'チャットに参加することができる' do
      visit team_path(@team_id)

      click_on('仲間と会話を始めよう！')
      expect(page).to have_css('.chat_header', text: @team.team_name)
    end

    # it 'チャットの送信をすることができる' do
    #   visit team_chats_path(@team_id)

    #   post = 'テスト'
    #   fill_in 'Aa',	with: post
    #   expect  do
    #     find('.form-submit').click
    #   end.to change { Chat.count }.by(1)

    #   expect(page).to have_content(post)
    # end

    # it '画像の送信をすることができる' do
    #   visit team_chats_path(@team_id)

    #   image_path = Rails.root.join('spec/fixtures/images/test_image.png')
    #   attach_file('chat[photo]', image_path, make_visible: true)

    #   expect do
    #     find('.form-submit').click
    #   end.to change { Chat.count }.by(1)
    #   expect(page).to have_selector('img')
    # end

    it '送る値が空のため送信に失敗する' do
      visit team_chats_path(@team_id)

      expect do
        find('.form-submit').click
      end.not_to change { Chat.count }
    end
  end

  context 'ログインしていない場合' do
    it 'チャットに参加できない' do
      visit team_path(@team_id)
      expect(page).to have_content('Signup')
      expect(page).to have_content('Login')

      visit team_chats_path(@team_id)
      expect(current_path).to eq new_user_session_path
    end
  end
end
