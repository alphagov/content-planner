class HomeController < ApplicationController
  skip_before_filter :authenticate_user!, only: :dashboard_data
  skip_before_filter :require_signin_permission!, only: :dashboard_data

  def index
    @contents = ContentPlan.due_date(params[:q], params[:year]).contents.organisation(params[:organisation])
    @tags = @contents.tag_counts_on(:tags).to_a.sort { |a, b| a.name <=> b.name }
  end

  def chart
  end

  def dashboard_data
    categories = []
    series = Content::STATUS.map { |status| { name: status, data: [] } }
    Content.tag_counts_on(:tags).to_a.sort { |a, b| a.name <=> b.name }.each do |tag|
      # split platforms

      tag_scope = Content.tagged_with(tag.name)
      specialist_scope = tag_scope.specialist
      mainstream_scope = tag_scope.mainstream

      # Mainstream published
      if mainstream_scope.any?
        categories << "#{tag.name} (Mainstream)"
        series.each_with_index do |serie, index|
          series[index][:data] << mainstream_scope.where(status: serie[:name]).sum("size")
        end
      end

      # Specialist published
      if specialist_scope.any?
        categories << "#{tag.name} (Specialist)"
        series.each_with_index do |serie, index|
          series[index][:data] << specialist_scope.where(status: serie[:name]).sum("size")
        end
      end
    end

    resp = {
      xAxis: { categories: categories },
      series: series
    }

    respond_to do |format|
      format.html { render text: "#{resp.to_json.inspect}" }
      format.json {
        render json: resp
      }
    end
  end
end
