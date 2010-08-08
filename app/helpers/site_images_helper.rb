module SiteImagesHelper
  def site_image_tag(pos, opts = {})
    position = pos.to_s
    if PAGE_POSITIONS.has_key?(position) && (site_image = SiteImage.in_position(position).first)
      image_tag(site_image.attachment.url(position), opts)
    else
      image_tag("default_images/#{position}_image.png", opts)
    end
  end
end