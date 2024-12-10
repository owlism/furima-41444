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
      it 'ニックネームが空だと登録できない' do
        @user.nickname = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'メールアドレスが空だと登録できない' do
        @user.email = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it '既に存在するメールアドレスと重複する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'メールアドレスに@を含まない場合登録できない' do
        @user.email = 'test.co.jp'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'パスワードが空だと登録できない' do
        @user.password = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'パスワードは6文字未満の場合、登録できない' do
        @user.password = '00000a'
        @user.password_confirmation = '00000a'
        expect(@user).to be_valid
      end

      it 'passwordで半角英字のみでは登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end

      it 'passwordで半角数字のみでは登録できない' do
        @user.password = '000000'
        @user.password_confirmation = '000000'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end

      it '全角文字を含むパスワードでは登録できない' do
        @user.password = 'ａａa １１1'
        @user.password_confirmation = 'ａａa １１1'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end
      it '確認用パスワードが空の場合、登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'ユーザー本名の名字が空の場合、登録できない' do
        @user.family_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name is invalid')
      end

      it 'ユーザー本名の名前が空の場合、登録できない' do
        @user.first_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include('First name is invalid')
      end

      it 'ユーザー名字を全角（漢字・ひらがな・カタカナ）で入力しない場合は登録できない' do
        @user.family_name = 'kanji,hiragana,katakana'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name is invalid')
      end
      it 'ユーザー本名を全角（漢字・ひらがな・カタカナ）で入力しない場合は登録できない' do
        @user.first_name = 'kanji,hiragana,katakana'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name is invalid')
      end
      it 'ユーザー本名のフリガナの、名字が空の場合、登録できない' do
        @user.family_kana = nil
        @user.valid?
        expect(@user.errors.full_messages).to include('Family kana is invalid')
      end

      it 'ユーザー本名フリガナが空の場合、登録できない' do
        @user.first_kana = nil
        @user.valid?
        expect(@user.errors.full_messages).to include('First kana is invalid')
      end
      it 'ユーザー本名のフリガナは全角（カタカナ）で入力しないと登録できない' do
        @user.first_kana = 'kana'
        @user.valid?
        expect(@user.errors.full_messages).to include('First kana is invalid')
      end
      it 'ユーザー名字のフリガナは全角（カタカナ）で入力しないと登録できない' do
        @user.family_kana = 'kana'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family kana is invalid')
      end
      it '生年月日が空の場合、登録できない' do
        @user.birth_date = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth date can't be blank")
      end
    end
  end
end
