class NeedsController < ApplicationController

  skip_before_filter :authenticate_user!, only: :index
  skip_filter :require_signin_permission!, only: :index

  def index
    @needs = Need.all

    respond_to do |format|
      format.html { render text: @needs.inspect }
      format.json {
        render json: @needs.map { |n| { id: n.id, text: n.to_s } }
      }
    end
  end
end