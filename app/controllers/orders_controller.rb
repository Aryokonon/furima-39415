class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @order_form = OrderForm.new
    @item = Item.find_by(id: params[:item_id])

    # Check if the user is not logged in, and if so, redirect to the login page
    unless user_signed_in?
      redirect_to new_user_session_path, alert: "You must be logged in to purchase items."
    end

    # Check if the item belongs to the current user, and if so, redirect to root
    if @item.user == current_user
      redirect_to root_path, alert: "You cannot purchase your own item."
    end
  end

  def create
    @item = Item.find_by(id: params[:item_id])
    @order_form = OrderForm.new(order_form_params)

    if @order_form.valid?
      # Call the pay_item method with the necessary parameters
      pay_item
      # Save the OrderForm data
      @order_form.save

      redirect_to root_path, notice: 'Order created successfully.'
    else
      @item = Item.find_by(id: params[:item_id]) # Re-fetch the item
      render :index
    end
  end

  private

  def order_form_params
    params.require(:order_form).permit(
      :postal_code, :prefecture_id,
      :city, :street, :building_name, :phone_number
    ).merge(
      item_id: params[:item_id],
      token: params[:token],
      user_id: current_user.id
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: order_form_params[:token],
      currency: 'jpy'
    )
  end
end
