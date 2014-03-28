# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence(:ref_no) { |n| "REF-#{"%03d" % n}" }

  factory :content_plan do
    ref_no
    sequence(:title)  { |n| "Content plan #{n}" }
    details           { "#{title} details" }
    notes             { "#{title} notes" }
    due_quarter       { ContentPlan::QUARTERS.to_a.sample }
    due_year          { ContentPlan::YEARS.to_a.sample }

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
        ContentPlanUser.create!(content_plan: content_plan, user: create(:user))
      end
    end

    trait :with_content do
      after(:create) do |content_plan|
        create(:content_plan_content, content_plan: content_plan)
      end
    end

    trait :with_task do
      after(:create) do |content_plan|
        create(:task, taskable: content_plan)
      end
    end

    trait :with_comment do
      after(:create) do |content_plan|
        create(:comment, commentable: content_plan)
      end
    end
  end
end
