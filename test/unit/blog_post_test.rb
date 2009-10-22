require 'test_helper'

class BlogPostTest < ActiveSupport::TestCase
  context 'with a blogpost in database' do
    setup do
      Factory(:blog_post)
    end
    should_validate_presence_of :name
    should_have_many :blog_comments
    should_have_class_methods :list
  end

  context 'with some blog_posts in database with diferent names and contents' do
    setup do
      @foo_post = Factory(:blog_post, :name => 'foo foo', :content => 'Foo Blog Post Content')
      @bar_post = Factory(:blog_post, :name => 'bar bar', :content => 'Bar Blog Post Content')
      @foo_bar = Factory(:blog_post, :name => 'foo bar', :content => 'Foo Bar Blog Post Content')
    end

    should 'find the exactly the posts with the name or content that match' do
      assert BlogPost.search('foo').include?(@foo_post)
      assert BlogPost.search('bar').include?(@bar_post)
    end
  end

  context 'with the list of blog_posts in database from diferent dates being' do
    context 'posts from diferent years' do
      setup do
        @past_year, @current_year = (1..2).map{ Hash.new [] }
        3.times {@past_year[:created] << Factory(:blog_post, :created_at => 1.year.ago, :name => 1.year.ago.year)}
        3.times {@current_year[:created] << Factory(:blog_post, :name => DateTime.current.year)}
        @past_year[:finded] = BlogPost.list :year => 1.year.ago.year
        @current_year[:finded] = BlogPost.list :year => DateTime.current.year
      end
      should "find the objects match the year" do
        assert_equal @past_year[:current], @past_year[:finded]
        assert_equal @current_year[:current], @current_year[:finded]
      end
    end

    context 'posts from the diferent months' do
      setup do
        @past_month, @current_month = (1..2).map{ Hash.new [] }
        3.times {|i| @past_month[:created] << Factory(:blog_post, :created_at => 1.month.ago + i.minute)}
        3.times {|i| @current_month[:created] << Factory(:blog_post, :name => DateTime.current.month, :created_at => DateTime.current + i.minute )}
        @past_month[:finded] = BlogPost.list :year => DateTime.current.year, :month => 1.month.ago.month
        @current_month[:finded] = BlogPost.list :year => DateTime.current.year, :month => DateTime.current.month
      end
      should "find the objects match the month" do
        assert_equal @past_month[:current].reverse, @past_month[:finded]
        assert_equal @current_month[:current].reverse, @current_month[:finded]
      end
    end

    context 'posts from diferent days' do
      setup do
        @past_day, @current_day = (1..2).map{ Hash.new [] }
        3.times {|i| @past_day[:created] << Factory(:blog_post, :created_at => 1.day.ago + i.minute, :name => 1.day.ago.day)}
        3.times {|i| @current_day[:created] << Factory(:blog_post, :created_at => DateTime.current + i.minute, :name => DateTime.current.day)}
        @past_day[:finded] = BlogPost.list :year => DateTime.current.year, :month => DateTime.current.month, :day => 1.day.ago.day
        @current_day[:finded] = BlogPost.list :year => DateTime.current.year, :month => DateTime.current.month, :day => DateTime.current.day
      end
      should "find the objects match the day" do
        assert_equal @past_day[:current].reverse, @past_day[:finded]
        assert_equal @current_day[:current].reverse, @current_day[:finded]
      end
    end

    context 'without year' do
      setup do
        @current_month_objects = [DateTime.current.at_beginning_of_month, DateTime.current.at_end_of_month].map{|time| Factory(:blog_post, :created_at => time)}
        @past_month_objects = (1..2).map{ Factory(:blog_post, :created_at => 1.month.ago) }
        @finded_objects = BlogPost.list
      end
      should "find the objects of current month" do
        assert_equal @current_month_objects.reverse, @finded_objects
        assert_not_equal @past_month_objects, @finded_objects
      end
    end
  end

  context 'testing pagination of method list' do
    context 'with setting per page' do
      setup do
        10.times{ Factory(:blog_post) }
        @finded_objects = BlogPost.list
      end
      should "take only 5 objects" do
        assert_equal 5, @finded_objects.size
      end
    end

    context 'with custom per page' do
      setup do
        10.times{ Factory(:blog_post) }
        @finded_objects = BlogPost.list :per_page => 6
      end
      should "take only 6 objects" do
        assert_equal 6, @finded_objects.size
      end
    end
  end
end

