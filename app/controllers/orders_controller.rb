# # COMMENTED OUTED

class OrdersController < ApplicationController
  def index
    @order = Order.new
  end

  def new
    @order = Order.new
    @item = Item.find(params[:item_id])
  end

  def create
    # Uncomment and adjust order_params as needed
    @order = Order.new(order_params)
    if @order.valid?
      # Uncomment and adjust the payment processing code (pay_item) as needed
      # pay_item
      @order.save
      redirect_to root_path, notice: 'Order was successfully created.'
    else
      render 'new'
    end
  end

  private

  def order_params
    # Uncomment and adjust the permitted parameters and token as needed
    # params.require(:order).permit(:price).merge(token: params[:token])
    params.require(:order).permit(:price) # Example, you can add :token if needed
  end

  #
  #   def pay_item
  #     Payjp.api_key = ENV['PAYJP_SECRET_KEY']
  #     Payjp::Charge.create(
  #       amount: order_params[:price],  # 商品の値段
  #       card: order_params[:token],    # カードトークン
  #       currency: 'jpy' # 通貨の種類（日本円）
  #     )
  #   end
  # end
  #
  # #  def pay_item
  # #    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
  # #    Payjp::Charge.create(
  # #     amount: order_params[:price],  # 商品の値段
  # #      card: order_params[:token],    # カードトークン
  # #      currency: 'jpy'                 # 通貨の種類（日本円）
  # #    )
  # #  end
end
