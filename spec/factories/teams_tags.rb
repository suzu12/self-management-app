FactoryBot.define do
  factory :teams_tag do
    category_id  { Faker::Number.between(from: 2, to: 8) }
    team_name    { Faker::Lorem.characters(number: 15) }
    period_id    { Faker::Number.between(from: 2, to: 8) }
    introduction { Faker::Lorem.characters(number: 400) }
    name         { Faker::Lorem.characters(number: 5) }
  end
end
