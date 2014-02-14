# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :content_plan do
    ref_no 'MyString'
    title 'MyString'
    details 'MyText'
    notes 'MyText'
  end
end
