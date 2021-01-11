require 'rails_helper'

RSpec.describe 'Chats', type: :system do
  let(:user)       { create(:user) }
  let(:other_user) { create(:user) }
  before do
    @team = FactoryBot.build(:teams_tag, user_id: user.id, image: fixture_file_upload('spec/fixtures/images/test_image.png'))
    @team.save
  end

  describe '#index' do
    context 'ログインしている場合' do
      it 'いいねができること', js: true do
        sign_in other_user
        visit root_path
        expect(page).to have_css('.team_name', text: @team.team_name)
        expect do
          find('.in-active-star').click
          sleep 0.5
        end.to change { Like.count }.by(1)
      end

      it 'いいねを取り消すことができること', js: true do
        sign_in other_user
        visit root_path
        expect(page).to have_css('.team_name', text: @team.team_name)
        find('.in-active-star').click
        sleep 0.5
        expect do
          find('.active-star').click
          sleep 0.5
        end.to change { Like.count }.by(-1)
      end

      it 'チーム作成者はいいねができないこと' do
        sign_in user
        visit root_path
        expect(page).to have_css('.team_name', text: @team.team_name)
        expect(page).to have_no_css('.team_star')
      end
    end
    context 'ログインしていない場合' do
      it 'いいねができないこと', js: true do
        visit root_path
        expect(page).to have_css('.team_name', text: @team.team_name)
        expect(page).to have_no_css('.team_star')
      end
    end
  end

  describe '#show' do
    context 'ログインしている場合' do
      it 'いいねができること', js: true do
        sign_in other_user
        visit team_path(user.teams.last)
        expect(page).to have_css('.team_name', text: @team.team_name)
        expect(page).to have_css('.star_counter > span', text: '0')
        expect do
          find('.in-active-star').click
          sleep 0.5
        end.to change { Like.count }.by(1)

        expect(page).to have_css('.star_counter > span', text: '1')
      end

      it 'いいねを取り消すことができること', js: true do
        sign_in other_user
        visit team_path(user.teams.last)
        find('.in-active-star').click
        sleep 0.5
        expect do
          find('.active-star').click
          sleep 0.5
        end.to change { Like.count }.by(-1)
      end

      it 'チーム作成者はいいねができないこと' do
        sign_in user
        visit team_path(user.teams.last)
        expect(page).to have_css('.team_name', text: @team.team_name)
        expect(page).to have_no_css('.team_star')
      end
    end

    context 'ログインしていない場合' do
      it 'いいねができないこと', js: true do
        visit team_path(user.teams.last)
        expect(page).to have_css('.team_name', text: @team.team_name)
        expect(page).to have_no_css('.team_star')
      end
    end
  end
end
