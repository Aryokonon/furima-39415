FactoryBot.define do
  factory :user do
    nickname { 'example_user' }
    email { 'user@example.com' }
    password { 'password123' }
    password_confirmation { 'password123' } # Add this line
    last_name { '山田' }
    first_name { '太郎' }
    last_name_kana { 'ヤマダ' }
    first_name_kana { 'タロウ' }
    birthdate { Date.new(1990, 1, 1) }
  end
end
