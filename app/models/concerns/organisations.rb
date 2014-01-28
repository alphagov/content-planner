module Organisations
  extend ActiveSupport::Concern

  included do
    has_many :organisationables, as: :organisationable
  end

  def organisation_ids
    organisationables.any? ? organisationables.map(&:organisation_id) : []
  end

  def organisations
    organisation_ids.map { |organisation_id| Organisation.find organisation_id }
  end

  def joined_organisation_ids
    organisation_ids.join ", "
  end
  def joined_organisation_ids=(ids)
    organisationables.destroy_all
    ids.split(",").each do |oid|
      Organisationable.find_or_create_by!(organisationable: self, organisation_id: oid)
    end
  end
end
