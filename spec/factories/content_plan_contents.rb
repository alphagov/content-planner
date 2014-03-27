# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :content_plan_content do
    content_plan
    content
  end
end
