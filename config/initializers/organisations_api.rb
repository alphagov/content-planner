require 'gds_api/organisations'

ContentPlanner.organisations_api = GdsApi::Organisations.new( Plek.current.find('whitehall-admin') )
