class BookingsController < ApplicationController
  def index
    @user = current_user
    @review = Review.new
    @bookings = policy_scope(Booking).order(created_at: :asc)
    @bookingsReceived = Booking.joins(:item).where("items.user_id= ?", current_user)
  end

  def create
    @booking = Booking.new
    @booking.user = current_user
    @booking.item = Item.find(params[:item_id])
    @booking.status = 2
    puts '**********************************'
    puts params[:start_date]
    puts '**********************************'
    # @booking.start_date = params[:start_date]
    # @booking.end_date = params[:end_date]
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
    params.require(:booking).permit(:item_id, :user_id, :status)
  end
end
