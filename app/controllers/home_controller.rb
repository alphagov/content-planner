class HomeController < ApplicationController
  skip_before_filter :authenticate_user!, only: :dashboard_data
  skip_before_filter :require_signin_permission!, only: :dashboard_data

  def index
  end

  def dashboard_data
    categories = []
    series = [{ name: "Published", data: [] }, { name: "Completed", data: [] }, { name: "In progress", data: [] }, { name: "Not started", data: []}] 
    Content.tag_counts_on(:tags).to_a.sort{|a,b| a.name <=> b.name}.each do |tag|
      # split platforms

      #mainstream published
      categories << "#{tag.name} (M)"
      series[0][:data] << Content.tagged_with(tag.name).where(status: "Published", platform: "Mainstream").count
      series[1][:data] << Content.tagged_with(tag.name).where(status: "Completed", platform: "Mainstream").count
      series[2][:data] << Content.tagged_with(tag.name).where(status: "In progress", platform: "Mainstream").count
      series[3][:data] << Content.tagged_with(tag.name).where(status: "Not started", platform: "Mainstream").count

      #Whitehall published
      categories << "#{tag.name} (W)"
      series[0][:data] << Content.tagged_with(tag.name).where(status: "Published", platform: "Whitehall").count
      series[1][:data] << Content.tagged_with(tag.name).where(status: "Completed", platform: "Whitehall").count
      series[2][:data] << Content.tagged_with(tag.name).where(status: "In progress", platform: "Whitehall").count
      series[3][:data] << Content.tagged_with(tag.name).where(status: "Not started", platform: "Whitehall").count
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
