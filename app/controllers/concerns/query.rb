module Query
  extend ActiveSupport::Concern

  def boundary_offset
    params[:offset] if params[:offset]
  end

  def boundary_limit
    params[:limit] if params[:limit]
  end

  def boundary(offset = nil, limit = nil)
    @articles_count = @articles.count
    offset = boundary_offset || offset
    limit = boundary_limit || limit
    @articles = @articles.order(created_at: :desc).offset(offset).limit(limit)
  end
end
