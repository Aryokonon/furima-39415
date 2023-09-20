# COMMENTED OUTED

# Changed the class name
class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @items = Item.all 
  end

  # Define other actions (e.g., show, new, create, edit, update, destroy) as needed

  def new
    @item = Item.new
  end

  def create
    @item = current_user.items.build(item_params)
    if @item.save # Changed variable name
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :category_id, :condition_id, :delivery_fee_id, :prefecture_id,
                                 :shipping_day_id, :price)
  end
end