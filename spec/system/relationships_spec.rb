require 'rails_helper'

RSpec.describe 'Relationships', type: :system do
  let(:user)       { create(:user, :with_nickname) }
  let(:other_user) { create(:user, :with_nickname) }
  before do
    @team = FactoryBot.build(:teams_tag, user_id: user.id, image: fixture_file_upload('spec/fixtures/images/test_image.png'))
    @team.save
  end

  context 'ログインしている場合' do
    it 'フォローができること', js: true do
      sign_in other_user
      visit root_path
      find('.team_center_icon').find('img').click

      expect(page).to have_css('.follow-count-js', text: '0')
      expect(page).to have_css('.profilePage_user_info', text: user.nickname.nickname)
      expect(page).to have_content('フォロー')
      expect do
        find('.following-js').click
        sleep 0.5
      end.to change { Relationship.count }.by(1)

      expect(page).to have_css('.follow-count-js', text: '1')
      expect(page).to have_content('フォロー中')
    end

    it 'フォローを外すことができること', js: true do
      sign_in other_user
      visit root_path
      find('.team_center_icon').find('img').click
      find('.following-js').click
      expect(page).to have_css('.follow-count-js', text: '1')

      expect do
        find('.followed-js').click
        sleep 0.5
      end.to change { Relationship.count }.by(-1)

      expect(page).to have_content('フォロー')
      expect(page).to have_css('.follow-count-js', text: '0')
    end

    it 'フォロワーリストを閲覧できること', js: true do
      sign_in other_user
      visit root_path
      find('.team_center_icon').find('img').click
      find('.following-js').click
      expect(page).to have_css('.follow-count-js', text: '1')
      click_on 'フォロワー'
      expect(current_path).to eq account_follower_list_path(user)
      expect(page).to have_css('.relationship_display_name', text: other_user.nickname.nickname)
    end

    it 'フォローリストを閲覧できること', js: true do
      sign_in other_user
      visit root_path
      find('.team_center_icon').find('img').click
      find('.following-js').click
      expect(page).to have_css('.follow-count-js', text: '1')
      find('.fa-user-circle').click
      expect(current_path).to eq profile_path
      click_on 'フォロー中'
      expect(current_path).to eq account_following_list_path(other_user)
      expect(page).to have_css('.relationship_display_name', text: user.nickname.nickname)
    end
  end

  context 'ログインしていない場合' do
    it 'サインインページに遷移すること' do
      visit profile_path
      expect(current_path).to eq new_user_session_path
      expect(page).to have_content 'Email'
      expect(page).to have_content 'Password'
      expect(page).to have_content 'Googleでログイン'
    end
  end
end
