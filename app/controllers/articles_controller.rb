class ArticlesController < ApplicationController
    before_action :set_article,only: [:show, :edit, :update, :destroy]

    def index
        @articles = Article.all
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
        @article.user = User.first
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


    private

    def set_article
        @article = Article.find(params[:id]) 
    end

    def article_params
        params.require(:article).permit(:title, :description)
    end
    
end

# debugger
