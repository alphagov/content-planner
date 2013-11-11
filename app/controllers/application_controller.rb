class ApplicationController < ActionController::Base
  before_filter :authenticate_user!

  protect_from_forgery with: :exception

  decent_configuration do
    strategy DecentExposure::StrongParametersStrategy
  end

end
