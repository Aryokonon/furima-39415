FactoryBot.define do
  factory :item do
    user { association :user } # This sets up the association with a user automatically
    name { 'Example Item' }
    description { 'This is a test item.' }
    category_id { 2 } # Replace with the appropriate category ID
    condition_id { 2 } # Replace with the appropriate condition ID
    delivery_fee_id { 2 } # Replace with the appropriate delivery fee ID
    prefecture_id { 2 } # Uncomment and replace with the appropriate prefecture ID
    shipping_day_id { 2 } # Uncomment and replace with the appropriate shipping day ID
    price { 1000 } # You can set the price here
  end
end
