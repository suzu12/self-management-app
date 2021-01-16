require 'rails_helper'

RSpec.describe 'Team', type: :system do
  let!(:user) { create(:user) }
  before do
    @teams_tags = []
    3.times do |team|
      team = FactoryBot.build(:teams_tag, user_id: user.id, image: fixture_file_upload('spec/fixtures/images/test_image.png'))
      team.save
      @teams_tags << team
    end
  end

  it 'チーム一覧が表示される' do
    visit root_path
    @teams_tags.each do |team|
      expect(page).to have_css('.team_name', text: team.team_name)
    end
  end

  it 'チーム詳細を表示できる' do
    visit root_path

    team = @teams_tags.first
    click_on team.team_name

    expect(page).to have_css('.team_name', text: team.team_name)
    expect(page).to have_css('.team_introduction', text: team.introduction)
  end

  context 'ログインしている場合' do
    before do
      sign_in user
    end

    it 'チームを編集できる' do
      visit root_path

      team = @teams_tags.first
      click_on team.team_name

      click_on '編集する'
      fill_in 'team_team_name',	with: 'test'
      find('input[name="commit"]').click

      expect(page).to have_content('編集できました！')
      expect(page).to have_css('.team_name', text: 'test')
    end

    it 'チームを削除できる' do
      visit root_path

      team = @teams_tags.first
      click_on team.team_name

      click_on '削除する'
      expect(page).to have_content('削除することができました！')
      expect(current_path).to eq root_path
    end
  end
end
