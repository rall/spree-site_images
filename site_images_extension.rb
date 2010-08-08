# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class SiteImagesExtension < Spree::Extension
  version "1.0"
  description "Describe your extension here"
  url "http://yourwebsite.com/site_images"

  # Please use site_images/config/routes.rb instead for extension routes.

  # def self.require_gems(config)
  #   config.gem "gemname-goes-here", :version => '1.2.3'
  # end
  
  def activate
    PAGE_POSITIONS = YAML.load(SiteImageExtension.root.join("config", "page_positions.yml"))
  end
end
