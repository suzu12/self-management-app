FactoryBot.define do
  factory :profile do
    bio { Faker::Lorem.characters(number: 100) }
    birthday { Faker::Date.birthday(min_age: 18, max_age: 65) }
    gender { Profile.genders.keys.sample }
  end
end
