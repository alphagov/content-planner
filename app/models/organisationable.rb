class Organisationable < ActiveRecord::Base
  belongs_to :organisationable, polymorphic: true

  def organisation
    Organisation.find(organisation_id)
  end
end
