class Task < ActiveRecord::Base
  belongs_to :creator, class_name: "User"
  belongs_to :completed_by, class_name: "User"
  belongs_to :taskable, polymorphic: true

  validates :title, presence: true, length: { maximum: 255 }

  validates :taskable_id, presence: true
  validates :taskable_type, presence: true

  has_many :task_and_users, dependent: :destroy
  has_many :users, through: :task_and_users

  scope :by_deadline, -> {
    order("-deadline ASC")
  }

  scope :completed, -> {
    where(done: true)
  }
  scope :not_completed, -> {
    where.any_of({ done: nil }, { done: false })
  }
  scope :deadline_passed_yesterday, -> {
    where(deadline: (Time.now.midnight - 1.day)..Time.now.midnight)
  }

  scope :overdue_for_today, -> {
    not_completed.deadline_passed_yesterday
  }

  scope :current, -> {
    where.any_of(not_completed, ["done_at > ?", Time.now.yesterday])
  }
  scope :old, -> {
    completed.where("done_at <= ?", Time.now.yesterday)
  }
end
