# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :content_plan do
    type ""
    size 1
    status "MyString"
    ref_no "MyString"
    title "MyString"
    details "MyText"
    slug "MyString"
    content_type "MyText"
    sources "MyText"
    handover_detailed_guidance "MyText"
    notes "MyText"
  end
end
