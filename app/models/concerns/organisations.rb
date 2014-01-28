module Organisations
  extend ActiveSupport::Concern

  included do
    has_many :organisationables, as: :organisationable
    attr_accessor :joined_organisation_ids
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
end