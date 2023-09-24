class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :find_item, only: [:edit, :update, :show]

  def new
    @item = Item.new
  end

  def create
    @item = current_user.items.build(item_params)
    if @item.save
      flash[:notice] = 'Item was successfully created.'
      redirect_to root_path, notice: '商品を出品しました。'
    else
      remove_duplicate_errors(@item)
      render 'new'
    end
  end

  #  def index
  #    #  @items = Item.order('created_at DESC')
  #    end

  #  def edit
  #  end

  #  def update
  #    if @item.update(item_params)
  #      flash[:notice] = 'Item was successfully updated.'
  #     redirect_to @item
  #    else
  #      flash.now[:alert] = 'There was an error updating the item.'
  #      render :edit
  #    end
  #  end

  #  def destroy
  #    @item = Item.find(params[:id])
  #    @item.destroy
  #    flash[:notice] = 'Item was successfully deleted.'
  #    redirect_to items_path
  #  end

  #  def show
  #  end

  private

  #  def find_item
  #    @item = Item.find(params[:id])
  #  end

  def item_params
    params.require(:item).permit(
      :name, :description, :category_id, :condition_id, :delivery_fee_id,
      :prefecture_id, :shipping_day_id, :price, :image
    )
  end

  def remove_duplicate_errors(item)
    # Iterate through the errors and remove duplicates
    item.errors.messages.each do |field, _messages|
      item.errors[field].uniq!
    end
  end
end
