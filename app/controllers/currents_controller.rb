class CurrentsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_project, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_current, only: [:edit, :update, :destroy]

  
  def new
    @current = @project.currents.build
  end

  def edit
    @current = @project.currents.find(@current.id)
  end

  def create
    @current = Current.new(current_params)
    @current.project_id =  @project.id
    if @current.save
      redirect_to project_url(@project)
    else  
      render action: 'new'
    end
  end

  def update
    if @current.update(current_params)
      redirect_to project_url(@project)
    else
      render action: 'edit'
    end
  end

  def destroy
    @current.destroy
    redirect_to project_url(@project)
  end

  private
    def set_project
      @project = current_user.projects.find(params[:project_id])
      rescue ActiveRecord::RecordNotFound
        redirect_to projects_path, :flash => { :error => "A projekt nem található." }
    end
    
    def set_current
      @current = @project.currents.find(params[:id])
    end

    def current_params
      params.require(:current).permit(:item_id, :quantity, :pass, :delivery)
    end
end