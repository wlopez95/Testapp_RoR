class SessionsController < ApplicationController
  def new

  end

  def create
    # session = params.require(:session).permit( :email, :password)
    user =  User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to  user_path(user), notice: "Logged in successfully ,Welcome #{user.username}"
    else
      redirect_to  login_path(), alert: "Was something wrong with your Login, Please try again"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to  root_path, notice: "Logged out"

  end
end
