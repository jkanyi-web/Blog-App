FactoryBot.define do
  factory :post do
    sequence(:title) { |n| "Post Title #{n}" }
    text { 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.' }
    association :author
    comments_counter { 0 }
    likes_counter { 0 }
  end
end
