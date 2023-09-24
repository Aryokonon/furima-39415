require 'rails_helper'

RSpec.describe Item, type: :model do
  before(:each) do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.build(:item, user: @user)

    # Create and attach a sample image to @item
    image_blob = FactoryBot.create(:active_storage_blob)
    @item.image.attach(image_blob)
  end

  describe 'アイテム登録が成功する場合' do
    it '正しい属性と画像が添付されていれば有効であること' do
      expect(@item).to be_valid
    end
  end

  describe 'アイテム登録が失敗する場合' do
    it '画像が添付されていなければ無効であること' do
      @item.image = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Image can't be blank")
    end

    it '名前が空であれば無効であること' do
      @item.name = ''
      @item.valid?
      expect(@item.errors.full_messages).to include('Name 商品名が必須です')
    end

    it '説明が空であれば無効であること' do
      @item.description = ''
      @item.valid?
      expect(@item.errors.full_messages).to include('Description 商品の説明が必須です')
    end

    it '価格が空であれば無効であること' do
      @item.price = ''
      @item.valid?
      expect(@item.errors.full_messages).to include('Price 価格が必須です')
    end

    it '価格が¥300未満であれば無効であること' do
      @item.price = 299
      @item.valid?
      expect(@item.errors.full_messages).to include('Price は¥300以上、¥9,999,999以下で入力してください')
    end

    it 'category_idの値が不正であれば無効であること' do
      @item.category_id = 1
      @item.valid?
      expect(@item.errors[:category_id]).to include('must be selected')
    end

    it 'condition_idの値が不正であれば無効であること' do
      @item.condition_id = 1
      @item.valid?
      expect(@item.errors[:condition_id]).to include('must be selected')
    end

    it 'delivery_fee_idの値が不正であれば無効であること' do
      @item.delivery_fee_id = 1
      @item.valid?
      expect(@item.errors[:delivery_fee_id]).to include('must be selected')
    end

    it 'prefecture_idの値が不正であれば無効であること' do
      @item.prefecture_id = 1
      @item.valid?
      expect(@item.errors[:prefecture_id]).to include('must be selected')
    end

    it 'shipping_day_idの値が不正であれば無効であること' do
      @item.shipping_day_id = 1
      @item.valid?
      expect(@item.errors[:shipping_day_id]).to include('must be selected')
    end
  end

  describe '#売り切れ?' do
    let(:order) { FactoryBot.create(:order, item: @item) }

    it 'アイテムが売り切れの場合、trueを返すこと' do
      expect(@item.sold_out?).to eq false
    end

    it 'アイテムが売り切れでない場合、falseを返すこと' do
      @item.order = nil
      expect(@item.sold_out?).to eq false
    end
  end
end
