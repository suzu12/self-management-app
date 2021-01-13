require 'rails_helper'

RSpec.describe 'Api::Likes', type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  before do
    @team = FactoryBot.build(
      :teams_tag,
      user_id: user.id,
      image: fixture_file_upload('spec/fixtures/images/test_image.png')
    )
    @team.save
  end
  let(:like) { create(:like, user_id: user.id, team_id: @team.save.id) }

  describe 'GET /api/like' do
    context 'ログインしている場合' do
      it '200 Status', js: true do
        sign_in other_user
        get api_like_path(team_id: Team.last.id)
        expect(response).to have_http_status(200)
      end
    end

    context 'ログインしていない場合' do
      it '302 Status', js: true do
        get api_like_path(team_id: Team.last.id)
        expect(response).to have_http_status(302)
      end
    end
  end

  describe 'POST /api/like' do
    context 'ログインしている場合' do
      it '200 Status', js: true do
        sign_in other_user
        post api_like_path(team_id: Team.last.id)
        expect(response).to have_http_status(200)
      end
    end

    context 'ログインしていない場合' do
      it '302 Status', js: true do
        post api_like_path(team_id: Team.last.id)
        expect(response).to have_http_status(302)
      end
    end
  end

  describe 'DELETE /api/like' do
    context 'ログインしている場合' do
      it '200 Status', js: true do
        sign_in other_user
        post api_like_path(team_id: Team.last.id)
        delete api_like_path(team_id: Team.last.id)
        expect(response).to have_http_status(200)
      end
    end

    context 'ログインしていない場合' do
      it '302 Status', js: true do
        post api_like_path(team_id: Team.last.id)
        delete api_like_path(team_id: Team.last.id)
        expect(response).to have_http_status(302)
      end
    end
  end
end
