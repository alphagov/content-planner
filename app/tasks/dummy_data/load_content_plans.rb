class DummyData::LoadContentPlans
  class << self
    def run
      load_tags
      load_content_plans
    end

    def load_tags
      puts "[DummyData] load tags ---------------------------------------------------------- started"

      10.times do |i|
        ActsAsTaggableOn::Tag.find_or_create_by!(name: "Tag #{i + 1}")
      end

      puts "[DummyData] load tags ---------------------------------------------------------- completed"
    end

    def load_content_plans
      puts "[DummyData] load content_plans ---------------------------------------------------------- started"

      10.times do |i|
        build_content_plan(i)
      end

      puts "[DummyData] load content_plans ---------------------------------------------------------- completed"
    end

    def build_content_plan(i)
      content_plan = ContentPlan.create!(
        ref_no: "ref_no_#{i + 1}",
        title: "Content Plan #{i + 1}",
        organisation_ids: Organisation.limit(5).order("RAND()").map(&:id),
        needs: Need.limit(35).order("RAND()"),
        users: User.limit(5).order("RAND()"),
        tag_list: ActsAsTaggableOn::Tag.limit(5).order("RAND()")
      )

      if content_plan.present?
        2.times do |i|
          content_plan.tasks.create!(
            creator: User.limit(1).order("RAND()").first,
            title: "Task #{content_plan.id} - #{i + 1}"
          )

          content_plan.comments.create!(
            user: User.limit(1).order("RAND()").first,
            message: "Comment #{content_plan.id} - #{i + 1}"
          )
        end

        10.times do |i|
          content = content_plan.contents.create!(
            ref_no: "ref_content_no_#{i + 1}",
            title: "Content #{content_plan.id}-#{i + 1}",
            status: Content::STATUSES.values.flatten.uniq.sample,
            platform: Content::STATUSES.keys.sample,
            organisation_ids: Organisation.limit(5).order("RAND()").map(&:id),
            needs: Need.limit(35).order("RAND()"),
            users: User.limit(5).order("RAND()"),
            tag_list: ActsAsTaggableOn::Tag.limit(5).order("RAND()")
          )

          2.times do |i|
            content.tasks.create!(
              creator: User.limit(1).order("RAND()").first,
              title: "Task #{content.id} - #{i + 1}"
            )

            content.comments.create!(
              user: User.limit(1).order("RAND()").first,
              message: "Comment #{content.id} - #{i + 1}"
            )
          end
        end
      end
    end
  end
end
