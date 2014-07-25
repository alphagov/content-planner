FactoryGirl.define do
  factory :need do
    sequence(:api_id) { |n| "123#{n}" }
    role "user"
    goal "go to the university"
    benefit "I can graduate"
    applies_to_all_organisations false
    in_scope nil
  end
end
