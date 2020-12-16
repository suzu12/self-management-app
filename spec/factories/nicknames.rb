FactoryBot.define do
  factory :nickname do
    nickname { Faker::Name.first_name }
  end
end
