class BlogCommentsController < ApplicationController

  before_filter :build_tags

  def create
    @blog_post = BlogPost.find params[:blog_post_id]
    @metatag_object = @news_post
    @comment = BlogComment.new params[:blog_comment]
    if @comment.valid?
      @blog_post.blog_comments << @comment
      flash[:notice] = I18n.t(:comment_success) 
      redirect_to blog_post_path(@blog_post.permalink)
    else
      render 'blog_posts/show'
    end
  end

  private

  def build_tags
    @tags = BlogPost.tag_counts
  end
end
