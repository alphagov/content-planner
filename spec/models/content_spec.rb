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

  it '#track_status_transitions' do
    content = FactoryGirl.build :content, status_id: ContentStatus::NOT_STARTED.id

    content.save!

    expect(content.status_transitions).to be_blank

    content.status_id = ContentStatus::PUBLISHED.id

    content.save!

    expect(content.reload.status_transitions).to have(1).item
  end
end
