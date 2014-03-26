FactoryGirl.define do
  factory :tag, class: ActsAsTaggableOn::Tag do
    sequence(:name) { |n| "Tag #{n}" }
  end
end
