class BuysController < ApplicationController
  before_action :set_items, only: [:index,:create]
  before_action :move_to_index, only:[:index]
  before_action :prevent_url, only: [:index, :create]

  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @buy_form = BuyForm.new
  end

  def new
    @buy_form = BuyForm.new
  end

  def create
    @buy_form =BuyForm.new(buy_params)
    if @buy_form.valid?
      pay_item
      @buy_form.save
      redirect_to root_path
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      render :index, status: :unprocessable_entity
    end
  end

  private

  def buy_params
    params.require(:buy_form).permit(:post_number, :ship_region_id, :city, :house_number, :building_name, :phone_number)
    .merge(user_id: current_user.id, item_id: params[:item_id],token: params[:token])
  end

  def set_items
    @items = Item.find(params[:item_id])
  end

  def pay_item
    #@items = Item.find(params[:id])
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @items.price,        # 商品の値段
      card: buy_params[:token], # カードトークン
      currency: 'jpy'             # 通貨の種類（日本円）
    )
  end

  def prevent_url
    if @items.user_id == current_user.id || @items.buy != nil
      redirect_to root_path
     end
  end

  def move_to_index
   unless user_signed_in?
    redirect_to root_path
   end
  end
end
