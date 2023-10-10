FactoryBot.define do
  factory :order do
    price { 3000 }
    token { 'tok_abcdefghijk00000000000000000' }
    user { create(:user) }
    association :item, factory: :item_with_associations
  end
end
