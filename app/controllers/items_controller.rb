# Changed the class name
class ItemsController < ApplicationController
  def index
    @items = Item.order('created_at DESC') # Changed variable name and model name
  end

  def new
    @item = Item.new # Changed variable name and model name
  end

  def create
    @item = current_user.items.build(item_params)
    @item = Item.new(item_params) # Changed variable name and model name
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
