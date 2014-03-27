class ItemsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    @items = Item.all
  end

  def show
    rescue ActiveRecord::RecordNotFound
    redirect_to units_path, :flash => { :error => "Az anyag nem található." }
  end

  def new
    @item = Item.new
  end

  def edit
    rescue ActiveRecord::RecordNotFound
    redirect_to units_path, :flash => { :error => "Az anyag nem található." }
  end

  def create
    @item = Item.new(item_params)

    if @item.save
      redirect_to items_url, notice: 'Az anyag sikeresen létrehozva.'
    else
      render action: 'new'
    end
  end

  def update
    if @item.update(item_params)
      redirect_to items_url, notice: 'Az anyag sikeresen frissítve.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @item.destroy
    redirect_to items_url, notice: 'Az anyag törölve.'
  end

  private
    def set_item
      @item = Item.find(params[:id])
    end

    def item_params
      params.require(:item).permit(:name, :unit_id)
    end
end
