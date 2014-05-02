module PagesHelper
  def filtered_depots
    tank = Depot.where(:user_id => current_user.id)
    depots = tank.group("item_id")
    @filtered_depots = depots.select("item_id, sum(quantity) as total_quantity")
  end

  def bar_colors
    bar_colors = ["success", "info", "warning", "danger"]
  end
end