module BlogPostsHelper
  def author(comment)
    unless comment.website.blank?
      link_to comment.author, comment.website
    else
      "<strong>#{comment.author}</strong>"
    end
  end
end
