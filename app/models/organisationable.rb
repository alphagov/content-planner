class Organisationable < ActiveRecord::Base
  belongs_to :organisationable, polymorphic: true

  scope :for_content, -> { where(organisationable_type: 'Content') }

  def organisation
    Organisation.find(organisation_id)
  end
end
