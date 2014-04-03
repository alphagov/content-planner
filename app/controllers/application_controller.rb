class ApplicationController < ActionController::Base
  include GDS::SSO::ControllerMethods
  include Pundit

  prepend_before_filter :authenticate_user!
  before_filter :require_signin_permission!

  protect_from_forgery with: :exception

  decent_configuration do
    strategy DecentExposure::StrongParametersStrategy
  end

  def info_for_paper_trail
    { user_name: current_user.name } if current_user
  end

  rescue_from Pundit::NotAuthorizedError do |e|
    # Layout and view comes from GDS::SSO::ControllerMethods
    render "authorisations/unauthorised", 
            layout: "unauthorised", 
            status: :forbidden, 
            locals: { message: "You are not authorized to perform this action." }
  end unless Rails.env.test?
end
