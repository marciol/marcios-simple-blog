class PagesController < ApplicationController
  
  def index
    @pages = Page.main_pages
  end
  
  def contact
    @page = Page.find_by_permalink('contact')
    if request.post?
      Mailer.deliver_contact(params[:contact])
      flash[:notice] = 'Your message was sent.'
    end
  end

  def method_missing(method, *args)
    @page = Page.find_by_permalink(method) || Page.page_not_found
    @pages = @page.children
    render :action => method.methodize
    rescue
      render :action => 'show'
  end

end
