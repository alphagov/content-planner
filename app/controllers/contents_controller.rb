class ContentsController < ApplicationController
  expose(:content, attributes: :content_params)
  expose(:contents) {
    if params[:tag].present?
      Content.tagged_with(params[:tag]).page(params[:page])
    else
      Content.page(params[:page])
    end
  }

  def create
    if content.save
      if params[:content][:maslow_need_ids].present?
        ContentNeed.where(content_id: content.id).destroy_all
        need_ids = params[:content][:maslow_need_ids].split(",")
        need_ids.each do |nid|
          ContentNeed.find_or_create_by!(content_id: content.id, need_id: nid)
        end
      end
      redirect_to contents_path, notice: 'Content was successfully created.'
    else
      render :new
    end
  end

  def update
    if content.save
      if params[:content][:maslow_need_ids].present?
        ContentNeed.where(content_id: content.id).destroy_all
        need_ids = params[:content][:maslow_need_ids].split(",")
        need_ids.each do |nid|
          ContentNeed.find_or_create_by!(content_id: content.id, need_id: nid)
        end
      end
      redirect_to contents_path
    else
      render :edit
    end
  end

  def destroy
    content.destroy
    redirect_to contents_path
  end

  def content_params
    params.require(:content).permit(:url,
      :status,
      :size,
      :content_type,
      :platform,
      :tag_list,
      :maslow_need_ids,
      content_plan_ids: []
    )
  end
end
