require "spec_helper"

describe CommentMailer do
  describe "deliveries" do
    before do
      @users = [create(:user),
                create(:user),
                create(:user)]
    end

    it "should deliver a notification to all users that belong to a content except the user that commented" do
      content = create :content
      @users.each do |user|
        content.content_users << ContentUser.create(user: user, content: content)
      end
      content.reload
      Comment.create(commentable: content, user: @users.first)
      deliveries = ActionMailer::Base.deliveries
      deliveries.length.should eq(2)
      deliveries.map(&:to).flatten.should eq(@users.slice(1, 2).map(&:email))
    end
    
    it "should deliver a notification to all users that belong to contents inside a content plan (except the user that commented)" do
      content_plan = create :content_plan
      @users.each do |user|
        content = create :content
        ContentUser.create(user: user, content: content)
        ContentPlanContent.create(content: content, content_plan: content_plan)
      end
      content_plan.reload
      Comment.create(commentable: content_plan, user: @users.first)
      deliveries = ActionMailer::Base.deliveries
      deliveries.length.should eq(2)
      deliveries.map(&:to).flatten.should eq(@users.slice(1, 2).map(&:email))
    end
  end
  
  describe "email content" do
    let(:user)      { create :user }
    let(:commenter) { create :user }
    let(:content)   { create :content }
    let(:comment)   { Comment.create(commentable: content, user: commenter) }
    let(:mail)      { CommentMailer.notify_user(comment, user) }

    it "should include commenter's name on subject" do
      mail.subject.should include(commenter.name)
    end

    it "should include content's title on subject" do
      mail.subject.should include(content.title)
    end

    it "should include content's url in body" do
      mail.body.encoded.should include(content_url(content))
    end
  end
end
