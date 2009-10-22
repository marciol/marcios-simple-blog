Factory.define(:blog_post) do |f|
  f.sequence(:name){|n| "Post #{n}" }
  f.sequence(:content){|n| "Content #{n}" }
end
