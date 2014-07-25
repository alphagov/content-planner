require "spec_helper"

describe Content do
  describe "validations" do
    context "title" do
      let(:content) { FactoryGirl.build(:content, title: nil) }

      before { content.valid? }

      it { should_not be_valid }
    end
  end

  describe "#percentages_for" do
    before { 50.times { create(:content) } }

    let(:scope) { Content.limit(40).platform(platform) }
    let(:percentages) { Content.percentages_for(platform: platform, contents: scope) }
    let(:spec_percentages) {
      hash = Content::STATUSES[platform].inject({}) { |h, s|
        h.tap { |h| h[s] = { count: 0 } }
      }
      scoped = scope.where(platform: platform)
      scoped.each do |content|
        hash[content.status][:count] += 1
      end
      hash.each do |k, v|
        count = hash[k][:count]
        percentage = ((count * 100.0) / scoped.count).round(3)
        hash[k] = [count, percentage]
      end
    }

    Content::PLATFORMS.each do |platform|
      context platform do
        let!(:platform) { platform }

        it { expect(percentages).to eq(spec_percentages) }
      end
    end
  end
end
