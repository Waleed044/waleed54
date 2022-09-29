class ArticlesController < ApplicationController

  def index
    if current_user.present? && current_user.role == "blogger"
      @articles = current_user.articles
    elsif current_user.present? && current_user.role == "viewer"
      @articles = Articles.all
    else
      redirect_to user_session_path
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def edit
    if current_user.blogger?
      @article = Article.find(params[:id].merge(user_id: current_user.id))
    else
      redirect_to articles_path, :alert => "You are not a blogger"
    end
  end

  def create
      if current_user.blogger?
        @article = Article.new(article_params.merge(user_id: current_user.id))
        if @article.save
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
    if current_user.blogger?
      @article = Article.find(params[:id])
      @article.destroy
    else
      redirect_to articles_path, :alert => "You are not a blogger"
    end
  end

  private
  def article_params
    params.require(:article).permit(:title, :description)
  end
end