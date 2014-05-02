namespace :tasks do
  desc "Overdue tasks notifications"
  task overdue_notifications: :environment do
    OverdueTaskNotifier.run
  end
end