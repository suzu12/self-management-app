require 'rails_helper'

RSpec.describe 'Comments', type: :system do
  let(:user)       { create(:user) }
  let(:other_user) { create(:user) }
  before do
    @team = FactoryBot.build(:teams_tag, user_id: user.id, image: fixture_file_upload('spec/fixtures/images/test_image.png'))
    @team.save
  end

  context 'ログインしている場合' do
    it 'コメントができること', js: true do
      sign_in other_user
      visit team_path(user.teams.last)
      expect(page).to have_css('.team_name', text: @team.team_name)
      expect(page).to have_content('コメントを書く')
      expect(page).to have_css('.comment-header > p', text: '0')

      find('.show-comment-form').click
      fill_in 'comment_content',	with: 'こんにちは'
      expect  do
        find('.add-comment-button').click
        sleep 0.5
      end.to change { Comment.count }.by(1)

      expect(page).to have_content 'こんにちは'
      expect(page).to have_css('.comment-header > p', text: '1')
    end
  end

  context 'ログインしていない場合' do
    it 'コメントをしても反映されないこと', js: true do
      visit team_path(user.teams.last)
      expect(page).to have_css('.team_name', text: @team.team_name)
      expect(page).to have_content('コメントを書く')
      expect(page).to have_css('.comment-header > p', text: '0')

      find('.show-comment-form').click
      fill_in 'comment_content',	with: 'こんにちは'
      expect  do
        find('.add-comment-button').click
        sleep 0.5
      end.to change { Comment.count }.by(0)

      visit team_path(user.teams.last)
      expect(page).to have_no_content 'こんにちは'
      expect(page).to have_css('.comment-header > p', text: '0')
    end
  end
  context 'コメント欄になにも入力しない場合' do
    it '投稿できないこと', js: true do
      sign_in other_user
      visit team_path(user.teams.last)
      expect(page).to have_css('.team_name', text: @team.team_name)
      expect(page).to have_content('コメントを書く')
      expect(page).to have_css('.comment-header > p', text: '0')

      find('.show-comment-form').click
      fill_in 'comment_content',	with: nil
      expect  do
        find('.add-comment-button').click
        sleep 0.5
      end.to change { Comment.count }.by(0)
    end
  end
end
