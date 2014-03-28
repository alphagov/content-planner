module ContentSteps
  include ::CommonSteps

  def create_content!
    visit new_content_path
    fill_in "Title", with: "Content Title 01"
    fill_in "Ref no", with: "REF-001"
    click_button "Create Content"
  end
end
