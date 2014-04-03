class PlansController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_project, only: [:index, :new, :edit, :create, :update, :destroy]
  before_action :set_plan, only: [:edit, :update, :destroy]
  
  def index
    @project.plans.collect
  end

  def new
    @plan = @project.plans.build
  end

  def edit
    @plan = @project.plans.find(@plan.id)
  end

  def create
    @plan = Plan.new(plan_params)
    @plan.project_id =  @project.id
    if @project.plans.where(:item_id => @plan.item_id).blank?
      @plan.save
      redirect_to project_plans_url
    elsif
      @plan.quantity.nil?
      redirect_to project_plans_url, :flash => { :error => "Nem megfelelő adatot adott meg!" }
    else  
      new_plan = @project.plans.where(item_id: @plan.item_id).first_or_initialize
      new_plan.quantity += @plan.quantity
      new_plan.save
      redirect_to project_plans_url
    end
  end

  def update
    if @plan.update(plan_params)
      redirect_to project_plans_url, notice: 'A sor sikeresen szerkesztve.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @plan.destroy
    redirect_to project_plans_url, notice: 'A sor törölve.'
  end

private
  def set_project
    @project = current_user.projects.find(params[:project_id])
    rescue ActiveRecord::RecordNotFound
      redirect_to projects_path, :flash => { :error => "A projekt nem található." }
  end

  def plan_params
    params.require(:plan).permit(:item_id, :quantity)
  end

  def set_plan
    @plan = @project.plans.find(params[:id])
  end  
end
