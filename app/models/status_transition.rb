class StatusTransition < ActiveRecord::Base
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :content

  belongs_to :from, class_name: 'ContentStatus'
  belongs_to :to,   class_name: 'ContentStatus'
end
