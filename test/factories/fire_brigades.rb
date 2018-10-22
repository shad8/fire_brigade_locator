FactoryBot.define do
  factory :fire_brigade do
    province { Faker::Lorem.word }
    name { Faker::Lorem.word }
    poviat { Faker::Lorem.word }
    district { Faker::Lorem.word }
    city { Faker::Address.city }
    zipcode { Faker::Address.zip_code }
    street { Faker::Address.street_name }
    fax { Faker::Number.number(10) }
    page { Faker::Internet.domain_name }
    email { Faker::Internet.email }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
  end
end
