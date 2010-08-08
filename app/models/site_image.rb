class SiteImage < Asset
  validates_uniqueness_of :page_position, :allow_nil => true, :allow_blank => true
  
  has_attached_file :attachment, 
                    :styles => PAGE_POSITIONS.symbolize_keys.reverse_merge(:mini => '48x48>'), 
                    :default_style => :site_image,
                    :url => "/assets/site/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/site_images/:id/:style/:basename.:extension",
                    :storage => "s3",
                    :s3_credentials => {
                      :access_key_id => ENV['S3_KEY']  || HEROKU_AWS_S3['access_key_id'],
                      :secret_access_key => ENV['S3_SECRET'] || HEROKU_AWS_S3['secret_access_key']
                    },
                    :bucket => ENV['S3_BUCKET'] || HEROKU_AWS_S3['bucket']
                    
  # save the w,h of the original image (from which others can be calculated)
  # we need to look at the write-queue for images which have not been saved yet
  after_post_process :find_dimensions
  
  named_scope :in_position, lambda { |page_position| 
    { :conditions => { :page_position => page_position } } 
  }

  def find_dimensions
    temporary = attachment.queued_for_write[:original] 
    filename = temporary.path unless temporary.nil?
    filename = attachment.path if filename.blank?
    geometry = Paperclip::Geometry.from_file(filename)
    self.attachment_width  = geometry.width
    self.attachment_height = geometry.height
  end

  # if there are errors from the plugin, then add a more meaningful message
  def validate
    unless attachment.errors.empty?
      # uncomment this to get rid of the less-than-useful interrim messages
      # errors.clear 
      errors.add :attachment, "Paperclip returned errors for file '#{attachment_file_name}' - check ImageMagick installation or image source file."
      false
    end
  end
  
  # maintain one page iomage per position constarint here
  def page_position=(new_page_position)
    SiteImage.in_position(new_page_position).update_all :page_position => nil
    self.write_attribute(:page_position, new_page_position)
    self.save!
  end
  
  private
  
  def self.select_options
    PAGE_POSITIONS.keys.map do |key|
      [I18n.t(key), key]
    end
  end
end
