class BookingsController < ApplicationController
  def index
    @user = current_user
    @review = Review.new
    @bookings = policy_scope(Booking).order(created_at: :desc)
    @bookingsReceived = Booking.joins(:item).where("items.user_id= ?", current_user)

  end

  def create

    @booking = Booking.new
    @booking.user = current_user
    @booking.item_id = booking_params[:item_id]
    @booking.status = 2
    @booking.date = booking_params[:date]
    @booking.save!
    redirect_to bookings_path
    authorize @booking
  end

  def destroy
    @booking = Booking.find(params[:booking_id])
    @booking.destroy
    redirect_to bookings_path
    authorize @booking
  end

  def update
    @booking = Booking.find(params[:booking_id])
    @booking.status = params[:status_id]
    @booking.save
    authorize @booking
    redirect_to bookings_path
  end

  def booking_params
    params.require(:booking).permit(:item_id, :user_id, :status, :date)
  end
end
