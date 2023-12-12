FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "User #{n}" }
    sequence(:bio) { |n| "user_bio#{n}" }
    photo { 'default_image.jpg' }
    posts_counter { 0 }
  end
end
