# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :content do
    title "Content Title"
    url "MyText"
    content_type "MyString"
    status_id ContentStatus::NOT_STARTED.id
  end
end
