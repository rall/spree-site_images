class SiteImage < Image
  set_table_name :assets
   
  has_attached_file :attachment, 
                    :styles => lambda {
                      PAGE_POSITIONS.inject({}) do |memo, position|
                      memo.merge(position.first.to_sym => position.last["size"])
                      end.reverse_merge(:mini => '48x48>')
                    }, 
                    :default_style => :page,
                    :url => "/assets/site/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/site/:id/:style/:basename.:extension"
  
end
