atom_feed :language => I18n.locale do |feed|
 feed.title('ArtePrograma-blog')
 feed.updated(@blog_posts.first.try(:created_at))

 @blog_posts.each do |post|
   feed.entry(post, {:url => blog_post_path(post)}) do |entry|
     entry.title(post.name)
     entry.content(post.content, :type => 'html')
     entry.author do |author|
       author.name "Marcio Lopes de Faria"
     end
   end
 end
end
