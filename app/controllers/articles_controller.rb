class ArticlesController < ApplicationController
  before_filter :require_login, except: [:show, :index]
  before_filter :valid_author?, only: [:edit, :destroy]

  def valid_author?
    @article = Article.find(params[:id])
    unless @article.author_id == current_user.id
      # I would personally redirect_to "back" but require_login
      # method from sorcery redirects to the request.url which happens
      # to dump back to root_path in this case
      redirect_to root_path
      return false
    end
  end

  include ArticlesHelper

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])

    @comment = Comment.new
    @comment.article_id = @article.id
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.author_id = current_user.id
    @article.save

    flash.notice = "Article '#{@article.title}' created!"

    redirect_to article_path(@article)
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    flash.notice = "Article '#{@article.title}' deleted!"

    redirect_to articles_path
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    @article.update(article_params)

    flash.notice = "Article '#{@article.title}' updated!"

    redirect_to article_path(@article)
  end
end
