module Type
  extend ActiveSupport::Concern

  def article_type
    @articles = params_type.return_type
  end

  private

  def params_type
    return Tag if params[:tag]
    return Author if params[:author]
    return Favorited if params[:favorited]
  end

  class Tag
    def self.return_type
      @articles.tagged_with(params[:tag])
    end
  end

  class Author
    def self.return_type
      @articles.authored_by(params[:author])
    end
  end

  class Favorited
    def self.return_type
      @articles.favorited_by(params[:favorited])
    end
  end
end
