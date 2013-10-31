# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :source_url do
    url "MyText"
    state "MyString"
    transitioned false
  end
end
