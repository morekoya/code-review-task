class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @articles = Article.includes(:user)
    articles_type
    offset = boundary_offset(0)
    limit = boundary_limit(20)
    @articles = @articles.order(created_at: :desc).offset(offset).limit(limit)
  end

  def feed
    @articles = Article
                .includes(:user)
                .where(user: current_user.following_users)

    offset = boundary_offset(offset)
    limit = boundary_limit(limit)
    @articles = @articles.order(created_at: :desc).offset(offset).limit(limit)
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

  def show
    @article = Article.find_by_slug!(params[:slug])
  end

  def update
    @article = Article.find_by_slug!(params[:slug])

    if @article.user_id == @current_user_id
      @article.update_attributes(article_params)
      render :show
    else
      render json: not_owned, status: :forbidden
    end
  end

  def destroy
    @article = Article.find_by_slug!(params[:slug])

    if @article.user_id == @current_user_id
      @article.destroy

      render json: {}
    else
      render json: not_owned, status: :unprocessable_entity
    end
  end

  protected

  def article_params
    params.require(:article).permit(:title, :body, :description, tag_list: [])
  end

  def articles_type
    tag if params[:tag].present
    author if params[:author].present
    favorited if params[:favorited].preset
  end

  def tag
    @articles = @articles.tagged_with(params[:tag])
  end

  def author
    @articles = @articles.authored_by(params[:author])
  end

  def favorited
    @articles = @articles.favorited_by(params[:favorited])
  end

  def boundary_offset(_offset = nil)
    @articles_count = @articles.count
    _offset = params[:offset] if params[:offset]
  end

  def boundary_limit(_limit = nil)
    @articles_count = @articles.count
    _limit = params[:limit] if params[:limit]
  end

  def not_owned
    { errors: { article: ['not owned by user'] } }
  end
end
