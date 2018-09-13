class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_article, only: [:show, :update, :destroy]
  before_action :set_requester_id, only: [:update, :destroy]

  def index
    @articles = ArticleQuery.new(params).results
    @articles_count = @articles.count
  end

  def feed
    @articles = ArticleQuery.new(params).results.
                where(user: current_user.following_users)

    @articles_count = @articles.count
    render :index
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user

    if @article.save
      render :show
    else
      render json: { errors: @article.errors }, status: :unprocessable_entity
    end
  end

  def show; end

  def update
    if @article.update_attributes(article_params)
      render :show
    else
      render json: { errors: { article: @article.errors } },
             status: :forbidden
    end
  end

  def destroy
    if @article.destroy
      render head :ok
    else
      render json: { errors: { article: @article.errors } },
             status: :unprocessable_entity
    end
  end

  protected

  def find_article
    @article = Article.find_by_slug!(params[:slug])
  end

  def article_params
    params.require(:article).permit(:title, :body, :description, tag_list: [])
  end

  def set_requester_id
    @article.requester_id = @current_user_id
  end
end
