class AddAttachmentsScreenshotToPortfolioImage < ActiveRecord::Migration
  def self.up
    add_column :portfolio_images, :screenshot_file_name, :string
    add_column :portfolio_images, :screenshot_content_type, :string
    add_column :portfolio_images, :screenshot_file_size, :integer
    add_column :portfolio_images, :screenshot_updated_at, :datetime
  end

  def self.down
    remove_column :portfolio_images, :screenshot_file_name
    remove_column :portfolio_images, :screenshot_content_type
    remove_column :portfolio_images, :screenshot_file_size
    remove_column :portfolio_images, :screenshot_updated_at
  end
end
