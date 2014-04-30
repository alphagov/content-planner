class TaskAndUser < ActiveRecord::Base
  belongs_to :task
  belongs_to :user

  validates :task,
            :user,
            presence: true,
            on: :update
end
