FactoryBot.define do
  factory :user do
    email                 { Faker::Internet.free_email }
    password              { Faker::Lorem.characters(number: 6, min_alpha: 1, min_numeric: 1) }
    password_confirmation { password }

    trait :with_profile do
      after :build do |user|
        build(:profile, user: user)
      end
    end
  end
end
