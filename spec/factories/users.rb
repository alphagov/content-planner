# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :email do |n|
    "person#{n}@example.com"
  end

  factory :user do
    sequence(:name) { |n| "User #{n}" }
    email

    trait :gds_editor do
      permissions { [User::Permissions::SIGNIN, User::Permissions::GDS_EDITOR] }
    end
  end
end
