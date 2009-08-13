require 'test_helper'

class Admin::PagesControllerTest < ActionController::TestCase

  def setup
    @controller = Admin::PagesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  context "An admin accessing" do
    setup do
      activate_authlogic
      UserSession.create(Factory(:admin))
    end

    context "the list of pages" do

      context "in HTML" do
        setup do
          get :index
        end

        should_render_template :index
        should_respond_with_content_type :html
      end

      context "via Ajax" do
        setup do
          @page = Factory.create(:about)
          @child = Factory.create(:about_child)
          get :index, :format => 'js'
        end

        should_render_template :index
        should_respond_with_content_type :js
      end

    end

    context "the form for new page" do
      setup do
        get :new
      end
      should_render_template :new
    end

    context "creating" do
      context "an invalid page" do
        setup do
          Page.any_instance.stubs(:valid?).returns(false)
          post :create
        end
        should_render_template :new
      end

      context "a valid page" do
        setup do
          Page.any_instance.stubs(:valid?).returns(true)
          post :create
        end
        should_redirect_to("list of pages") { admin_pages_path }
      end
    end

    context "editing a page" do
      setup do
        get :edit, :id => Factory(:about)
      end
      should_render_template :edit
    end

    context "updating" do
      context "an invalid page" do
        setup do
          page = Factory(:page)
          Page.any_instance.stubs(:valid?).returns(false)
          post :update, :id => Page.first
        end
        should_render_template "edit"
      end

      context "a valid page" do
        setup do
          Page.any_instance.stubs(:valid?).returns(true)
          post :update, :id => Factory(:page)
        end
        should_redirect_to("list of pages") { admin_pages_path }
      end
    end

    context "reordering" do
      context "the main pages" do
        setup do
          get :reorder
        end
        should_assign_to(:items) { Page.main_pages }
        should_render_template :reorder
      end

      context "page children" do
        setup do
          @page = Factory(:about)
          get :reorder, :parent_id => @page.id
        end
        should_assign_to(:items) { @page.pages }
        should_render_template :reorder
      end

      context "pages and saving" do
        setup do
          post :order, :order => []
        end
        should_render_without_layout
      end
    end
  end
  


end
