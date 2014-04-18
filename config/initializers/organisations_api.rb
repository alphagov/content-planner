require 'gds_api/organisations'

if Rails.env.production?
  ContentPlanner.organisations_api = GdsApi::Organisations.new( Plek.current.find('whitehall-admin') )
else
  require "#{Rails.root}/spec/spec_helper"

  ContentPlanner.needs_api = MockNeedsApi.new
  ContentPlanner.organisations_api = MockOrganisationsApi.new
end
