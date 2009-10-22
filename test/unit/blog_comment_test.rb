require 'test_helper'

class BlogCommentTest < ActiveSupport::TestCase
  context 'with one comment in the database' do
    setup do
      Factory(:blog_comment)
    end
    should_validate_presence_of :author
    should_validate_presence_of :email
    should_not_allow_values_for :email, 'bla', 'bla@', 'bla@bla'
    should_not_allow_values_for :website, 'www.bla.com'
    should_validate_presence_of :content
    should_belong_to :blog_post
  end
end
