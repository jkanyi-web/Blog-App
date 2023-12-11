FactoryBot.define do
    factory :user do
        sequence(:name) { |n| "User #{n}" }
        sequence(:bio) { |n| "user_bio#{n}" }
        photo { 'default_image.jpg' }
        posts_counter { 0 }
    end
    factory :post do
        sequence(:title) { |n| "Post Title #{n}" }
        content { "Lorem ipsum dolor sit amet, consectetur adipiscing elit." }
        association :author
        comments_counter { 0 }
        likess_counter { 0 }
    end
end
  