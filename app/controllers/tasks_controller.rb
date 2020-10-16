class TasksController < ApplicationController
    before_action :require_user_logged_in
    before_action :correct_user, only: [:show, :destroy, :edit, :update]
    
    def index
        current_user
    end
    
    def show
        @task = Task.find(params[:id])
    end
    
    def new
        #ユーザー情報がないから保存されないのを解決する必要がある
        @task = Task.new
    end
    
    def create
        @task = current_user.tasks.build(task_params)
        
        if @task.save
            flash[:success] = "Taskが正常に保存されました"
            redirect_to task_path(@task)
        else
            flash[:danger] = "Taskが保存されませんでした"
            render :new
        end
    end
    
    
    def edit
        @task = Task.find(params[:id])
    end
    
    def update
        @task = Task.find(params[:id])
        
        if @task.update(task_params)
            flash[:success] = "タスク内容は正常に更新されました"
            redirect_to task_path(@task)
        else
            flash.now[:danger] = "タスク内容は更新されませんでした"
            render :edit
        end
    end
    
    def destroy
        @task = Task.find(params[:id])
        @task.destroy
        
        flash[:success] = "タスク内容は正常に削除されました"
        redirect_to tasks_url
    end
    
    private
    
    #StrongParameter
    def task_params
        params.require(:task).permit(:content, :status)
    end
    
    def correct_user
        @task = current_user.tasks.find_by(id: params[:id])
        unless @task
            redirect_to root_path
        end
    end
end