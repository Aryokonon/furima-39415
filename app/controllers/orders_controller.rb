class OrdersController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @order_form = OrderForm.new
  end

  def create
    @order_form = OrderForm.new(order_form_params)
    if @order_form.valid?
      @order_form.save
      # redirect_to root_path
      begin
        pay_item
        save_order_and_shipping_address
        redirect_to root_path, notice: 'Order was successfully created.'
      rescue Payjp::Error
        flash[:alert] = 'Payment failed: Order has failed'
        render 'index' # Render the index view in case of a payment error
      end
    else
      render 'index' # Render the index view if validation fails
    end
  end
  
  private

  def order_form_params
    params.require(:order_form).permit(:price, :token, :postal_code, :building_name, :city, :street, :phone_number,
                                       :prefecture_id)
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @order.price,  # 商品の値段
      card: @order.token,    # カードトークン
      currency: 'jpy'        # 通貨の種類（日本円）
    )
  end

  def save_order_and_shipping_address
    ActiveRecord::Base.transaction do
      order = Order.create(price: @order.price, token: @order.token, user: current_user, item: @item)
      ShippingAddress.create(
        postal_code: @order.postal_code,
        city: @order.city,
        street: @order.street,
        phone_number: @order.phone_number,
        prefecture_id: @order.prefecture_id,
        order: order
      )
    end
  end
end
