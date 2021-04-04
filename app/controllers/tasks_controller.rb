class TasksController < ApplicationController
  before_action :set_task, only: [:edit, :update, :destroy, :show]

  def index
    @tasks = current_user.tasks
    #ソート
    if params[:sort_expired]
      @tasks = @tasks.order(expired_at: :ASC)
    elsif params[:sort_priority]
      @tasks = @tasks.order(priority: :DESC)
    else
      @tasks = @tasks.order(created_at: :DESC) 
    end
    #検索
    if params[:title] != "" && params[:title] != nil
      @tasks = @tasks.title_search(params[:title])
    end
    
    if params[:status] != "" && params[:status] != nil
      @tasks = @tasks.status_search(params[:status])
    end
    #ページネーション　kaminari
    @tasks = @tasks.page(params[:page]).per(5)
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
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
    params.require(:task).permit(:title, :content, :expired_at, :status, :priority)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end

