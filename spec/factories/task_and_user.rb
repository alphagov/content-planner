# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :task_and_user do
    task { create :task }
    user { create :user }
  end
end
