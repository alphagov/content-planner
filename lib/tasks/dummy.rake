namespace :db do
  desc "Load more test data for dev env"
  task dummy: :environment do
    DummyData::LoadUsers.run
    DummyData::LoadOrganisations.run
    DummyData::LoadNeeds.run
    DummyData::LoadContentPlans.run
  end
end