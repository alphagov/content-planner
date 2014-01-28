class OrganisationsController < ApplicationController

  skip_before_filter :authenticate_user!, only: :index
  skip_filter :require_signin_permission!, only: :index

  def index
    @organisations = Organisation.all
    render json: @organisations.map { |o| { id: o.id, text: o.name_with_abbreviation } }
  end
end
