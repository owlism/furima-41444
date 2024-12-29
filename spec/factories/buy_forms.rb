FactoryBot.define do
  factory :buy_form do
    post_number { "#{Faker::Number.number(digits: 3)}-#{Faker::Number.number(digits: 4)}" }
    ship_region_id { Faker::Number.between(from: 1, to: 47) }
    city { Faker::Address.city }
    house_number { Faker::Address.street_address }
    phone_number { Faker::Number.number(digits: 10) }
    building_name { Faker::Address.secondary_address }
    token {"tok_abcdefghijk00000000000000000"}
  end
end