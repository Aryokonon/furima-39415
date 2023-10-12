FactoryBot.define do
  factory :order_form do
    token { 'tok_abcdefghijk00000000000000000' }
    postal_code { '123-4567' }
    prefecture_id { 2 } # Set the prefecture_id as needed
    city { 'Sample City' }
    street { '123 Sample Street' }
    building_name { 'Sample Building' }
    phone_number { '09012345678' }
  end
end
