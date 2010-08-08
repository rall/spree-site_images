map.namespace :admin do |admin|
  admin.resources :site_images, :only => [:index, :new, :create, :destroy]
end
