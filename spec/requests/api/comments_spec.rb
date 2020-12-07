require 'rails_helper'

RSpec.describe 'Api::Comments', type: :request do
  let!(:user) { create(:user) }
  let!(:teams_tag) { build(:teams_tag, user_id: user.id, image: fixture_file_upload('spec/fixtures/images/test_image.png')) }
  let!(:comments) { create_list(:comment, 3, team_id: teams_tag.save.team_id) }

  describe 'GET /api/comments' do
    it '200 Status' do
      get api_comments_path(team_id: Team.last.id)
      expect(response).to have_http_status(200)

      body = JSON.parse(response.body)
      expect(body.length).to eq 3
      expect(body[0]['content']).to eq comments.first.content
      expect(body[1]['content']).to eq comments.second.content
      expect(body[2]['content']).to eq comments.third.content
    end
  end
end
