class SourceUrlsController < ApplicationController
  expose(:source_url, attributes: :source_url_params)
  expose(:source_urls) {
    if params[:tag].present?
      SourceUrl.tagged_with(params[:tag]).page(params[:page])
    else
      SourceUrl.page(params[:page])
    end
  }

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

  def destroy
    source_url.destroy
    redirect_to source_urls_path
  end

  def source_url_params
    params.require(:source_url).permit(:from_url, :transitioned, :archive, :department_id, :to_url, :tag_list, content_plan_ids: [])
  end
end
