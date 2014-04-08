module ApplicationHelper
  def user_projects
    @user_projects = current_user.projects
  end
end
