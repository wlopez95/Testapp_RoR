class UsersController < ApplicationController
    before_action :set_user, only: [:show,:edit,:update,:destroy]
    before_action :require_user, except: [:show,:index,:new,:create]
    before_action :require_same_user, only: [:edit, :update, :destroy]
    def index
        @users = User.paginate(page: params[:page], per_page: 5)
    end
    def show
        @articles = @user.articles.paginate(page: params[:page], per_page: 2)
    end
    def new
        @user = User.new
    end

    def create
        @user  = User.new(user_params)
        if @user.save
            redirect_to  user_path(@user), notice: "User #{@user.username} was created successfully"
        else
            render :new, status: :unprocessable_entity
        end
    end

    def edit
    end

    #Ejecuta la llamara rest para actualizar un articulo
    def update
        if @user.update(user_params)
            redirect_to  user_path(@user), notice: "Your user was updated successfully"
        else
            render :edit, status: :unprocessable_entity
        end
    end


    def destroy
        @user.destroy
        message = "Account and all associated articles successfully deleted"
        if current_user == @user
            logout(message)
        else
            redirect_to  root_path, notice: "#{@user.username} #{message}"
        end
    end


    private


    def user_params
        params.require(:user).permit(:username, :email, :password)
    end

    def set_user
        @user = User.find(params[:id])
    end

    def require_same_user
        if current_user != @user && !current_user.admin?
            redirect_to @user, alert: "You can only edit your own accout"
        end
    end

    
    
end
