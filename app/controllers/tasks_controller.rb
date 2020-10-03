class TasksController < ApplicationController
    def index
        @tasks = Task.all
    end
    
    def show
        @task = Task.find(params[:id])
    end
    
    def new
        @task = Task.new
    end
    
    def create
        @task = Task.new(task_params)
        
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
        @task = Task.new(task_params)
        
        if @task.save
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
    
end


private

#StrongParameter
def task_params
    params.require(:task).permit(:content)
end