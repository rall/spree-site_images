class SiteImagesHooks < Spree::ThemeSupport::HookListener
  insert_after :admin_tabs do
    %(<%=  tab(:images, :label => 'site_images', :route => 'admin_site_images')  %>)
  end
end

