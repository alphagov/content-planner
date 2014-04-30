class Task < ActiveRecord::Base
  belongs_to :taskable, polymorphic: true

  validates :title, presence: true, length: { maximum: 255 }

  validates :taskable_id, presence: true
  validates :taskable_type, presence: true

  has_many :task_and_users, dependent: :destroy
  has_many :users, through: :task_and_users
end
