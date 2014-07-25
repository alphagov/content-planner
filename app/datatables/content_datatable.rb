class ContentDatatable
  delegate :params, :h, :link_to, to: :@view

  def initialize(view, search = nil)
    @view = view
    @search = search
    @contents = search.results
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: @contents ? @contents.count : 0,
      iTotalDisplayRecords: @contents ? @contents.count : 0,
      aaData: data
    }
  end

private

  def data
    @search.order("#{sort_column} #{sort_direction}").results.page(page).map do |content|
      [
        link_to(content.title, content),
        content.size,
        content.status,
        content.platform,
        content.publish_by.present? ? content.publish_by : ""
      ]
    end
  end

  def page
    params[:iDisplayStart].to_i/7 + 1
  end

  def sort_column
    columns = %w[title size status platform publish_by]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end