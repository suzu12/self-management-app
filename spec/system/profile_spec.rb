require 'rails_helper'

RSpec.describe 'Profile', type: :system do
  let!(:user) { create(:user, :with_profile) }
  let!(:nickname) { create(:nickname, user: user) }

  context 'ログインしている場合' do
    before do
      sign_in user
    end

    it '自分のプロフィールを確認できる' do
      visit profile_path
      expect(page).to have_css('.profilePage_user_info', text: user.nickname.nickname)
      expect(page).to have_css('.profilePage_user_info', text: user.profile.gender)
    end
  end
end
