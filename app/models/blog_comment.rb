class BlogComment < ActiveRecord::Base
  belongs_to :blog_post

  validates_presence_of :author
  validates_presence_of :email
  validates_presence_of :content
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i 
  validates_format_of :website, :with => /^http:\/\/.*/, :allow_blank => true, :live_validator => /.?/
end
