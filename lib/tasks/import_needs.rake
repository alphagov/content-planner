namespace :needs do
  desc "Import needs from Needs Api"
  task import: :environment do
    ImportNeeds.run
  end
end