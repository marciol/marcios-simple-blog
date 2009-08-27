class CreateBlogPosts < ActiveRecord::Migration
  def self.up
    create_table :blog_posts do |t|
      t.string :name
      t.string :permalink
      t.text :content
      t.boolean :is_protected, :default => false, :null => false
      t.boolean :allow_comments, :default => true, :null => false
      t.integer :position
      t.timestamps
    end
  end
  
  def self.down
    drop_table :blog_posts
  end
end
