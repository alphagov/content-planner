class TasksController < ApplicationController
  expose(:content_plan)
  expose(:task, attributes: :task_params)
  expose(:tasks, ancestor: :content_plan)

  def create
    if task.save(task_params)
      redirect_to content_plan_path(task.content_plan)
    else
      render :new
    end
  end

  def update
    if task.update(task_params)
      redirect_to content_plan_path(task.content_plan)
    else
      render :edit
    end
  end

  def new
  end

  def edit
  end

  def task_params
    params.require(:task).permit(:title, :done, :content_plan_id)
  end
end
