class HomeController < ApplicationController
  skip_before_filter :authenticate_user!, only: :dashboard_data
  skip_before_filter :require_signin_permission!, only: :dashboard_data

  def index
    @tags = Content.tag_counts_on(:tags).to_a.sort{|a,b| a.name <=> b.name}
  end

  def chart
  end

  def dashboard_data
    categories = []
    series = Content::STATUS.map {|status| {name: status, data: []} }
    Content.tag_counts_on(:tags).to_a.sort{|a,b| a.name <=> b.name}.each do |tag|
      # split platforms

      tag_scope = Content.tagged_with(tag.name)
      whitehall_scope = tag_scope.whitehall
      mainstream_scope = tag_scope.mainstream

      #mainstream published
      if mainstream_scope.any?
        categories << "#{tag.name} (Mainstream)"
        series.each_with_index do |serie, index|
          series[index][:data] << mainstream_scope.where(status: serie[:name]).sum("size")
        end
      end

      #Whitehall published
      if whitehall_scope.any?
        categories << "#{tag.name} (Whitehall)"
        series.each_with_index do |serie, index|
          series[index][:data] << whitehall_scope.where(status: serie[:name]).sum("size")
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
