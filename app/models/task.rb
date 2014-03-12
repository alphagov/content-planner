class Task < ActiveRecord::Base
  belongs_to :taskable, polymorphic: true

  validates :taskable_id, presence: true
  validates :taskable_type, presence: true

end
