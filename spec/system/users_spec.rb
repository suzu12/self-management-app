require 'rails_helper'

RSpec.describe 'Users', type: :system do
  context 'アカウントを持っていない場合' do
    let(:user) { build(:user) }

    it 'サインアップページに遷移すること' do
      visit root_path
      expect(page).to have_content('Signup')
      click_on('Signup')
      expect(current_path).to eq new_user_registration_path
      has_button?('input[name="commit"]')
    end

    it 'Email, Password, PasswordConfirmationを直接入力し、新規登録をすること' do
      visit new_user_registration_path
      fill_in 'user_email',	                with: user.email
      fill_in 'user_password',              with: user.password
      fill_in 'user_password_confirmation', with: user.password_confirmation
      click_on 'CREATE ACCOUNT'

      expect(page).to have_content('アプリ内で使う名前を決めよう')
      fill_in 'nickname_nickname',	with: 'サトウ'
      expect  do
        click_on "Let's Enjoy"
      end.to change { User.count }.by(1)

      expect(current_path).to eq root_path
      expect(page).to have_content('作成できました')
    end

    it 'パスワード(確認用)を間違えて新規登録に失敗し、同じページに戻ってくること' do
      visit new_user_registration_path
      fill_in 'user_email',	                with: user.email
      fill_in 'user_password',              with: user.password
      fill_in 'user_password_confirmation', with: 'abc123'
      expect  do
        click_on 'CREATE ACCOUNT'
      end.to change { User.count }.by(0)

      expect(page).to have_content("Password confirmation doesn't match Password")
      expect(page).to have_content('Googleで登録')
      expect(current_path).to eq '/users'
    end

    it 'Google認証で登録すること', js: true do
      visit new_user_registration_path
      click_on 'Googleで登録'
      click_on 'CREATE ACCOUNT'
      expect(page).to have_content('アプリ内で使う名前を決めよう')
      fill_in 'nickname_nickname',	with: 'サトウ'
      expect  do
        click_on "Let's Enjoy"
        sleep 0.5
      end.to change { User.count }.by(1)

      expect(current_path).to eq root_path
      expect(page).to have_content('作成できました')
    end
  end

  context 'アカウントを持っている場合' do
    before do
      @user = User.create(
        email: 'test@example.com',
        password: 'test12'
      )
    end

    it 'サインインページに遷移すること' do
      visit root_path
      expect(page).to have_content('Login')
      click_on('Login')
      expect(current_path).to eq new_user_session_path
      expect(page).to have_content('Email')
      expect(page).to have_content('Password')
      has_button?('input[name="commit"]')
    end

    it 'ログインした後、ログアウトできること' do
      visit new_user_session_path
      fill_in 'user_email',	with: @user.email
      fill_in 'user_password',	with: @user.password
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

    it 'Googleでログインすること' do
      visit new_user_session_path
      click_on 'Googleでログイン'

      expect(page).to have_no_content('Signup')
      expect(page).to have_no_content('Login')
      expect(current_path).to eq root_path
    end
  end
end
