class ArticlesController < ApplicationController

  def index
    if current_user.present? && current_user.role == "blogger"
      @articles = current_user.articles
    elsif current_user.present? && current_user.role == "viewer"
      @articles = Article.all
    else
      redirect_to user_session_path
    end
    @categories = Category.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def edit
    if current_user.blogger?
      @article = Article.find(params[:id])
    else
      redirect_to articles_path, :alert => "You are not a blogger"
    end
  end
  
  def create
      if current_user.blogger?
        @article = current_user.articles.create(article_params)
        if @article.save
          params[:article][:category].each do |category|
          ArticleCategory.create(category_id: category, article_id: @article.id)
          UserMailer.welcome_email(current_user).deliver
        end
          redirect_to @article
        else
          render 'new'
        end
      else
        redirect_to articles_path, :alert => "You are not a blogger"
      end
  end

  def update
    if current_user.blogger?
      @article = Article.find(params[:id])
      if @article.update(article_params)
        redirect_to @article
      else
        render 'edit'
      end
    else
      redirect_to articles_path, :alert => "You are not a blogger"
    end  
  end

  def destroy
      @article = Article.find(params[:id])
      @article.destroy
      redirect_to articles_path
  end

  private
  def article_params
    params.require(:article).permit(:title, :description, :category, :categories, :image, :role )
  end
end