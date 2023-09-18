require 'faker'

FactoryBot.define do
  factory :user do
    nickname { Faker::Internet.unique.username(specifier: 6) } # Generate a random 6-character nickname
    email { Faker::Internet.unique.email }
    password { 'password123' }
    last_name { '山田' }
    first_name { '太郎' }
    last_name_kana { 'ヤマダ' }
    first_name_kana { 'タロウ' }
    birth_date { Date.new(1990, 1, 1) }
  end
end
