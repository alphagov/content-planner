class TasksController < ApplicationController
  expose(:task, attributes: :task_params)

  def create
    self.task = current_user.created_tasks.new(task_params)

    if task.save
      redirect_to task.taskable
    else
      render :new
    end
  end

  def update
    self.task = Task.find(params[:id])
    complete_task = Tasks::Complete.new(task, current_user, task_params).run

    if complete_task.success?
      redirect_to task.taskable,
                  notice: "Task completed"
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
