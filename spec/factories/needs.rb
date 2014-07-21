FactoryGirl.define do
  factory :need do
    api_id 100252
    role "user"
    goal "go to the university"
    benefit "I can graduate"
    applies_to_all_organisations false
    in_scope nil
  end
end
