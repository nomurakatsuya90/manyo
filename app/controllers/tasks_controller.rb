class TasksController < ApplicationController
  before_action :set_task, only: [:edit, :update, :destroy, :show]

  def index
    @tasks = Task.all
    @tasks = @tasks.order(created_at: :DESC)
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if params[:back]
      render :new
    else
      if @task.save
        redirect_to task_path(@task.id), notice: "taskを作成しました！"  #一覧画面へ遷移
      else
        render :new  #同画面を再描画
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to task_path(@task.id), notice: "taskを編集しました！"
    else
      render :edit
    end
  end
  
  # def confirm
  #   @task = Task.new(task_params)
  #   render :new if @task.invalid?
  # end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice:"taskを削除しました！"
  end

  private
  def task_params
    params.require(:task).permit(:title, :content)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end

