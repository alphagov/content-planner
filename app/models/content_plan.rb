class ContentPlan < ActiveRecord::Base
  self.inheritance_column = :_type_disabled
  acts_as_taggable

  TYPES = ["Mainstream", 'Specialist']
  STATUS = ["Not started", "In Progress", "Done"]

  validates :title, presence: true
  validates :size, presence: true
end
