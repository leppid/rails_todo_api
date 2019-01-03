class TasksController < ApplicationController
  def index
    tasks = current_user.tasks.all
    if tasks.length
      render json: tasks, each_serializer: TasksSerializer, status: 200
    end
  end

  def create
    task = current_user.tasks.new(task_params)
    if task.save
      render json: task, each_serializer: TasksSerializer, status: 200
    else
      render status: 400
    end
  end

  def show
    task = current_user.tasks.find(params[:id])
    if task
      render json: task, each_serializer: TasksSerializer, status: 200
    else
      render status: 400
    end
  end

  def update
    task = current_user.tasks.find(params[:id])
    if task.update(task_params)
      render json: task, each_serializer: TasksSerializer
    else
      render status: 400
    end
  end

  def destroy
    task = current_user.tasks.find(params[:id])
    if task
      task.destroy
      render json: { message: 'Task has been deleted', status: 'success' }, status: 200
    end
  end

  def destroychecked
    tasks = current_user.tasks.where(id: params[:ids])
    if tasks.length > 0
      tasks.destroy_all
      render json: { message: 'Tasks has been deleted', status: 'success' }, status: 200
    else
      render json: { message: 'No tasks selected', status: 'info' }, status: 404
    end
  end

  def task_params
    params.require(:task).permit(:title, :description, :priority, :duedate, :done)
  end
end
