class SourceUrlsController < ApplicationController
  expose(:source_url, attributes: :source_url_params)
  expose(:source_urls) { SourceUrl.page(params[:page]) }

  def create
    if source_url.save
      redirect_to source_urls_path
    else
      render :new
    end
  end

  def update
    if source_url.save
      redirect_to source_urls_path
    else
      render :edit
    end
  end

  def source_url_params
    params.require(:source_url).permit(:from_url, :transitioned, :archive, :department_id, :to_url)
  end
end
