class StatusTransitionsController < ApplicationController
  expose(:mainstream_status_transitions) do
    base = StatusTransition.mainstream
                           .order_by_occurred_at_desc
                           .includes(:content)

    apply_search base
  end

  expose(:whitehall_status_transitions) do
    base = StatusTransition.whitehall
                           .order_by_occurred_at_desc
                           .includes(:content)

    apply_search base
  end

  expose :search do
    StatusTransitionSearch.new(params[:search])
  end

private
  def apply_started_from(base)
    if search.started_from.present?
      base.start_after search.started_from
    else
      base
    end
  end

  def apply_ended_at(base)
    if search.ended_at.present?
      base.end_before search.ended_at
    else
      base
    end
  end

  def apply_search(base)
    apply_ended_at apply_started_from(base)
  end
end
