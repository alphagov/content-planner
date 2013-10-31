class SourceUrl < ActiveRecord::Base

  validates :from_url, presence: true, uniqueness: true
  validates :state, presence: true

end
