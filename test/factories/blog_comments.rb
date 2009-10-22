Factory.define(:blog_comment) do |f|
  f.sequence(:author){|n| "Author #{n}" }
  f.sequence(:email){|n| "email_#{n}@email.com" }
  f.sequence(:content){|n| "Comment Content #{n}" }
end
