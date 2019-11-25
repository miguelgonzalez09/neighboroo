class Item < ApplicationRecord
  include AlgoliaSearch
  mount_uploader :photo, PhotoUploader

  belongs_to :user

  validates_presence_of :photo, message: 'please :)'
  validates_presence_of :name, message: 'please :) No nameless items allowed!'
  validates_presence_of :address, message: 'please :)'

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  algoliasearch do
    attributes :name, :address
    searchableAttributes ['name', 'address']
  end
end
