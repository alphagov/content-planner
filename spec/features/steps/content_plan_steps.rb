module ContentPlanSteps
  include CommonSteps

  def create_content_plan!
    visit new_content_plan_path
    fill_in "Title", with: "Some title"
    fill_in "Ref no", with: "X"
    click_button "Create Content plan"
  end

  def fill_in_filter_form_for(content_plan)
    fill_in "search_ref_no", with: content_plan.ref_no
    fill_in "search_tag", with: content_plan.tags.first.to_s
    select content_plan.organisations.first.to_s, from: "search_organisation_ids"
    select content_plan.content_plan_needs.first.need.to_s, from: "search_need_id"
    select content_plan.users.first.to_s, from: "search_user_id"
    due_date = "q#{content_plan.due_quarter} #{content_plan.due_year}"
    select due_date, from: "search_due_date"
    click_on "Search"
  end
end
