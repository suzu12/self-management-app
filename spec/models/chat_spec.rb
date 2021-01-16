require 'rails_helper'

RSpec.describe Chat, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.create(:user)
      @teams_tag = FactoryBot.build(:teams_tag, user_id: @user.id,
                                                image: fixture_file_upload('spec/fixtures/images/test_image.png'))
      @chat = FactoryBot.build(:chat, user_id: @user.id, team_id: @teams_tag.save.team_id)
    end

    context 'チャット送信が成功する場合' do
      it 'contentとphotoがあれば保存できること' do
        expect(@chat).to be_valid
      end

      it 'contentが空でもphotoがあれば保存できること' do
        @chat.content = nil
        expect(@chat).to be_valid
      end

      it 'photoが空でもcontentがあれば保存できること' do
        @chat.photo = nil
        expect(@chat).to be_valid
      end
    end

    context 'チャット送信が成功しない場合' do
      it 'contentとphotoが空では保存できないこと' do
        @chat.content = nil
        @chat.photo = nil
        @chat.valid?
        expect(@chat.errors.full_messages).to include("Content can't be blank")
      end

      it 'teamが紐付いていないと保存できないこと' do
        @chat.team_id = nil
        @chat.valid?
        expect(@chat.errors.full_messages).to include('Team must exist')
      end

      it 'userが紐付いていないと保存できないこと' do
        @chat.user_id = nil
        @chat.valid?
        expect(@chat.errors.full_messages).to include('User must exist')
      end
    end
  end
end
