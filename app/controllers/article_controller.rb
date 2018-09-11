class ArticlesController < ApplicationController
  include Query
  include Output
  include Type

  before_action :authenticate_user!, except: [:index, :show]

  def index
    @articles = Article.includes(:user)
    article_type
    boundary(0, 20)
  end

  def feed
    @articles = Article
                .includes(:user)
                .where(user: current_user.following_users)
    boundary
    render :index
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      render :show
    else
      render json: { errors: @article.errors }, status: :unprocessable_entity
    end
  end

  def show
    @article = Article.find_by_slug!(params[:slug])
  end

  def update
    @article = Article.find_by_slug!(params[:slug])

    if @article.user_id == @current_user.id
      @article.update_attributes(article_params)
      render :show
    else
      render json: not_owned, status: :forbidden
    end
  end

  def destroy
    @article = Article.find_by_slug!(params[:slug])

    if @article.user_id == @current_user.id
      @article.destroy
      render json: {}
    else
      render json: not_owned, status: :unprocessable_entity
    end
  end

  protected

  def article_params
    params
      .require(:article)
      .permit(:title, :body, :description, tag_list: [])
      .merge(user: current_user)
  end
end
