require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '正常系' do
      it '正常にユーザ登録できる' do
        expect(@user.valid?).to eq true
      end
    end
    context '異常系' do
      it 'ニックネームが必須であること' do
        @user.nickname = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'メールアドレスが必須であること' do
        @user.email = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'メールアドレスが一意性であること' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'メールアドレスは@を含む必要があること' do
        @user.email = 'test.co.jp'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'パスワードが必須であること' do
        @user.password = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'パスワードは6文字以上であること' do
        @user.password = '00000a'
        @user.password_confirmation = '00000a'
        expect(@user).to be_valid
      end
      it 'パスワードは半角英数字混合であること' do
        @user.password = 'half-width alphanumeric'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end
      it 'パスワードは確認用を含めて2回入力すること' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'ユーザー本名の名字が必須であること' do
        @user.family_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name is invalid')
      end

      it 'ユーザー本名の名前が必須であること' do
        @user.first_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include('First name is invalid')
      end

      it 'ユーザー本名は全角（漢字・ひらがな・カタカナ）で入力させること' do
        @user.family_name = 'kanji,hiragana,katakana'
        @user.first_name = 'kanji,hiragana,katakana'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name is invalid')
      end
      it 'ユーザー本名のフリガナの、名字が必須であること' do
        @user.family_kana = nil
        @user.valid?
        expect(@user.errors.full_messages).to include('Family kana is invalid')
      end

      it 'ユーザー本名フリガナの、名前が必須であること' do
        @user.first_kana = nil
        @user.valid?
        expect(@user.errors.full_messages).to include('First kana is invalid')
      end

      it 'ユーザー本名のフリガナは全角（カタカナ）で入力させること' do
        @user.family_kana = 'kana'
        @user.first_kana = 'kana'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family kana is invalid')
      end

      it '生年月日が必須であること' do
        @user.birth_date = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth date can't be blank")
      end
    end
  end
end
