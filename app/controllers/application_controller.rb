class ApplicationController < ActionController::Base
  include GDS::SSO::ControllerMethods

  prepend_before_filter :authenticate_user!
  before_filter :require_signin_permission!
  before_filter :skip_slimmer

  protect_from_forgery with: :exception

  decent_configuration do
    strategy DecentExposure::StrongParametersStrategy
  end

  def info_for_paper_trail
    { user_name: current_user.name } if current_user
  end
end
