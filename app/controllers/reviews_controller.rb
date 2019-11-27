class ReviewsController < ApplicationController
    def index
      @user = current_user
      @reviews = policy_scope(Review).order(created_at: :desc)
      @reviewsReceived = Review.joins(:booking).where("bookings.user_id= ?", current_user).order(created_at: :desc)
    end

    def create
      @review = Review.new(review_params)
      @review.user = current_user
      @review.booking = Booking.find(params[:booking_id])
      if @review.save
        redirect_to reviews_path
      else
        @user = current_user
        @reviews = policy_scope(Review).order(created_at: :desc)
        @reviewsReceived = Review.joins(:booking).where("bookings.user_id= ?", current_user).order(created_at: :desc)
        @bookings = Booking.all
        @bookingsReceived = Booking.joins(:item).where("items.user_id= ?", current_user)
        render "bookings/index"
      end
      authorize @review
    end

    def destroy
      @review = Review.find(params[:review_id])
      @review.destroy
      redirect_to reviews_path
      authorize @review
    end


    def review_params
      params.require(:review).permit(:body, :user_id, :rating, :booking_id)
    end
  end
