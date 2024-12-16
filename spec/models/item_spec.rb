require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '商品出品可能' do
      it 'nameとdescriptionとprice（300から9999999）と画像が存在しており、category_id、status_id、shipping_fee_id、prefecture_idが2以上が選択されているとき' do
        expect(@item).to be_valid
      end
    end
    context '商品出品不可能' do
      it 'nameが空では出品できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Name can't be blank"
      end
      it 'descriptionが空では出品できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Description can't be blank"
      end
      it '画像が空では出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "Image can't be blank"
      end
      it 'category_idが0では出品できない' do
        @item.category_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include "Category can't be blank"
      end
      it 'status_idが0では出品できない' do
        @item.status_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include "Status can't be blank"
      end
      it 'ship_fee_idが0では出品できない' do
        @item.ship_fee_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include "Ship fee can't be blank"
      end
      it 'ship_region_idが0では出品できない' do
        @item.ship_region_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include "Ship region can't be blank"
      end
      it 'ship_wait_idが0では出品できない' do
        @item.ship_wait_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include "Ship wait can't be blank"
      end
      it 'priceが空では出品できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Price can't be blank"
      end
      it 'priceが半角数字以外では登録できない' do
        @item.price = 'abcdgggs'
        @item.valid?
        expect(@item.errors.full_messages).to include "Price is not a number"
      end
      it 'priceが300未満では出品できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include "Price must be greater than or equal to 300"
      end
      it 'priceが1000万以上では出品できない' do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include "Price must be less than or equal to 9999999"
      end
      it 'userが紐づいていないと出品できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "User must exist"
      end
    end
  end
end