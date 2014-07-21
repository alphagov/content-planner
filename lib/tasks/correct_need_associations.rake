namespace :db do
  desc "Correct Need associations: ContentNeed and ContentPlanNeed"
  task correct_need_associations: :environment do
    CorrectNeedAssociations.run
  end
end
