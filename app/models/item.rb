class Item < ApplicationRecord
  mount_uploader :photo, PhotoUploader
  belongs_to :user
  mount_uploader :photo, PhotoUploader

  #validates_presence_of :photo, message: 'please :)'
  validates_presence_of :name, message: 'please :) No nameless items allowed!'
  validates_presence_of :address, message: 'please :)'

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
