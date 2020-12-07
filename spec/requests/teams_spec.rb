require 'rails_helper'

RSpec.describe 'TeamsController', type: :request do
  before do
    @user = FactoryBot.create(:user)

    @teams_tags = []
    3.times do |team|
      team = FactoryBot.build(:teams_tag, user_id: @user.id, image: fixture_file_upload('spec/fixtures/images/test_image.png'))
      team.save
      @teams_tags << team
    end
  end

  describe 'GET /teams' do
    it '200ステータスが返ってくる' do
      get teams_path
      expect(response).to have_http_status(200)
    end
  end
end
