class HomeController < ApplicationController
  skip_before_filter :authenticate_user!, only: :dashboard_data
  skip_before_filter :require_signin_permission!, only: :dashboard_data

  def index
    @content_plans = ContentPlan.due_date(params[:q], params[:year]).includes(:content_plan_contents, :contents)
  end
end
