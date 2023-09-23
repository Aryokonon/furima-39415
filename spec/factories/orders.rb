# COMENTED OUTED

FactoryBot.define do
  factory :order do
    price { 3000 }
    token { 'tok_abcdefghijk00000000000000000' }

    #    user { create(:user) }
    #    item { create(:item, user: user) }
    #    price { 100 }  # You can adjust this to a valid price
    #    token { 'your_token_here' }
  end
end
