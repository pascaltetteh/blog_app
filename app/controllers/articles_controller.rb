class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :show, :destroy]
  def new
    @article = Article.new
  end
  def create
  #render plain: params[:article].inspect
    @article = Article.new(article_params)
    @article.save
    redirect_to articles_show(@article)
  end
  def create
     @article = Article.new(article_params)
     @article.user = current_user
     if @article.save
       flash[:success] = "Article was successfully created"
       redirect_to article_path(@article)
     else
       render 'new'
     end
  end
  
  def show
   
  end
  def edit
   
  end
  def update
    @article.user = current_user
    if @article.update(article_params)
      flash[:success] = "Article was updated"
      redirect_to article_path(@article)
    else
      flash[:success] = "Article was not updated"
      render 'edit'
    end
  end
  
  def destroy
  
    @article.destroy
    flash[:success] = "Article was deleted"
    redirect_to articles_path
  end
  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end
  private
  def article_params
    params.require(:article).permit(:title, :description)
  end
  def set_article
    @article = Article.find(params[:id])
  end

  
end