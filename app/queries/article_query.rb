 class ArticleQuery
   def initialize(params = {})
     @tag = params[:tag]
     @author = params[:author]
     @favorited = params[:favorited]
     @offset = params.fetch(:offset, 0)
     @limit = params.fetch(:limit, 20)
   end

   def results
     apply_pagination_filter(
       apply_tag_filter(
         apply_author_filter(apply_favorited_filter(articles))
       )
     )
   end

   private

   attr_reader :tag, :author, :favorited, :offset, :limit

   def articles
     Article.includes(:user)
   end

   def apply_tag_filter(relation)
     return relation if tag.nil?
     relation.tagged_with(tag)
   end

   def apply_author_filter(relation)
     return relation if author.nil?
     relation.authored_by(author)
   end

   def apply_favorited_filter(relation)
     return relation if favorited.nil?
     relation.favorited_by(favorited)
   end

   def apply_pagination_filter(relation)
     relation.order(created_at: :desc).offset(offset).limit(limit)
   end
 end
