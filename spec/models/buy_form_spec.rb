require 'rails_helper'

RSpec.describe BuyForm, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @buy_form = FactoryBot.build(:buy_form, user_id: @user.id, item_id: @item.id)
    sleep 0.1
  end

  describe '配送先情報の保存' do
    context '配送先情報の保存ができるとき' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@buy_form).to be_valid
      end

      it '建物名がなくても保存できる' do
        @buy_form.building_name = nil
        expect(@buy_form).to be_valid
      end
    end

    context '配送先情報の保存ができないとき' do
      it 'user_idが空のとき' do
        @buy_form.user_id = nil
        @buy_form.valid?
        expect(@buy_form.errors.full_messages).to include("User can't be blank")
      end

      it 'item_idが空のとき' do
        @buy_form.item_id = nil
        @buy_form.valid?
        expect(@buy_form.errors.full_messages).to include("Item can't be blank")
      end

      it '郵便番号が空のとき' do
        @buy_form.post_number = ''
        @buy_form.valid?
        expect(@buy_form.errors.full_messages).to include("Post number can't be blank")
      end

      it '郵便番号にハイフンがないとき' do
      @buy_form.post_number = '1234567'
      @buy_form.valid?
      expect(@buy_form.errors.full_messages).to include("Post number is invalid. Include hyphen(-)")
       end

      it '都道府県が「---」のとき' do
        @buy_form.ship_region_id = '0'
        @buy_form.valid?
        expect(@buy_form.errors.full_messages).to include("Ship region can't be blank")
      end

      it '市町村が空のとき' do
        @buy_form.city = ''
        @buy_form.valid?
        expect(@buy_form.errors.full_messages).to include("City can't be blank")
      end


      it '番地が空のとき' do
        @buy_form.house_number = ''
        @buy_form.valid?
        expect(@buy_form.errors.full_messages).to include("House number can't be blank")
      end

      it '電話番号が空のとき'do
        @buy_form.phone_number = ''
        @buy_form.valid?
        expect(@buy_form.errors.full_messages).to include("Phone number can't be blank")
      end


      it '電話番号が9桁以下では購入できない' do
        @buy_form.phone_number = '12345678'
        @buy_form.valid?
        expect(@buy_form.errors.full_messages).to include("Phone number must be 10 or 11 digits long")
      end

      it '電話番号が12桁以上では購入できない' do
        @buy_form.phone_number = '0123456789123'
        @buy_form.valid?
        expect(@buy_form.errors.full_messages).to include("Phone number must be 10 or 11 digits long")
      end
   

      it '数字以外の文字が入ったとき'do
        @buy_form.phone_number = '1234abcd'
        @buy_form.valid?
        expect(@buy_form.errors.full_messages).to include("Phone number must be 10 or 11 digits long")
      end



      it "tokenが空では登録できないこと" do
        @buy_form.token = nil
        @buy_form.valid?
        expect(@buy_form.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end