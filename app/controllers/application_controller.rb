class ApplicationController < ActionController::Base
  helper_method :current_user,:logged_in? #indicates that those methods are also helpers , so the views can have access to them
  def current_user
    #If current_user already was callen , return it , if not make the call from the DB of user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    #!!Convert the answer from current_user in a boolean
    !!current_user
  end
end
