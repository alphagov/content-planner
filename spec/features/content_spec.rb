require "spec_helper"

describe "Content" do
  include ContentSteps

  let!(:user) { create :user, :gds_editor }

  context "create" do
    before { create_content! }

    it {
      expect(page).to have_text("Content was successfully created.")
      expect(page).to have_text("Content Title 01")
    }
  end

  context "edit" do
    let(:content)       { Content.last }
    let!(:content_plan) { create :content_plan }
    let(:attributes) {
      attributes_for(:content).tap do |attributes|
        attributes[:needs] = need.id.to_s
        attributes[:tag_list] = "tag 999"
        attributes[:users] = user.to_s
        attributes[:organisations] = organisation.title
        attributes[:publish_by] = I18n.l(attributes[:publish_by])
        attributes[:content_plan] = content_plan.to_s
      end
    }

    before {
      create_content!
      visit edit_content_path(content)
    }

    it "should update content" do
      fill_in "Ref no", with: attributes[:ref_no]
      fill_in "Title", with: attributes[:title]
      fill_in "Description", with: attributes[:description]
      fill_in "Url", with: attributes[:url]
      fill_in "Size", with: attributes[:size]
      fill_in "Content type", with: attributes[:content_type]
      fill_in "Tag list", with: attributes[:tag_list]

      select attributes[:platform], from: "Platform"
      select attributes[:status], from: "Status"
      select attributes[:users], from: "Users"
      select attributes[:organisations], from: "Organisations"
      select attributes[:content_plan], from: "Content plans"

      # select publish by
      day, month, year = attributes[:publish_by].split("/")
      select year, from: "content_publish_by_1i"
      select Date::MONTHNAMES[month.to_i], from: "content_publish_by_2i"
      select day.to_i, from: "content_publish_by_3i"

      # select need
      need = find("option", text: Regexp.new(attributes[:needs])).text
      select need, from: "Maslow need ids"

      click_on "Update Content"

      expect_to_see_new_attributes
    end
  end

  context "show" do
    let(:content)      { create :content, :with_content_plan, :with_organisation, :with_task, :with_comment }
    let(:content_plan) { content.content_plans.first }
    let(:organisation) { Organisation.all.first }
    let(:task)         { content.tasks.reload.first }
    let(:comment)      { content.comments.reload.first }

    before { visit content_path(content) }

    it { expect(page).to have_text(content.ref_no) }
    it { expect(page).to have_text(content.title) }
    it { expect(page).to have_text(content_plan.to_s) }
    it { expect(page).to have_text(organisation.title) }
    it { expect(page).to have_text(task.title) }
    it { expect(page).to have_text(comment.message) }
  end
end
