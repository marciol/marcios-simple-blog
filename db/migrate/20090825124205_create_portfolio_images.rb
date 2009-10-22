class CreatePortfolioImages < ActiveRecord::Migration
  def self.up
    create_table :portfolio_images do |t|
      t.string :name
      t.string :website_url
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :portfolio_images
  end
end
