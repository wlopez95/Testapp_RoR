class UsersController < ApplicationController
    def index
        @users = User.all
    end
    def show
        @user = User.find(params[:id])
        @articles = @user.articles
    end
    def new
        @user = User.new
    end

    def create
        @user  = User.new(user_params)
        if @user.save
            redirect_to  root_path(), notice: "User #{@user.username} was created successfully"
        else
            render :new, status: :unprocessable_entity
        end
    end

    def edit
        @user = User.find(params[:id])
    end

    #Ejecuta la llamara rest para actualizar un articulo
    def update
        @user = User.find(params[:id])
        if @user.update(user_params)
            redirect_to  user_path(@user), notice: "Your user was updated successfully"
        else
            render :edit, status: :unprocessable_entity
        end
    end


    private


    def user_params
        params.require(:user).permit(:username, :email, :password)
    end
    
end
