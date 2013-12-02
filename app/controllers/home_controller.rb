class HomeController < ApplicationController
  skip_before_filter :authenticate_user!
  skip_before_filter :require_signin_permission!

  def index
  end

  def dashboard_data
    respond_to do |format|
      format.html { render text: "json only" }
      format.json {
        render json: { 
          xAxis: { categories: ["PAYE (M)", "PAYE (W)", "VAT (M)", "VAT (W)", "Self assessment (M)", "Self assessment (W)", "PAYE (M)", "PAYE (W)", "VAT (M)", "VAT (W)", "Self assessment (M)", "Self assessment (W)", "PAYE (M)", "PAYE (W)", "VAT (M)", "VAT (W)", "Self assessment (M)", "Self assessment (W)", "PAYE (M)", "PAYE (W)", "VAT (M)", "VAT (W)", "Self assessment (M)", "Self assessment (W)"] },
          series: [ 
            { name: "Published", data: [1, 2, 2, 2, 2, 1] }, 
            { name: "Completed", data: [3, 4, 4, 2, 5, 2] }, 
            { name: "In Progress", data: [2, 2, 3, 2, 2, 1] }, 
            { name: "Not started", data: [10, 13, 14, 17, 2, 4, 10, 13, 14, 17, 2, 4, 10, 13, 14, 17, 2, 4, 10, 13, 14, 17, 2, 4] }
          ]
        }
      }
    end
  end
end
