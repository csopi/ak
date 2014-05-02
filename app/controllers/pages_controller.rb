class PagesController < ApplicationController
  before_filter :authenticate_user!, only: [:depotsum, :itemsum]

  def index
  end

  def depotsum
  end

  def itemsum
  end

  def about
  end

  def contact
  end
end