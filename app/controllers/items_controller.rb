class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @items = Item.order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    debugger # byebug
    @item = current_user.items.build(item_params)
    if @item.save 
      flash[:notice] = "Item was successfully created."
      redirect_to @item
    else
      flash.now[:alert] = "There was an error creating the item. Please try again."
      render :new
    end
  end
  
  def edit
  end

  def update
  end

  def destroy
  end

  def show
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :category_id, :condition_id, :delivery_fee_id, :prefecture_id,
                                 :shipping_day_id, :price)
  end
end