FactoryBot.define do
  factory :item do
    name { Faker::Name.initials(number: 2) }
    description { Faker::Lorem.sentence }
    category_id { 2 }
    status_id { 2 }
    ship_fee_id { 2 }
    ship_region_id { 2 }
    ship_wait_id { 2 }
    price { 500 }

    association :user

    after(:build) do |message|
      message.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end