class Admin::SiteImagesController < Admin::BaseController
  resource_controller
  
  new_action.response do |wants|
    wants.html {render :action => :new, :layout => false}
  end

  create.response do |wants|
    wants.html {redirect_to admin_site_images_url}
  end

  update.response do |wants|
    wants.html {redirect_to admin_site_images_url}
  end
  
  destroy.response do |wants| 
    wants.html do
      render :text => ""
    end
  end
end
