class ArticlesController < ApplicationController
    before_action :set_article,only: [:show, :edit, :update, :destroy] #Allows to execute methods, when any of the [only] methods runs, the first step is execute set_article
    before_action :require_user, except: [:show,:index]
    before_action :require_same_user, only: [:edit, :update, :destroy]
    def index
        @articles = Article.paginate(page: params[:page], per_page: 5) #<>.paginate permit the use of pagination in the view, check the view shared/_pagination
    end

    def show 
    end

    #Crea la ruta para desplegar el form
    def new
        @article  = Article.new
    end

    #Ejecuta la llamara rest para crear un articulo
    def create
        @article  = Article.new(article_params)
        @article.user = current_user
        if @article.save
            redirect_to  @article, notice: "Article was created successfully"
        else
            render :new, status: :unprocessable_entity
        end
    end
    
    #Crea la ruta para desplegar el form de edicion
    def edit
    end

    #Ejecuta la llamara rest para actualizar un articulo
    def update 
        if @article.update(article_params)
            redirect_to  @article, notice: "Your article was updated successfully"
        else
            render :edit, status: :unprocessable_entity
        end
    end


    def destroy
        @article.destroy
        redirect_to articles_path notice: "Article was deleted successfully"
    end


    private #this methods before this tag, just can be executed inside this same controller

    def set_article
        @article = Article.find(params[:id]) 
    end

    def article_params
        params.require(:article).permit(:title, :description)
    end
    
end

# debugger
