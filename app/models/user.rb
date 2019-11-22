class User < ApplicationRecord
  mount_uploader :photo, PhotoUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  has_many :messages
  has_many :items, through: :bookings
  has_many :items, through: :messages

  def incoming_bookings
    bookings = []
    self.items.each do |item|
      bookings.push(item.bookings)
    end
    bookings
  end

  def incoming_messages
    messages = []
    self.items.each do |item|
      messages.push(item.messages)
    end
    messages
  end
end
