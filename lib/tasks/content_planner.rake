namespace :content_plans do
  desc "Import content plans from XLSX file"
  task import: :environment do
    raise ArgumentError.new("Please provide content plans path using environment variable DATA_FILE") if ENV['DATA_FILE'].blank?

    ImportContentPlans.new(ENV['DATA_FILE']).import
  end
end