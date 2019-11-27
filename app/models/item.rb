class Item < ApplicationRecord
  include AlgoliaSearch
  mount_uploader :photo, PhotoUploader

  belongs_to :user
  has_many :bookings, dependent: :destroy

  validates_presence_of :photo, message: 'please :)'
  validates_presence_of :name, message: 'please :) No nameless items allowed!'
  validates_presence_of :address, message: 'please :)'


  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  algoliasearch do
    attributes :name, :address, :description
    searchableAttributes ['name', 'address','description']
  end

  # def self.geocoded(items)
  #   items.map do |item|
  #     {
  #       lat: item.latitude,
  #       lng: item.longitude,
  #       infoWindow: render_to_string(partial: "views/shared/info_window", locals: { item: item })
  #     }
  #   end
  # end
end
