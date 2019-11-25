class Message < ApplicationRecord
  belongs_to :user
  belongs_to :item

  validates_presence_of :body
end
