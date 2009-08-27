class PortfolioImage < ActiveRecord::Base
  attr_accessor :remote_image_file

  include Simplificator::Webthumb

  has_attached_file :screenshot,
                    :styles => { :thumb => ["200x200", :jpg], :medium => ["400x400", :jpg] },
                    :path => ":rails_root/public/system/:class/:id/:style/:websitename.jpg",
                    :url => "/system/:class/:id/:style/:websitename.jpg",
                    :default_url => ""

  validates_format_of :website_url, :with => /^http:\/\/.*$/, :message => "Deve conter o protocolo na url"

  validates_presence_of :name, :description

#  before_save :download_remote_image

#  after_save :remove_remote_image_file

private

  def image_url_provided?
    !self.website_url.blank?
  end

  def download_remote_image
    wt = Webthumb.new('6b066711a69ffc7cd435eb2261f1fed0')
    job = wt.thumbnail(:url => website_url)
    self.remote_image_file = Tempfile.new('temp_thumb', RAILS_ROOT + '/tmp')
    self.remote_image_file.write(job.fetch_when_complete(:large))
    self.screenshot = self.remote_image_file 
  end

  def remove_remote_image_file
    remote_image_file.close! 
  end

end

