require "spec_helper"

describe CommentMailer do
  before do
    @users = [ create(:user),
               create(:user),
               create(:user)]
  end
  it "should deliver a notification to all users that belong to a content except the user that commented" do
    content = create :content
    @users.each do |user|
      content.content_users << ContentUser.create(user: user, content: content)
    end
    Comment.create(commentable: content, user: @users.first)
    deliveries = ActionMailer::Base.deliveries
    deliveries.length.should eq(2)
    deliveries.map(&:to).flatten.should eq(@users.slice(1,2).map(&:email))
  end
  it "should deliver a notification to all users that belong to contents inside a content plan (except the user that commented)" do
    content_plan = create :content_plan
    @users.each do |user|
      content = create :content
      ContentUser.create(user: user, content: content)
      ContentPlanContent.create(content: content, content_plan: content_plan)
    end
    Comment.create(commentable: content_plan, user: @users.first)
    deliveries = ActionMailer::Base.deliveries
    deliveries.length.should eq(2)
    deliveries.map(&:to).flatten.should eq(@users.slice(1,2).map(&:email))
  end
end
