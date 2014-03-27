require "spec_helper"

describe Content do
  context "validations" do
    describe "title" do
      let(:content) { FactoryGirl.build(:content, title: nil) }

      before { content.valid? }

      it { should_not be_valid }
      it { content.errors.messages[:title].should include("can't be blank") }
    end
  end
end
