# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    commentable_id 1
    commentable_type 'ContentPlan'
  end
end
