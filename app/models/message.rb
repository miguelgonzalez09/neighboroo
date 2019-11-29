class Message < ApplicationRecord
  belongs_to :user
  belongs_to :receiver, class_name: "User", foreign_key: :receiver_id
  belongs_to :item

  validates_presence_of :body
end
