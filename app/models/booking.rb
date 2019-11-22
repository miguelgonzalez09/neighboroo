class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :item
  #has_many :reviews

  validates_presence_of :status
end
