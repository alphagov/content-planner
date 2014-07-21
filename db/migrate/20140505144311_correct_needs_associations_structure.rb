class CorrectNeedsAssociationsStructure < ActiveRecord::Migration
  def up
    if API_CLIENT_CREDENTIALS.present?
      ImportOrganisations.new.call
      ImportNeeds.run
    else
      puts "[WARNING] your env has no valid API_CLIENT_CREDENTIALS!"
      puts "[WARNING] so, Organisations and Needs can't be imported via API!"
      puts "[WARNING] if you are in development env"
      puts "[WARNING] you can populate test Organisation and Needs using:"
      puts "[WARNING] rake db:populate_organisation_and_need_for_dev_env"
      puts "[WARNING] rake db:correct_need_associations - to correct need related associations: ContentNeed and ContentPlanNeed"

      # uncomment line below if would like to populate test Organisation and Needs
      # PopulateOrganisationAndNeedForDevEnv.run
    end

    rename_column :content_plan_needs, :need_id, :need_api_id
    rename_column :content_needs, :need_id, :need_api_id

    add_column :content_plan_needs, :need_id, :integer
    add_column :content_needs, :need_id, :integer

    ContentPlanNeed.all.each do |content_plan_need|
      need = Need.find_by(api_id: content_plan_need.need_api_id)

      if need.present?
        content_plan_need.update_column(:need_id, need.id)
      end
    end

    ContentNeed.all.each do |content_need|
      need = Need.find_by(api_id: content_need.need_api_id)

      if need.present?
        content_need.update_column(:need_id, need.id)
      end
    end
  end

  def down
    remove_column :content_plan_needs, :need_id
    remove_column :content_needs, :need_id

    rename_column :content_plan_needs, :need_api_id, :need_id
    rename_column :content_needs, :need_api_id, :need_id
  end
end
