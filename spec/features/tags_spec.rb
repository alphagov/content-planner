require "spec_helper"

describe "Tags" do
  include TagSteps

  before { create :user, :gds_editor }

  context "list" do
    let!(:tags) { 2.times.map { create :tag } }

    before { visit tags_path }

    it { expect(page).to have_text(tags.first.name) }
    it { expect(page).to have_text(tags.last.name) }
  end

  context "create" do
    before { create_tag! }

    let(:tag) { ActsAsTaggableOn::Tag.first }

    it { expect(page).to have_text(tag.name) }
  end

  context "edit" do
    let(:tag) { create :tag }
    let(:tag_name) { "tag 345" }

    before {
      visit edit_tag_path(tag)
      update_tag!
    }

    it { expect(page).to have_text(tag_name) }
  end

  context "delete" do
    let!(:tag) { create :tag }
    let!(:tag2) { create :tag }

    before {
      visit tags_path
      delete_tag!(tag2)
    }

    it { expect(page).to have_text(tag.name) }
    it { expect(page).to_not have_text(tag2.name) }
  end
end
