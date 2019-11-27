class Review < ApplicationRecord
    belongs_to :user
    belongs_to :booking

    validates_presence_of :rating
end
