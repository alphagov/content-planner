module ContentPlanSteps
  def create_content_plan!
    visit new_content_plan_path
    fill_in "Title", with: "Some title"
    fill_in "Ref no", with: "X"
    click_button "Create Content plan"
  end

  def expect_to_see_new_attributes
    attributes.each do |key, value|
      expect(page).to have_text(value)
    end
  end
end
