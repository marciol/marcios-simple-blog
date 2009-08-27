require 'test_helper'

class Admin::BlogPostsControllerTest < ActionController::TestCase
  context 'logged as admin' do
    setup do
      activate_authlogic
      UserSession.create(Factory(:admin))
    end

    context 'and with some News Posts in the database' do
      setup do
        @blog_post = Factory(:blog_post) 
      end

      context 'and get the index' do
        setup do
          get :index
        end
        should_render_template :index
      end

      context 'and get the edit' do
        setup do
          get :edit, :id => @blog_post
        end
        should_render_template :edit
      end

      context 'and submiting update for a specific News Post' do
        context 'with valid data' do
          setup do
            put :update, :id => @blog_post, :blog_post => Factory.attributes_for(:blog_post)
          end
          should_redirect_to('list of News Posts'){ admin_blog_posts_path }
        end

        context 'with invalid data' do
          setup do
            BlogPost.any_instance.stubs(:valid?).returns(false)
            put :update, :id => @blog_post 
          end
          should_render_template :edit
        end
      end
      
      context 'and get the new' do
        setup do
          get :new 
        end
        should_render_template :new
      end

      context 'and submiting create for a specific News Post' do
        context 'with valid data' do
          setup do
            post :create, :blog_post => Factory.attributes_for(:blog_post)
          end
          should_redirect_to('list of News Posts'){ admin_blog_posts_path }
        end

        context 'with invalid data' do
          setup do
            BlogPost.any_instance.stubs(:valid?).returns(false)
            post :create
          end
          should_render_template :new
        end
      end
      
      context 'and destroying  specific News Post' do
        setup do
          delete :destroy, :id => @blog_post
        end
        should_change 'BlogPost.count', :by => -1
      end

      context 'and get the reorder page' do
        setup do
          get :reorder
        end
        should_render_template :reorder
      end
    end
  end
end
