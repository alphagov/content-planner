class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  belongs_to :parent, class_name: "Comment"

  has_many :children, class_name: "Comment",
                      foreign_key: :parent_id

  validates :commentable_id, presence: true
  validates :commentable_type, presence: true

  after_create :notify_users, if: "root?"

  scope :roots, -> { where parent_id: nil }

  def notify_users
    CommentNotifier.new(self)
  end

  def root?
    !child?
  end

  def child?
    parent.present?
  end

  def reply_recipients
    children.map(&:user).uniq
  end
end
