 class ArticleQuery
   def initialize(params = {})
     @tag = params[:tag]
     @author = params[:author]
     @favorited = params[:favorited]
   end

   def results
     apply_tag_filter(
       apply_author_filter(apply_favorited_filter(articles))
     )
   end

   private

   attr_reader :tag, :author, :favorited

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
     return relation if favorited.nil? # Guard clause
     relation.favorited_by(favorited)
   end
 end
