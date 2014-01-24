require "spec_helper"

describe Comment do
  it "should not be valid without commentable_id and commentable_type" do
    comment = build :comment, commentable_id: nil, commentable_type: nil
    comment.valid?.should be_false
    error_message = "can't be blank"
    comment.errors.messages[:commentable_id].should include(error_message)
    comment.errors.messages[:commentable_type].should include(error_message)
  end
  it "should be valid" do
    build(:comment).should be_valid
  end
end
