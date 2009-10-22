class Admin::PortfolioImagesController < Admin::AdminController
  
  def create
    @portfolio_image = PortfolioImage.new params[:portfolio_image]
    if @portfolio_image.download_image_and_save
      redirect_to collection_url
      flash[:notice] = I18n.t(:success_create)
    else
      render :new
    end
  end

  def update
    @portfolio_image = PortfolioImage.find params[:id]
    @portfolio_image.name = params[:portfolio_image][:name]
    @portfolio_image.website_url = params[:portfolio_image][:website_url]
    @portfolio_image.description = params[:portfolio_image][:description]
    if @portfolio_image.download_image_and_save
      redirect_to collection_url
      flash[:notice] = I18n.t(:success_update)
    else
      render :edit
    end
  end
  
  include Order

end
