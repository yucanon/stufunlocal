class Listing < ApplicationRecord
  belongs_to :user, autosave: true
  has_many :photos
  has_many :articles
  has_many :charges
  has_many :reservations
  has_many :reviews

  geocoded_by :address
  after_validation :geocode, :if => :address_changed?

  default_scope { order(:created_at) }

  before_create do
   self.id = user.id
  end

  def average_star_rate
    reviews.count == 0 ? 0 : reviews.average(:rate).round(1)
  end

  mount_uploader :video, VideoUploader
  mount_uploader :image, ImageUploader
  
end
