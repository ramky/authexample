class Api::V1::TasksController < ApplicationController
  def index
    @tasks = []
    if current_user.tasks.count > 0
      @tasks = current_user.tasks.map{ |t| { id: t.id, title: t.title, completed: t.completed } }
    end

    render status: 200,
      json: {success: true, info: 'Tasks', data: {tasks: @tasks}}
  end

  def create
    task = current_user.tasks.build(task_params)
    if task.save
      render_task(task)
    else
      render_task_error('Task was not saved.')
    end
  end

  def complete
    #tasks_for_current_user = current_user.tasks.pluck(:id)
    task = Task.find(params[:id])
    if task.user == current_user
      task.update_attribute(:completed, true)
      render_task(task)
    else
      render_task_error('Task is not owned by user.')
    end
  end

  def open
    task = Task.find(params[:id])
    if task.user == current_user
      task.update_attribute(:completed, false)
      render_task(task)
    else
      render_task_error('Task is not owned by user.')
    end
  end

private

  def task_params
    params.require(:task).permit(:title, :completed)
  end

  def render_task_error(message)
    render status: :unprocessable_entity,
      json: {success: false, info: message, data: {}}
  end

  def render_task(task)
    render status: 200,
      json: {success: true, info: 'Task Created!', data: {task: {id: task.id, title: task.title, completed: task.completed} } }
  end
end
