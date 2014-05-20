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

      if success? && completed? && done_changed?
        notify_task_creator_and_task_owners!
      end

      self
    end

    def persist!
      assign_attributes!
      @done_changed = task.done_changed?
      @success = task.save
      @completed = !@completed && task.done
    end

    def success?
      @success
    end

    def completed?
      @completed
    end

    def done_changed?
      @done_changed
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

    def assign_attributes!
      task.assign_attributes(update_params)
      update_status! if update_params["done"].present? # changing task status
    end

    def update_status!
      case update_params["done"].to_i
      when 0 # marking as undone
        task.assign_attributes(completed_by: nil, done_at: nil)
      when 1 # marking as done
        task.assign_attributes(completed_by: current_user, done_at: Time.now)
      end
    end
  end
end
