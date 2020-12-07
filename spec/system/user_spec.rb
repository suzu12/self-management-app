require 'rails_helper'

RSpec.describe 'User', type: :system do
  context 'ログインしていない場合' do
    it 'トップページに遷移し、サインアップページに遷移する' do
      visit root_path
      expect(page).to have_content('Signup')
      click_on('Signup')
      expect(current_path).to eq new_user_registration_path
      has_button?('input[name="commit"]')
    end

    it 'トップページに遷移し、サインインページに遷移する' do
      visit root_path
      expect(page).to have_content('Login')
      click_on('Login')
      expect(current_path).to eq new_user_session_path
      expect(page).to have_content('Email')
      expect(page).to have_content('Password')
      has_button?('input[name="commit"]')
    end
  end

  context 'アカウントを持っていてログインをする場合' do
    let!(:user) { create(:user) }

    it 'ログインしてからログアウトをする' do
      visit new_user_session_path
      fill_in 'user_email',	with: user.email
      fill_in 'user_password',	with: user.password
      click_button('LOGIN')

      expect(current_path).to eq root_path
      click_on('ログアウト')

      expect(page).to have_content('Signup')
      expect(page).to have_content('Login')
      expect(current_path).to eq root_path
    end

    it 'ログインに失敗し、再びサインインページに戻ってくる' do
      visit new_user_session_path

      fill_in 'user_email',	with: 'test'
      fill_in 'user_password',	with: 'test'
      click_button('LOGIN')

      expect(page).to have_content('Email')
      expect(page).to have_content('Password')
      expect(current_path).to eq new_user_session_path
    end
  end
end
