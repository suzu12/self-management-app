require 'rails_helper'

RSpec.describe Nickname, type: :model do
  describe '#create' do
    let!(:nickname) { build(:nickname) }

    context 'nicknameを入力している場合' do
      it '登録できる' do
        expect(nickname).to be_valid
      end
    end

    context 'nicknameを入力していない場合' do
      it '登録できない' do
        nickname.nickname = nil
        nickname.valid?
        expect(nickname.errors.full_messages).to include("Nickname can't be blank")
      end
    end
  end
end
