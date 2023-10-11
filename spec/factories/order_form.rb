FactoryBot.define do
  factory :order_form do
    token { 'tok_abcdefghijk00000000000000000' }
    user_id { FactoryBot.create(:user).id }
    item_id { FactoryBot.create(:item, user_id: user_id).id } # Use the user_id from order_form
    postal_code { '123-4567' }
    prefecture_id { 2 } # Set the prefecture_id as needed
    city { 'Sample City' }
    street { '123 Sample Street' }
    building_name { 'Sample Building' }
    phone_number { '09012345678' }
    # association :user
    # association :item
  end
end
