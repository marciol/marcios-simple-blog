class BlogPost < ActiveRecord::Base

  Per_Page = 5

  acts_as_seo
  acts_as_taggable_on :tags

  belongs_to :news_category
  has_many :blog_comments

  validates_presence_of :name

  has_permalink :name, :update => true

  default_scope :order => 'created_at DESC'

  def self.list(options = {})
    from, to = self.time_delta(options.delete(:year), options.delete(:month), options.delete(:day))
    options[:conditions] = ["created_at BETWEEN ? AND ?", from, to]
    all_or_paginate(options)
  end

  def self.search(query, options = {})
    name, content = (1..2).map{"%#{query}%"}
    options[:conditions] = ["name LIKE ? OR content LIKE ?", name, content]
    all_or_paginate(options)
  end

  def self.all_from_tag(tag, options = {})
    from_tag = tagged_with(tag, :on => :tags)
    prepare_pagination_options(options)
    from_tag.paginate options rescue from_tag 
  end


  private

  def self.prepare_pagination_options(options)
    options.delete_if{ |key, value| value.nil? }
    options.reverse_merge!(:page => 1, :per_page => Per_Page) if respond_to? :paginate
  end

  def self.all_or_paginate(options = {})
    prepare_pagination_options(options)
    paginate options rescue all options
  end

  def self.time_delta(year, month = nil, day = nil)
    if year
      from = Time.mktime(year, month || 1, day || 1)

      to = from + 1.year
      to = from + 1.month unless month.blank?
      to = from + 1.day   unless day.blank?
      return [from, to]
    else
      return [DateTime.now.at_beginning_of_month, DateTime.now.at_end_of_month]
    end
  end
end

