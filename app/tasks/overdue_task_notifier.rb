class OverdueTaskNotifier
  class << self
    def run
      Task.overdue_for_today.each do |task|
        notified_people(task).each do |notified_person|
          TaskMailer.overdue_notification(task, notified_person).deliver!
        end
      end
    end

    private

    def notified_people(task)
      ([task.creator] + task.users).uniq.compact
    end
  end
end
