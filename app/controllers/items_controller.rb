class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new,:create,:edit,:update]
  before_action :correct_user, only: [:edit, :update]
  before_action :set_items, only: [:edit,:show, :update]
  

  def index
    @items = Item.all.order(created_at: :DESC)
  end

  def new
    @item =Item.new
  end

  def show
  end

  def edit
  end

  def update
    if @items.update(item_params)
     redirect_to item_path(@items.id)
     else
     render action: :edit, status: :unprocessable_entity
   end
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

  def correct_user
    @items = Item.find(params[:id])
    return if current_user.id == @items.user_id
    redirect_to root_path
  end

  def set_items
    @items = Item.find(params[:id])
  end

end
