require 'test_helper'

class BlogCommentsControllerTest < ActionController::TestCase
  context "with a BlogComment in Database" do
    setup do
      Factory(:blog_comment)
    end

    context "index action" do
      should "render index template" do
        get :index
        assert_template 'index'
      end
    end
    
    context "show action" do
      should "render show template" do
        get :show, :id => BlogComment.first
        assert_template 'show'
      end
    end
    
    context "new action" do
      should "render new template" do
        get :new
        assert_template 'new'
      end
    end
    
    context "create action" do
      should "render new template when model is invalid" do
        BlogComment.any_instance.stubs(:valid?).returns(false)
        post :create
        assert_template 'new'
      end
      
      should "redirect when model is valid" do
        BlogComment.any_instance.stubs(:valid?).returns(true)
        post :create
        assert_redirected_to blog_comment_url(assigns(:blog_comment))
      end
    end
    
    context "edit action" do
      should "render edit template" do
        get :edit, :id => BlogComment.first
        assert_template 'edit'
      end
    end
    
    context "update action" do
      should "render edit template when model is invalid" do
        BlogComment.any_instance.stubs(:valid?).returns(false)
        put :update, :id => BlogComment.first
        assert_template 'edit'
      end
    
      should "redirect when model is valid" do
        BlogComment.any_instance.stubs(:valid?).returns(true)
        put :update, :id => BlogComment.first
        assert_redirected_to blog_comment_url(assigns(:blog_comment))
      end
    end
    
    context "destroy action" do
      should "destroy model and redirect to index action" do
        blog_comment = BlogComment.first
        delete :destroy, :id => blog_comment
        assert_redirected_to blog_comments_url
        assert !BlogComment.exists?(blog_comment.id)
      end
    end
  end
end
