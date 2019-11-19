class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    @items = policy_scope(Item).order(created_at: :desc)

  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def plant_params
    params.require(:item).permit(:name, :description, :address, :photo, :latitude, :longitude)
  end
end
