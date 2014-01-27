class StatusTransition < ActiveRecord::Base
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :content

  belongs_to :from, class_name: 'ContentStatus'
  belongs_to :to,   class_name: 'ContentStatus'

  scope :whitehall,  -> { where content_id: Content.whitehall  }
  scope :mainstream, -> { where content_id: Content.mainstream }

  scope :order_by_occurred_at_desc, -> { order occurred_at: :desc }
end
