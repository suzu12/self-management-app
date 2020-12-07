FactoryBot.define do
  factory :chat do
    content { Faker::Lorem.sentence }

    after(:build) do |chat|
      chat.photo.attach(io: File.open('spec/fixtures/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
