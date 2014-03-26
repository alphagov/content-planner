# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :content_plan do
    sequence(:ref_no) { |n| "REF-#{"%03d" % n}" }
    sequence(:title)  { |n| "Content plan #{n}" }

    details     { "#{title} details" }
    notes       { "#{title} notes" }
    due_quarter { ContentPlan::QUARTERS.to_a.sample }
    due_year    { ContentPlan::YEARS.to_a.sample }

    trait :with_organisation do
      after(:create) do |content_plan|
        content_plan.organisation_ids = [Organisation.all.first.id]
        content_plan.save!
      end
    end

    trait :with_need do
      after(:create) do |content_plan|
        ContentPlanNeed.create(content_plan: content_plan, need_id: Need.all.first.id)
      end
    end

    trait :with_tag do
      after(:create) do |content_plan|
        content_plan.tag_list.add create(:tag).name
        content_plan.save!
      end
    end

    trait :with_user do
      after(:create) do |content_plan|
        content_plan.content_plan_users
        ContentPlanUser.create!(content_plan: content_plan, user: create(:user))
      end
    end
  end
end
