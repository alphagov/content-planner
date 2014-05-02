# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :task do
    sequence(:title) { |n| "Task #{n}" }
    taskable         { create(:content_plan) }

    trait :completed do
      done true
    end
  end
end
