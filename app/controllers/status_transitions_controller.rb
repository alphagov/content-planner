class StatusTransitionsController < ApplicationController
  expose(:mainstream_status_transitions) do
    StatusTransition.mainstream
                    .order_by_occurred_at_desc
                    .includes(:content)
  end

  expose(:whitehall_status_transitions) do
    StatusTransition.whitehall
                    .order_by_occurred_at_desc
                    .includes(:content)
  end
end
