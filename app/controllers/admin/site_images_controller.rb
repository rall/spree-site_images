class Admin::SiteImagesController < Admin::ImagesController
  skip_before_filter :load_data
  
  create.response do |wants|
    wants.html {redirect_to admin_site_images_url}
  end

  update.response do |wants|
    wants.html {redirect_to admin_site_images_url}
  end
  
  index.before do
    @site_images = SiteImage.find :all
  end
  
  private
  #undefine these viewable-specific methods
  def set_viewable
  end

  def destroy_before 
  end
  
end
