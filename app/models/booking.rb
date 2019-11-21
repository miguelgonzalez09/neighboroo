class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :item

  validates_presence_of :status
end
