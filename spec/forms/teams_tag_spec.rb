require 'rails_helper'

RSpec.describe TeamsTag, type: :model do
  describe '#create' do
    let!(:user) { create(:user) }
    let!(:teams_tag) { build(:teams_tag, user_id: user.id, image: fixture_file_upload('spec/fixtures/images/test_image.png')) }

    context 'チーム作成が成功する場合' do
      it 'category_id, team_name, period_id, introduction, name, user_id, imageがあれば保存できること' do
        expect(teams_tag).to be_valid
      end
    end

    context 'チーム作成が成功しない場合' do
      it 'category_idを選択されなければ保存できないこと' do
        teams_tag.category_id = nil
        teams_tag.valid?
        expect(teams_tag.errors.full_messages).to include("Category can't be blank")
      end

      it 'team_nameが空では保存できないこと' do
        teams_tag.team_name = nil
        teams_tag.valid?
        expect(teams_tag.errors.full_messages).to include("Team name can't be blank")
      end

      it 'team_nameが16文字以上は保存できないこと' do
        teams_tag.team_name = Faker::Lorem.characters(number: 16)
        teams_tag.valid?
        expect(teams_tag.errors.full_messages).to include('Team name is too long (maximum is 15 characters)')
      end

      it 'period_idを選択されなければ保存できないこと' do
        teams_tag.period_id = nil
        teams_tag.valid?
        expect(teams_tag.errors.full_messages).to include("Period can't be blank")
      end

      it 'introductionが空では保存できないこと' do
        teams_tag.introduction = nil
        teams_tag.valid?
        expect(teams_tag.errors.full_messages).to include("Introduction can't be blank")
      end

      it 'introductionが401文字以上は保存できないこと' do
        teams_tag.introduction = Faker::Lorem.characters(number: 401)
        teams_tag.valid?
        expect(teams_tag.errors.full_messages).to include('Introduction is too long (maximum is 400 characters)')
      end

      it 'name(tag)が空では保存できないこと' do
        teams_tag.name = nil
        teams_tag.valid?
        expect(teams_tag.errors.full_messages).to include("Name can't be blank")
      end

      it 'user_idが空では保存できないこと' do
        teams_tag.user_id = nil
        teams_tag.valid?
        expect(teams_tag.errors.full_messages).to include("User can't be blank")
      end

      it 'imageが空では保存できないこと' do
        teams_tag.image = nil
        teams_tag.valid?
        expect(teams_tag.errors.full_messages).to include("Image can't be blank")
      end
    end
  end
end
