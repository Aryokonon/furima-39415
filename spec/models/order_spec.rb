require 'rails_helper'

RSpec.describe Order, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item, user: @user)
    @order = FactoryBot.build(:order_form, user_id: @user.id, item_id: @item.id)
  end

  context '注文が有効な場合' do
    it '正しい属性を持つ場合は有効であること' do
      expect(@order).to be_valid
    end
  end

  context '注文が無効な場合' do
    it 'トークンがない場合は無効であること' do
      @order.token = nil
      @order.valid?
      expect(@order.errors.full_messages).to include("Token can't be blank")
    end

    it '建物名が入力されていなくても購入できること' do
      @order.building_name = nil
      expect(@order).to be_valid
    end

    it '市区町村が必要であること' do
      @order.city = nil
      @order.valid?
      expect(@order.errors.full_messages).to include("City can't be blank")
    end

    it '建物名が必要であること' do
      @order.building_name = nil
      @order.valid?
      expect(@order.errors.full_messages).to include("Building name can't be blank")
    end

    it '番地が必要であること' do
      @order.street = nil
      @order.valid?
      expect(@order.errors.full_messages).to include("Street can't be blank")
    end

    it '郵便番号が必要であること' do
      @order.postal_code = nil
      @order.valid?
      expect(@order.errors.full_messages).to include("Postal code can't be blank")
    end

    it '郵便番号のフォーマットが正しいこと' do
      @order.postal_code = '1234'
      @order.valid?
      expect(@order.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
    end

    it '電話番号が必要であること' do
      @order.phone_number = nil
      @order.valid?
      expect(@order.errors.full_messages).to include("Phone number can't be blank")
    end

    it '電話番号のフォーマットが正しいこと' do
      @order.phone_number = '123'
      @order.valid?
      expect(@order.errors.full_messages).to include('Phone number should be 10 to 11 digits')
    end

    it '都道府県が必要であること' do
      @order.prefecture_id = nil
      @order.valid?
      expect(@order.errors.full_messages).to include("Prefecture can't be blank")
    end

    it '都道府県が1以外であること' do
      @order.prefecture_id = 1
      @order.valid?
      expect(@order.errors.full_messages).to include("Prefecture can't be blank")
    end

    it '10桁未満の場合は無効であること' do
      @order.phone_number = '123456789'
      @order.valid?
      expect(@order.errors.full_messages).to include('Phone number should be 10 to 11 digits')
    end

    it '11桁を超える場合は無効であること' do
      @order.phone_number = '123456789012'
      @order.valid?
      expect(@order.errors.full_messages).to include('Phone number should be 10 to 11 digits')
    end

    it '半角数字以外が含まれている場合は無効であること' do
      @order.phone_number = 'abcdefghij'
      @order.valid?
      expect(@order.errors.full_messages).to include('Phone number should be 10 to 11 digits')
    end

    it 'userが紐づいていない場合は無効であること' do
      @order.user_id = nil
      @order.valid?
      expect(@order.errors.full_messages).to include("User can't be blank")
    end

    it 'itemが紐づいていない場合は無効であること' do
      @order.item_id = nil
      @order.valid?
      expect(@order.errors.full_messages).to include("Item can't be blank")
    end
  end
end
