namespace :db do
  desc "Correct tags"
  task correct_tags: :environment do
    CorrectWrongTags.run
  end
end