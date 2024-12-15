class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new,:create]
  
  def index
    @items = Item.all
  end

  def new
    @item =Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:name,:image,:description,:category_id,:status_id,:ship_fee_id,:ship_region_id,:ship_wait_id,:price).merge(user_id: current_user.id)
  end
end
