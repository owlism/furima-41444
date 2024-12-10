FactoryBot.define do
  factory :user do
    nickname { 'rolly' }
    email { Faker::Internet.email }
    password{Faker::Lorem.characters(number: 7, min_numeric: 1, min_alpha: 1)} 
    password_confirmation { password }
    family_name { '土井' }
    first_name { '八郎' }
    family_kana { 'ドイ' }
    first_kana { 'ハチロウ' }
    birth_date { '1990/06/06' }
  end
end
