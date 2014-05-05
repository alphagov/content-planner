# default cron env is "/usr/bin:/bin" which is not sufficient as govuk_env is in /usr/local/bin
env :PATH, '/usr/local/bin:/usr/bin:/bin'

# We need Rake to use our own environment (need to correct)
job_type :rake, "cd :path && govuk_setenv content_planner bundle exec rake :task --silent :output"

every :day, at: '6am' do
  rake "organisations:import"
end

every :day, at: '7am' do
  rake "needs:import"
end

every :day, at: '8am' do
  rake "tasks:overdue_notifications"
end
