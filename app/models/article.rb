class Article < ApplicationRecord
 belongs_to :listing

 mount_uploader :video, VideoUploader
 validates :video, :presence => true
end
