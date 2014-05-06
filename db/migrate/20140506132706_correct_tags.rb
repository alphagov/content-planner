class CorrectTags < ActiveRecord::Migration
  def up
    Rake::Task['db:correct_tags'].invoke
  end
end
