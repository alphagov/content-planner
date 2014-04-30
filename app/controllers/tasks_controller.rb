class TasksController < ApplicationController
  expose(:task, attributes: :task_params)

  def create
    if task.save(task_params)
      redirect_to task.taskable
    else
      render :new
    end
  end

  def update
    if task.update(task_params)
      redirect_to task.taskable
    else
      render :edit
    end
  end

  def edit
  end

  def destroy
    task.destroy
    redirect_to task.taskable
  end

  def task_params
    params.require(:task).permit(:title, :done, :taskable_id, :taskable_type, :deadline, user_ids: [])
  end
end
