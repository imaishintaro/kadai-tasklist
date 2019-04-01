class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user,only: [:show, :edit, :update, :destroy] 
     
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
      flash.now[:danger] = 'Task が投稿されませんでした'
      render :new
    end
  end

  def edit #beforeactionのみ実行
   
  end

  def update


    if @tasks.update(task_params)
      flash[:success] = 'Task は正常に更新されました'
      redirect_to root_url
    else
      flash.now[:danger] = 'Task は更新されませんでした'
      render :edit
    end
  end

  def destroy
      
  @tasks.destroy
   flash[:success] = 'Taskを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  
  
  def task_params
       params.require(:task).permit(:content, :status)
  end
  
  
  def correct_user
    @tasks = current_user.tasks.find_by(id: params[:id])
    unless @tasks
      redirect_to root_url
    end
  end
  
end


