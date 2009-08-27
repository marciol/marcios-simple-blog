ActionController::Routing::Routes.draw do |map|

  map.namespace :admin do |admin|
    admin.login 'login', :controller => "user_sessions", :action => "new"
    admin.logout 'logout', :controller => "user_sessions", :action => "destroy"
    admin.resource :user_session
    admin.resources :pages, :collection=>{ :reorder=>:get, :order=>:post }
    admin.resources :users
    admin.resources :blog_posts, :collection => {:reorder => :get, :order => :post }, :has_many => :blog_comments
    admin.resources :portfolio_images, :collection =>{:reorder => :get, :order => :post}
    admin.root :controller => 'pages'
  end

  map.resources :portfolio_images, :as => :portfolio
  map.resources :blog_comments
  map.tags 'blog_posts/tags/:tag', :controller => 'blog_posts', :action => 'tags'
  map.resources :blog_posts, :collection => {:search => :post}, :has_many => :blog_comments, :as => :blog
  map.pages '/pages/:action', :controller => 'pages'
  map.resources :pages

  map.not_found '/404', :controller => 'pages', :action => '404'
  map.application_error '/500', :controller => 'pages', :action => '500'
  map.unprocessable_entity '/422', :controller => 'pages', :action => '422'
  map.root :controller => 'blog_posts', :action => 'index'
  
end

