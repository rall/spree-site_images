class FileStoreHooks < Spree::ThemeSupport::HookListener
  insert_after :admin_tabs do
    %(<%=  tab(:file_store, :label => 'file_store', :route => 'admin_uploaded_files')  %>)
  end
end

