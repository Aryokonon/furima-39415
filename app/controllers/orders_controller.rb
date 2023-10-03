class OrdersController < ApplicationController
  before_action :authenticate_user!, except: :index

  def new
    @item = Item.find(params[:item_id])
    @order_form = OrderForm.new
    @items = [@item]  # Create an array containing only the selected item
    render 'index'
  end

  def index
    @order_form = OrderForm.new
    @items = Item.all
  end

  def create
    @order_form = OrderForm.new(order_form_params)
  
    if @order_form.valid?
      @item = Item.find(@order_form.item_id)
  
      ActiveRecord::Base.transaction do
        # Handle payment
        pay_item
  
        # Save order and shipping address
        save_order_and_shipping_address
  
        # Redirect to a success page or show a success message
        redirect_to root_path, notice: 'Order was successfully created.'
      rescue StandardError => e
        # Handle any errors that might occur during payment or database insertion
        flash.now[:alert] = 'There was an error processing your order.'
        render 'index'
      end
    else
      @items = []  # Set @items to an empty array
      render 'index'
    end
  end

  private

  def order_form_params
    params.require(:order_form).permit(:price, :token, :postal_code, :building_name, :city, :street, :phone_number,
                                       :prefecture_id, :item_id)
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @order_form.price,  # 商品の値段
      card: @order_form.token,    # カードトークン
      currency: 'jpy'            # 通貨の種類（日本円）
    )
  end

  def save_order_and_shipping_address
    ActiveRecord::Base.transaction do
      order = Order.create(price: @order_form.price, token: @order_form.token, user: current_user, item: @item)
      ShippingAddress.create(
        postal_code: @order_form.postal_code,
        city: @order_form.city,
        street: @order_form.street,
        phone_number: @order_form.phone_number,
        prefecture_id: @order_form.prefecture_id,
        order: order
      )
    end
  end
end
