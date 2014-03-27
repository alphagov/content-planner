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
  end
end
