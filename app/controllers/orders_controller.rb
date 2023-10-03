class OrdersController < ApplicationController
  before_action :authenticate_user!, except: :index

  def new
    item_id = params[:item_id]
    puts "Item ID: #{item_id}"
    item = Item.find_by(id: params[:item_id])
    @item = Item.find(params[:item_id])
    @order_form = OrderForm.new(user: current_user, item: @item)
    @items = [@item]  # Create an array containing only the selected item
    flash.now[:alert] = flash[:alert] if flash[:alert].present? # Retrieve and display flash message
    render 'index'
  end

  def index
    @items = Item.all
    @item = Item.first # Fetch the first item from your database, or use any other logic to select an item
    @order_form = OrderForm.new(user: current_user, item: @item)
  end

  def create
    @item = Item.find(params[:order_form][:item_id]) # Retrieve the item based on the submitted item_id
    @order_form = OrderForm.new(user: current_user, item: @item)

    if @order_form.valid?
      ActiveRecord::Base.transaction do
        pay_item

        order = Order.create!(price: @order_form.price, token: @order_form.token, user: current_user, item: @item)

        ShippingAddress.create!(
          postal_code: @order_form.postal_code,
          city: @order_form.city,
          street: @order_form.street,
          phone_number: @order_form.phone_number,
          prefecture_id: @order_form.prefecture_id,
          order: order
        )

        redirect_to new_orders_with_id_path, notice: 'Order was successfully created.'
      rescue StandardError => e
        Rails.logger.error "Failed to create order: #{e.message}"
        Rails.logger.error e.backtrace.join("\n")
        flash.now[:alert] = 'There was an error processing your order.'
        @items = [@item] # Initialize @items with the selected item
        render 'index'
      end
    else
      flash.now[:alert] = 'Please fill out all required fields correctly.'
      @items = [@item] # Initialize @items with the selected item
      render 'index'
    end
  end

  private

  def order_form_params
    params.require(:order_form).permit(:card_number, :card_exp_month, :card_exp_year, :card_cvc, :postal_code, :prefecture_id,
                                       :city, :street, :building_name, :phone_number)
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
