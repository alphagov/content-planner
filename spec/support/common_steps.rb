module CommonSteps
  def expect_to_see_new_attributes
    attributes.each do |key, value|
      expect(page).to have_text(value)
    end
  end
end
