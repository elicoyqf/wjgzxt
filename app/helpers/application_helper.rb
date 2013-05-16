module ApplicationHelper
  def current_user
    user = User.find(session[:user_id])
  end

  def user_level
    u = current_user
    u.level
  end
end
