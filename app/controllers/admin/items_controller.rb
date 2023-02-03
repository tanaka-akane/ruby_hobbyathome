class Admin::ItemsController < ApplicationController

  before_action :if_not_admin
  before_action :set_item, only: [:new]

  

  private
  def if_not_admin
    redirect_to root_path unless current_user.admin?
  end

  def set_item
    @item = Item.new
  end

  def item_params
    params.require(:item).permit(:item_name,:body,:required_time,:cost,:image,:category)
  end
  
end
