class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy, :request_item]

  def index
    @items = policy_scope(Item).order(created_at: :asc)

    if params[:query].present?
      @items = Item.where(name: params[:query])
    else
      @items = Item.all
    end

    @g_items = Item.geocoded #returns flats with coordinates

    @markers = @g_items.map do |item|
      {
        lat: item.latitude,
        lng: item.longitude,
        #infoWindow: render_to_string(partial: "shared/info_window", locals: { item: item })
      }
    end
  end

  def show
    @message = Message.new
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
    redirect_to your_items_path
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
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :address, :photo, :latitude, :longitude)
  end
end
