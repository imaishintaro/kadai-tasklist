class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :set_task, only: [:show, :edit, :update, :destroy]     
     
  def index
          @tasks=Task.all.page(params[:page]).per(10)
  end

  def show
     
  end
  
  def new
      @task=current_user.tasks.new
  end

  def create
   @task =  current_user.tasks.build(task_params)

    if @task.save
      flash[:success] = 'Task が正常に投稿されました'
         redirect_to root_url
    else
      @tasks = current_user.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'Task が投稿されませんでした'
      render :new
    end
  end

  def edit #beforeactionのみ実行
   
  end

  def update


    if @task.update(task_params)
      flash[:success] = 'Task は正常に更新されました'
      redirect_to root_url
    else
      flash.now[:danger] = 'Task は更新されませんでした'
      render :edit
    end
  end

  def destroy
      
  @task.destroy
   flash[:success] = 'Taskを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  
  def set_task
    @task = Task.find(params[:id])
  end
  
  def task_params
       params.require(:task).permit(:content, :status)
  end
  
end


