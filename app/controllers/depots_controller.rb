class DepotsController < ApplicationController
  before_filter :authenticate_user!
  before_action :find_depot, :only => [:edit, :update, :destroy]

  def index
    @depots = current_user.depots
  end

  def new
    @depot = Depot.new
  end

  def edit
  end

  def create
    @depot = Depot.new(depot_params)
    @depot.user = current_user

    if @depot.save
      redirect_to depots_url
    else
      render action: 'new'
    end
  end

  def update
    if @depot.update(depot_params)
      redirect_to depots_url
    else
      render action: 'edit'
    end
  end

  def destroy
    @depot.destroy
    redirect_to depots_url
  end

  private
    def find_depot
      @depot = current_user.depots.find(params[:id])
      rescue ActiveRecord::RecordNotFound
      redirect_to projects_path, :flash => { :error => "A raktár nem található." }
    end

    def depot_params
      params.require(:depot).permit(:item_id, :quantity, :delivery, :pass, :user_id)
    end
end