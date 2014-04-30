require 'spec_helper'

describe TaskAndUser do
  let(:task_and_user) { create :task_and_user }

  describe "validations" do
    before {
      task_and_user.task = nil
      task_and_user.user = nil
    }

    it "should not be valid with empty user or task" do
      expect(task_and_user).to have(1).error_on(:user)
      expect(task_and_user).to have(1).error_on(:task)
    end
  end
end
