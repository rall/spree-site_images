class UploadedFile < ActiveRecord::Base
  has_attachment :storage => "s3",
                 :path => "assets/products/:id/:style/:basename.:extension",
                 :s3_credentials => {
                   :access_key_id => ENV['S3_KEY']  || HEROKU_AWS_S3['access_key_id'],
                   :secret_access_key => ENV['S3_SECRET'] || HEROKU_AWS_S3['secret_access_key']
                  },
                  :bucket => ENV['S3_BUCKET'] || HEROKU_AWS_S3['bucket']

  named_scope :default_order, :order => 'created_at DESC'

  validates_presence_of :filename

  cattr_reader :per_page
  @@per_page = 20
end
