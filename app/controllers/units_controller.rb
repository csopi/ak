class UnitsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_unit, only: [:show, :edit, :update, :destroy]

  def index
    @units = Unit.all
  end

  def show
  end

  def new
    @unit = Unit.new
  end

  def edit
  end

  def create
    @unit = Unit.new(unit_params)

    if @unit.save
      redirect_to units_url, notice: 'A mértékegység sikeresen létrehozva.'
    else
      render action: 'new'
    end
  end

  def update
    if @unit.update(unit_params)
      redirect_to units_url, notice: 'A mértékegység sikeresen szerkesztve.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @unit.destroy
    redirect_to units_url, notice: 'Unit was successfully destroyed.'
  end

  private
    def set_unit
      @unit = Unit.find(params[:id])
    end

    def unit_params
      params.require(:unit).permit(:name)
    end
end
