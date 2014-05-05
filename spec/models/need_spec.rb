require "spec_helper"

describe Need do
  describe "validations" do
    it { should validate_presence_of :api_id }
  end
end
