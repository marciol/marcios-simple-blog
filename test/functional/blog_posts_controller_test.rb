require 'test_helper'

class BlogPostsControllerTest < ActionController::TestCase
  context "with a BlogPost in database" do
    setup do
      @blog_post = Factory(:blog_post)
      Page.stubs(:find_by_permalink).returns(@blog_post)
    end

    context "index action" do
      setup do
        get :index
      end
      
      should_render_template :index
    end

    context "index with atom format" do
      setup do
        get :index
      end
      should_respond_with_content_type :atom
    end

    context "show action" do
      setup do
        get :show, :id => @blog_post.permalink
      end

      should_assign_to(:blog_post){ @blog_post }
      should_assign_to(:metatag_object){ @blog_post }
      should_render_template :show
    end

    context "search action" do
      setup do
        @foo_bar = Factory(:blog_post, :name => 'foo bar')
        get :search, :search => 'foo'
      end
      should_render_template :index
      should_assign_to(:blog_posts){[@foo_bar]}
      should_assign_to(:metatag_object){ Page.find_by_permalink('blog') }
    end

    context "tag action" do
      setup do
        @tagged_with_bar = Factory(:blog_post, :name => 'bar')
        @tagged_with_bar.tag_list = [ 'bar' ]
        @tagged_with_bar.save
        get :tags, :tag => 'bar'
      end
      should_render_template :index
      should_assign_to(:blog_posts){[@tagged_with_bar]}
      should_assign_to(:metatag_object){ Page.find_by_permalink('blog') }
    end

  end
end

