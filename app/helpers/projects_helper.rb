module ProjectsHelper
  def filtered_currents
    tank = Current.where(:project_id => @project.id)
    currents = tank.group("item_id")
    @filtered_currents = currents.select("item_id, sum(quantity) as total_quantity")
  end

  def filtered_plans
    storage = Plan.where(:project_id => @project.id)
    plans = storage.group("item_id")
    @filtered_plans = plans.select("item_id, sum(quantity) as total_quantity")
  end

  
end
