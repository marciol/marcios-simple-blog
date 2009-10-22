class PortfolioImagesController < ApplicationController
  def index
    @portfolio_images = PortfolioImage.all
    @metatag_object = Page.find_by_permalink('portfolio')
  end
end
