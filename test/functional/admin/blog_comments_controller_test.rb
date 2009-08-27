require 'test_helper'

class Admin::BlogCommentsControllerTest < ActionController::TestCase
  context 'logged as admin' do
    setup do
      activate_authlogic
      UserSession.create(Factory(:admin))
    end
    
    context 'and with some blog_comments in the database' do
      setup do
        @blog_post = Factory(:blog_post)
        @blog_comments = []
        3.times do |i|
          @blog_comments << Factory(:blog_comment, :author => "Author #{i}", :blog_post => @blog_post)
        end
      end

      context 'and get the index' do
        setup do 
          get :index, :blog_post_id => @blog_post.id
        end
        should_render_template :index
      end

      context 'and get the edit' do
        setup do
          get :edit, :id => @blog_comments.first, :blog_post_id => @blog_post.id
        end
        should_render_template :edit
      end

      context 'and update the specific comment' do
        context 'with valid data' do
          setup do
            BlogComment.any_instance.stubs(:valid?).returns(true)
            put :update, :id => @blog_comments.first, :blog_post_id => @blog_post.id, :blog_comment => {}
          end
          should_redirect_to('list of blog_comments') { admin_blog_post_blog_comments_path(@blog_post) }
        end

        context 'with invalid data' do
          setup do
            BlogComment.any_instance.stubs(:valid?).returns(false)
            put :update, :id => @blog_comments.first, :blog_post_id => @blog_post.id, :blog_comment => {}
          end
          should_render_template :edit
        end
      end

      context 'and get the new' do
        setup do
          get :new, :blog_post_id => @blog_post.id 
        end
        should_render_template :new
      end

      context 'and create a new comment' do
        context 'with valid data' do
          setup do
            BlogComment.any_instance.stubs(:valid?).returns(true)
            post :create, :id => @blog_comments.first, :blog_post_id => @blog_post.id, :blog_comment => {}
          end
          should_redirect_to('list of blog_comments') { admin_blog_post_blog_comments_path(@blog_post) }
        end

        context 'with invalid data' do
          setup do
            BlogComment.any_instance.stubs(:valid?).returns(false)
            post :create, :id => @blog_comments.first, :blog_post_id => @blog_post.id, :blog_comment => {}
          end
          should_render_template :new
        end
      end

      context 'and destroy a comment' do
        setup do
          delete :destroy, :id => @blog_comments.first, :blog_post_id => @blog_post.id
        end
        should_change "BlogComment.count", :by => -1
      end
    end
  end
end
