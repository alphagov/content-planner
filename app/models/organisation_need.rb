class OrganisationNeed < ActiveRecord::Base
  belongs_to :organisation
  belongs_to :need

  validates :organisation,
            :need,
            presence: true,
            on: :update
end
