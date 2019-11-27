class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy, :request_item]

  def index
    @items = policy_scope(Item).order(created_at: :asc)

    if params[:query].present?
      sql_query = " \
        name ILIKE :query \
        OR description ILIKE :query \
        OR address ILIKE :query \
      "
      @items = Item.where(sql_query, query: "%#{params[:query]}%")
    else
      @items = Item.all
    end

    # @markers = Item.geocoded(@items)
    @items = @items.geocoded
    @markers = @items.map do |item|
      {
        lat: item.latitude,
        lng: item.longitude,
        infoWindow: render_to_string(partial: "/shared/info_window", locals: { item: item })
      }
    end
  end

  def show
    @booking = Booking.new

    @markers =[ {
        lat: @item.latitude,
        lng: @item.longitude,
        infoWindow: render_to_string(partial: "/shared/info_window", locals: { item: @item })
      }]

    authorize @item
  end

  def new
    @user = current_user
    @item = Item.new
    @items = Item.all
    authorize @item
  end

  def create
    @item = Item.new(item_params)
    @item.user = current_user
    if @item.save
      redirect_to your_items_path
    else
      @items = Item.all
      render :new
    end
    authorize @item
  end

  def edit
    @user = current_user
    @items = Item.all
    authorize @item
  end

  def update
    @item.update!(item_params)
    redirect_to item_path
    authorize @item
  end

  def destroy
    @item.destroy
    redirect_to your_items_path
    authorize @item
  end

  def user_items
    @user = current_user
    @items = Item.all
    authorize @items
  end

  def request_item
    @message = Message.new
    @user = current_user
    authorize @item

    @markers =[ {
      lat: @item.latitude,
      lng: @item.longitude,
      infoWindow: render_to_string(partial: "/shared/info_window", locals: { item: @item })
    }]
  end


  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :address, :photo, :latitude, :longitude)
  end
end
