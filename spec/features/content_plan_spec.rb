require "spec_helper"

feature "Content Plan management" do

  before do
    login
  end

  scenario "creating a Content Plan" do

    visit new_content_plan_path

    fill_in "Title", with: "Some title"
    fill_in "Ref no", with: "X"
    fill_in "Size", with: "1"

    click_button "Create Content plan"

    expect(page).to have_text("Content plan was successfully created.")
    expect(page).to have_text("Some title")
    expect(page).to have_text("X")
    expect(page).to have_text("1")
  end
end