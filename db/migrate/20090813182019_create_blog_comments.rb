class CreateBlogComments < ActiveRecord::Migration
  def self.up
    create_table :blog_comments do |t|
      t.string :author
      t.string :email
      t.string :website
      t.text :content
      t.integer :position
      t.references :blog_post
      t.timestamps
    end
  end
  
  def self.down
    drop_table :blog_comments
  end
end
