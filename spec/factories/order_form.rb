FactoryBot.define do
  factory :order_form do
    token { 'tok_abcdefghijk00000000000000000' }
    postal_code { '123-4567' }
    prefecture_id { 2 } # Set the prefecture_id as needed
    city { 'Sample City' }
    street { '123 Sample Street' }
    building_name { 'Sample Building' }
    phone_number { '09012345678' }

    # Create a user and an item associated with this order_form
    association :user, factory: :user
    association :item, factory: :item, user: user

    # You can also use the following syntax if you want to create an associated user and item
    # without explicitly specifying factories:
    # user
    # item { association :user, factory: :user }
  end
end
