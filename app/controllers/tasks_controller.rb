class TasksController < ApplicationController

def index
  tasks = current_user.tasks.all
  if tasks
    render json: tasks, each_serializer: TasksSerializer , status: 200
  else
    return head(:bad_request)
    end
  end

  def create
    task = current_user.tasks.new(task_params)
    if task.save
      render json: task, each_serializer: TasksSerializer, status: 200
    end
  end

  def destroy
    task = current_user.tasks.find(params[:id])
    if task
    task.destroy
    end
  end

  def task_params
    params.require(:task).permit(:title, :description, :priority, :duedate, :done)
  end
end
