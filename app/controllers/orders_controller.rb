class OrdersController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @order_form = OrderForm.new
    @item = Item.find_by(id: params[:item_id])
  end

  def create
    @item = Item.find_by(id: params[:item_id])
    @order_form = OrderForm.new(order_form_params)

    if @order_form.valid?
      # Save the OrderForm data
      @order_form.save

      # Create an Order and ShippingAddress within a transaction to ensure data consistency
      ActiveRecord::Base.transaction do
        order = Order.create(
          price: @order_form.price,
          token: @order_form.token,
          user: current_user,
          item: @item
        )

        ShippingAddress.create(
          postal_code: @order_form.postal_code,
          city: @order_form.city,
          street: @order_form.street,
          phone_number: @order_form.phone_number,
          prefecture_id: @order_form.prefecture_id,
          order: order
        )
      end

      # Call the pay_item method with the necessary parameters
      pay_item(@order_form.price, @order_form.token)

      redirect_to root_path, notice: 'Order created successfully.'
    else
      render :index
    end
  end

  private

  def order_form_params
    params.require(:order_form).permit(:card_number, :card_exp_month, :card_exp_year, :card_cvc, :postal_code, :prefecture_id, :city, :street, :building_name, :phone_number).merge(user_id: current_user.id)
  end

  def pay_item(price, token)
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: price,
      card: token,
      currency: 'jpy'
    )
  end
end