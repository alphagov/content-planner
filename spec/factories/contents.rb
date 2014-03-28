# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :content do
    ref_no
    sequence(:title)        { |n| "Content #{n}" }
    sequence(:url)          { |n| "https://www.gov.uk/content/#{n}" }
    sequence(:content_type) { |n| "Content type #{n}" }
    sequence(:description)  { |n| "Description #{n}" }
    platform                { Content::PLATFORMS.sample }
    status                  { Content::STATUSES[platform].sample }
    size                    { rand(10) + 1 }
    publish_by              { Date.today }

    trait :with_content_plan do
      after(:create) do |content|
        create(:content_plan_content, content: content)
      end
    end

    trait :with_organisation do
      after(:create) do |content|
        content.organisation_ids = [Organisation.all.first.id]
        content.save!
      end
    end

    trait :with_task do
      after(:create) do |content|
        create(:task, taskable: content)
      end
    end

    trait :with_comment do
      after(:create) do |content|
        create(:comment, commentable: content)
      end
    end
  end
end
