class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :item
  after_create :create_coupon
  
  #has_many :reviews

  validates_presence_of :status

  def create_coupon

    @coupon = Coupon.new
    @coupon.user_id = @current_user
    @coupon.ownerId = self.item.user.id
    @coupon.amazon = self.item.amazon
    @coupon.save!
  end
end
