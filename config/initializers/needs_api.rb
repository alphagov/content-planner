require 'gds_api/need_api'

ContentPlanner.needs_api = GdsApi::NeedApi.new( Plek.current.find('need-api') )

