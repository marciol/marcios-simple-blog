class Admin::BlogCommentsController < Admin::AdminController
  
  belongs_to :blog_post
  
  create.wants.html {redirect_to(admin_blog_post_blog_comments_path(parent_object))}
  update.wants.html {redirect_to(admin_blog_post_blog_comments_path(parent_object))}
  
end
