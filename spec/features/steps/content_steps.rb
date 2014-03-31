module ContentSteps
  include CommonSteps

  def create_content!
    visit new_content_path
    fill_in "Title", with: "Content Title 01"
    fill_in "Ref no", with: "REF-001"
    click_button "Create Content"
  end

  def fill_in_filter_form_for(content)
    fill_in "search_tag", with: content.tags.first.to_s
    select content.organisations.first.to_s, from: "search_organisation_ids"
    select content.content_plans.first.to_s, from: "search_content_plan_ids"
    select content.content_needs.first.need.to_s, from: "search_need_id"
    select content.users.first.to_s, from: "search_user_id"
    select content.status, from: "search_status"
    click_on "Search"
  end
end
