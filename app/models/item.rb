class Item < ApplicationRecord
  belongs_to :user

  validates_presence_of :photo, message: 'please :)'
  validates_presence_of :name, message: 'please :) No nameless items allowed!'
  validates_presence_of :address, message: 'please :)'
end
