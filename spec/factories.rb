# frozen_string_literal: true

FactoryBot.define do
  factory :heartbeat do
    association :user, factory: :user
    time { Time.zone.now }
    lat { -34.147275 }
    lng { -54.517891 }
    data { nil }
  end

  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
    identity_number { Faker::IDNumber.valid }
    date_of_birth { Faker::Date.between(from: 40.years.ago, to: 2.years.ago) }
    gender { Faker::Number.between(from: 0, to: 1) }
    cellphone { Faker::PhoneNumber.cell_phone }
    other_phone { Faker::PhoneNumber.phone_number }
    lat { -34.147275 }
    lng { -54.517891 }
  end
end
