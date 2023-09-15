class ItemsController < ApplicationController  # Changed the class name
  def index
    @items = Item.order("created_at DESC")  # Changed variable name and model name
  end

  def new
    @item = Item.new  # Changed variable name and model name
  end

  def create
    @item = Item.new(item_params)  # Changed variable name and model name
    if @item.save  # Changed variable name
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def item_params  # Changed method name
    params.require(:item).permit(:title, :text, :genre_id)  # Changed required parameter
  end
end