require "spec_helper"

feature "Users can update Specialist contents" do
  before do
    user = build :user
    user.permissions = [User::Permissions::SIGNIN]
    user.save
  end

  describe "Can update content if it belongs to Specialist" do
    before do
      content = create :content, platform: "Specialist"
      visit content_path(content)
      click_on "edit"
    end

    scenario "should update title" do
      new_title = "New content title"
      fill_in "content_title", with: new_title
      click_on "Update Content"
      page.should have_content(new_title)
    end

    # select is not showing if user doesn't have permissions
    # scenario "should not update platform" do
    #   select "Mainstream", from: "content_platform"
    #   click_on "Update Content"
    #   page.should_not have_content("Mainstream")
    # end
  end
  describe "Can't update content if it doesn't belong to Specialist" do
    before do
      @content = create :content, platform: "Mainstream"
    end

    scenario "should not have edit button" do
      visit content_path(@content)
      page.should_not have_content("edit")
    end

    scenario "should not render form" do
      expect {
        visit edit_content_path(@content)
      }.to raise_error(Pundit::NotAuthorizedError)
    end
  end
end
