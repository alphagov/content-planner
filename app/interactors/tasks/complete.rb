module Tasks
  class Complete
    attr_reader :task, :current_user, :completed, :update_params, :success

    def initialize(task, current_user, update_params)
      @task = task
      @completed = task.done
      @current_user = current_user
      @update_params = update_params
    end

    def run
      persist!

      if success? && completed?
        notify_task_creator_and_task_owners!
      end

      self
    end

    def persist!
      @success = task.update(update_params)
      @completed = !@completed && task.done
    end

    def success?
      @success
    end

    def completed?
      @completed
    end

    private

    def notified_people
      ([task.creator] + task.users).reject { |u| u == current_user }
                                   .uniq
                                   .compact
    end

    def notify_task_creator_and_task_owners!
      notified_people.each do |gds_editor|
        TaskMailer.notify(task, gds_editor).deliver!
      end
    end
  end
end
