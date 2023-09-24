# require 'rails_helper'

# RSpec.describe Item, type: :model do
#   describe 'Associations' do
#     it { is_expected.to belong_to(:user) }
#     it { is_expected.to have_one(:order) }
#     it { is_expected.to belong_to(:category) }
#     it { is_expected.to belong_to(:condition) }
#     it { is_expected.to belong_to(:delivery_fee) }
#     it { is_expected.to belong_to(:prefecture) }
#     it { is_expected.to belong_to(:shipping_day) }
#   end

#   describe 'Validations' do
#     subject { FactoryBot.build(:item) }

#     it { is_expected.to validate_presence_of(:name).with_message('を入力してください') }
#     it { is_expected.to validate_presence_of(:description).with_message('を入力してください') }
#     it { is_expected.to validate_presence_of(:price).with_message('を入力してください') }

#     it 'is invalid without an image' do
#       subject.image = nil
#       is_expected.to_not be_valid
#     end

#     it { is_expected.to validate_numericality_of(:price).only_integer }
#     it do
#       is_expected.to validate_inclusion_of(:price)
#         .in_range(300..9_999_999)
#         .with_message('は設定範囲外です')
#     end

#     it 'is invalid with incorrect category_id value' do
#       subject.category_id = 1
#       is_expected.to_not be_valid
#       expect(subject.errors[:category_id]).to include('を選択してください')
#     end

#     # Include other similar tests for condition_id, delivery_fee_id, prefecture_id, shipping_day_id
#   end

#   describe '#sold_out?' do
#     let(:user) { FactoryBot.create(:user) }
#     let(:item) { FactoryBot.create(:item, user: user) }
#     let(:order) { FactoryBot.create(:order, item: item) }

#     it 'returns true when the item is sold out' do
#       expect(item.sold_out?).to eq true
#     end

#     it 'returns false when the item is not sold out' do
#       item.order = nil
#       expect(item.sold_out?).to eq false
#     end
#   end

#   describe 'Item Listing' do
#     before do
#       user = FactoryBot.create(:user)
#       @item = FactoryBot.build(:item, user: user)
#     end

#     context 'when item can be listed' do
#       it 'has all the required information' do
#         expect(@item).to be_valid
#       end
#     end

#     context 'when item cannot be listed' do
#       it 'does not have attached image' do
#         @item.image = nil
#         @item.valid?
#         expect(@item.errors.full_messages).to include('画像が必須です')
#       end

#       it 'has an empty name' do
#         @item.name = ''
#         @item.valid?
#         expect(@item.errors.full_messages).to include('商品名が必須です')
#       end

#       it 'has an empty description' do
#         @item.description = ''
#         @item.valid?
#         expect(@item.errors.full_messages).to include('商品の説明が必須です')
#       end

#       it 'has an incorrect category_id value' do
#         @item.category_id = 1
#         @item.valid?
#         expect(@item.errors[:category_id]).to include('を選択してください')
#       end

#       it 'has an empty price' do
#         @item.price = ''
#         @item.valid?
#         expect(@item.errors.full_messages).to include('価格が必須です')
#       end

#       it 'has a price less than ¥300' do
#         @item.price = 299
#         @item.valid?
#         expect(@item.errors.full_messages).to include('価格は¥300〜¥9,999,999の間で入力してください')
#       end
#     end
#   end
# end

require 'rails_helper'

RSpec.describe Item, type: :model do
  before(:each) do
    @item = FactoryBot.build(:item) # Create a User instance using the factory before each example
  end

  context 'ユーザ登録が成功する場合' do
    it '正しい属性であれば有効であること' do
      expect(@item).to be_valid
    end
  end
end
