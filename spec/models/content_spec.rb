require "spec_helper"

describe Content do
  it "should not be valid without a title" do
    content = FactoryGirl.build :content, title: nil
    content.valid?.should be_false
    content.errors.messages[:title].should include("can't be blank")
  end
  it "should be valid with a title" do
    FactoryGirl.build(:content).should be_valid
  end
end