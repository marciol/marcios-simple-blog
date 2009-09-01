class BlogPostsController < ApplicationController

  before_filter :build_tags

  def index
    @blog_posts = BlogPost.all
#    @blog_posts = BlogPost.list :page => params[:page]
    @metatag_object = Page.find_by_permalink('blog')
    respond_to do |wants|
      wants.html
      wants.atom
    end
  end

  def show
    @blog_post = BlogPost.find_by_permalink(params[:id])
    @comment = BlogComment.new
    @metatag_object = @blog_post
  end

  def search
    @blog_posts = BlogPost.search params[:search], :page => params[:page]
    @metatag_object = Page.find_by_permalink('blog')
    render :action => :index
  end

  def tags
    @blog_posts = BlogPost.all_from_tag params[:tag]
    @metatag_object = Page.find_by_permalink('blog')
    render :action => :index
  end

  private

  def build_tags
    @tags = BlogPost.tag_counts
  end
end

