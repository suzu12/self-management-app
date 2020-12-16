require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    let!(:user) { build(:user) }

    it 'email, password, password_confirmationが存在すれば登録できること' do
      expect(user).to be_valid
    end

    it 'emailが空では登録できないこと' do
      user.email = nil
      user.valid?
      expect(user.errors.full_messages).to include("Email can't be blank")
    end

    it 'passwordが空では登録できないこと' do
      user.password = nil
      user.valid?
      expect(user.errors.full_messages).to include("Password can't be blank")
    end

    it 'emailはがないと登録できないこと' do
      user.email = 'emailemail'
      user.valid?
      expect(user.errors.full_messages).to include('Email is invalid')
    end

    it 'passwordが6文字以上で半角英数字含めれば登録できること' do
      test = 'test12'
      user.password = test
      user.password_confirmation = test
      expect(user).to be_valid
    end

    it 'passwordが6文字以上でも英語のみだと登録できないこと' do
      test = 'aaaaaa'
      user.password = test
      user.password_confirmation = test
      user.valid?
      expect(user.errors.full_messages).to include('Password は英字と数字の両方を含めて設定してください')
    end

    it 'passwordが6文字以上でも数字のみだと登録できないこと' do
      test = '123456'
      user.password = test
      user.password_confirmation = test
      user.valid?
      expect(user.errors.full_messages).to include('Password は英字と数字の両方を含めて設定してください')
    end

    it 'passwordが5文字以下であれば登録できないこと' do
      test = 'ab123'
      user.password = test
      user.password_confirmation = test
      user.valid?
      expect(user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end

    it 'passwordとpassword_confirmationが不一致では登録できないこと' do
      user.password = 'abc123'
      user.password_confirmation = 'test12'
      user.valid?
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it '重複したemailが存在する場合登録できないこと' do
      user.save
      another_user = FactoryBot.build(:user)
      another_user.email = user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Email has already been taken')
    end
  end
end
