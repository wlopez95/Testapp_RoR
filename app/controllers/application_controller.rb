class ApplicationController < ActionController::Base
  helper_method :current_user,:logged_in?,:user_have_access? #indicates that those methods are also helpers , so the views can have access to them
  def current_user
    #If current_user already was callen , return it , if not make the call from the DB of user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    #!!Convert the answer from current_user in a boolean
    !!current_user
  end

  def require_user
    if !logged_in?
      redirect_to login_path, alert: "You must be logged in to perform this action"
    end
  end

  def require_same_user
    if current_user != @article.user && !current_user.admin?
      redirect_to @article, alert: "You can only edit your own articles"
    end
  end

  def logout(message)
    session[:user_id] = nil
    redirect_to  root_path, notice: message
  end

  def user_have_access?(user)
    user == current_user || current_user.admin?
  end
end
