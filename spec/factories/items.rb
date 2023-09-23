# COMMENTED OUTED

FactoryBot.define do
  factory :item do
    user # This sets up the association with a user automatically, assuming you have a user factory defined.
    name { 'Example Item' }
    description { 'This is a test item.' }
    category_id { 1 } # Replace with the appropriate category ID
    condition_id { 1 } # Replace with the appropriate condition ID
    delivery_fee_id { 1 } # Replace with the appropriate delivery fee ID
    #    prefecture_id { 1 } # Replace with the appropriate prefecture ID
    #    shipping_day_id { 1 } # Replace with the appropriate shipping day ID
    #    price { 1000 }
  end
end
