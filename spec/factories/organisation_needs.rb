# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :organisation_need do
    association :organisation, factory: :organisation
    association :need, factory: :need
  end
end
