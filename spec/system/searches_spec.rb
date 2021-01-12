require 'rails_helper'

RSpec.describe 'Searches', type: :system do
  let(:user) { create(:user) }
  before do
    @teams_tags = []
    3.times do |team|
      team = FactoryBot.build(
        :teams_tag,
        user_id: user.id,
        image: fixture_file_upload('spec/fixtures/images/test_image.png')
      )
      team.save
      @teams_tags << team
    end
  end

  context '検索する場合' do
    it 'チーム名で検索できること', js: true do
      has_three_team(@teams_tags)
      fill_in 'キーワードから探す',	with: @teams_tags.first.team_name
      click_search
      exists_team_first_only(@teams_tags)
    end

    it 'チーム説明で検索できること', js: true do
      has_three_team(@teams_tags)
      fill_in 'キーワードから探す',	with: @teams_tags.first.introduction
      click_search
      exists_team_first_only(@teams_tags)
    end

    it 'タグ名で検索できること', js: true do
      has_three_team(@teams_tags)
      fill_in 'キーワードから探す',	with: @teams_tags.first.name
      click_search
      exists_team_first_only(@teams_tags)
    end

    it 'カテゴリーで検索できること', js: true do
      has_three_team(@teams_tags)
      find('#category_id').find("option[value='#{@teams_tags.first.category_id}']").select_option
      click_search
      expect(page).to have_content @teams_tags.first.team_name
    end

    it '空のまま検索したらすべてのチームを返すこと', js: true do
      has_three_team(@teams_tags)
      fill_in 'キーワードから探す',	with: nil
      click_search
      exists_all_team(@teams_tags)
    end
  end

  context '検索できない場合' do
    it '検索結果が1件も見つからなければ空を返すこと', js: true do
      has_three_team(@teams_tags)
      fill_in 'キーワードから探す',	with: @teams_tags.first.name + 'test'
      click_search
      empty_team(@teams_tags)
    end
  end
end
