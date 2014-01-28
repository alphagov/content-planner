class ContentStatus < ActiveHash::Base
  self.data = [
    { id: 'not_started', name: 'Not started' },
    { id: 'in_progress', name: 'In progress' },
    { id: 'completed',   name: 'Completed'   },
    { id: 'published',   name: 'Published'   }
  ]

  NOT_STARTED = find 'not_started'
  IN_PROGRESS = find 'in_progress'
  COMPLETED   = find 'completed'
  PUBLISHED   = find 'published'

  include Comparable
  #
  # ContentStatus.find('not_started') < ContentStatus.find('in_progress') # true
  #
  def <=>(another)
    self.class.all.index(self) <=> self.class.all.index(another)
  end


  def to_s
    name
  end
end
