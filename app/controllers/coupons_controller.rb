class CouponsController < ApplicationController

    def index 
        @user = current_user
        @coupons = policy_scope(Booking).order(created_at: :desc)
    end

    def create
        authorize @coupon
    end 
end
