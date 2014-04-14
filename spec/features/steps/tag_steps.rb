module TagSteps
  def create_tag!
    visit new_tag_path
    fill_in "Name", with: "tag 899"
    click_on "Create Tag"
  end

  def update_tag!
    fill_in "Name", with: tag_name
    click_on "Edit Tag"
  end

  def delete_tag!(tag)
    within("form[action='#{tag_path(tag)}']") do
      click_on "delete"
    end
  end
end
