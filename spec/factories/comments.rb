# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    user
    sequence(:message) { |n| "Comment #{n}" }
    commentable        { create :content_plan }
  end
end
