require 'rails_helper'

RSpec.describe Order, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item, user: @user)
    @order = FactoryBot.build(:order, user: @user, item: @item)
  end

  context '注文が有効な場合' do
    it '正しい属性を持つ場合は有効であること' do
      expect(@order).to be_valid
    end
  end

  context '注文が無効な場合' do
    it '価格がない場合は無効であること' do
      @order.price = nil
      @order.valid?
      expect(@order.errors.full_messages).to include('Priceは空白にできません')
    end

    it 'トークンがない場合は無効であること' do
      @order.token = nil
      @order.valid?
      expect(@order.errors.full_messages).to include('Tokenは空白にできません')
    end
  end

  it 'ユーザーに所属する' do
    expect(@order).to belong_to(:user)
  end

  it '商品に所属する' do
    expect(@order).to belong_to(:item)
  end

  it '配送先が1つある' do
    expect(@order).to have_one(:shipping_address)
  end
end
