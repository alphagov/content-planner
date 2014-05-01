module DashboardSteps
  def expect_to_see_status_bars
    Content::PLATFORMS.map do |platform|
      platform_contents = contents.platform(platform)
      Content.percentages_for(platform: platform, contents:  platform_contents).each do |status, results|
        expect(page.html).to include(status)

        percentage = "#{results[1]}%"
        expect(page.html).to include(percentage)

        items = pluralize(results[0], "item")
        expect(page.html).to include(items)
      end
    end
  end

  def fill_in_filter
    select "Quarter #{content_plan.due_quarter}", from: "q"
    select content_plan.due_year, from: "year"
    select organisation.to_s, from: "organisation"
    click_on "Filter"
  end
end
