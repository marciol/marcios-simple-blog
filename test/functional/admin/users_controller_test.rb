require 'test_helper'

class Admin::UsersControllerTest < ActionController::TestCase

  def setup
    @controller = Admin::UsersController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    @user = Factory(:user)
  end

  context "An admin accessing" do
    setup do
      activate_authlogic
      UserSession.create(Factory(:admin))
    end

    context "List of users" do
      setup do
        get :index
      end
      should_render_template :index
    end

    context "New" do
      setup do
        get :new
      end
      should_render_template :new
    end

    context "Create" do

      context "an invalid user" do
        setup do
          User.any_instance.stubs(:valid?).returns(false)
          post :create
        end
        should_render_template :new
      end

      context "a valid user" do
        setup do
          User.any_instance.stubs(:valid?).returns(true)
          post :create
        end
        should_redirect_to("list of users") { admin_users_path }
      end
    end

    context "edit" do
      setup do
        get :edit, :id => User.first
      end
      should_render_template :edit
    end

    context "Update" do

      context "an invalid user" do
        setup do
          User.any_instance.stubs(:valid?).returns(false)
          post :update, :id => User.first
        end
        should_render_template "edit"
      end

      context "a valid user" do
        setup do
          User.any_instance.stubs(:valid?).returns(true)
          post :update, :id => User.first
        end
        should_redirect_to("list of users") { admin_users_path }
      end
    end
  end
  
end
