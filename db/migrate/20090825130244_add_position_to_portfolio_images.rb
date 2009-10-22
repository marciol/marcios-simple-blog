class AddPositionToPortfolioImages < ActiveRecord::Migration
  def self.up
    add_column :portfolio_images, :position, :integer
  end

  def self.down
    remove_column :portfolio_images, :position
  end
end
