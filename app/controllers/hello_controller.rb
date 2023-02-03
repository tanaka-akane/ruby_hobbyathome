class HelloController < ApplicationController


before_action :authenticate_user!, only: [:edit, :update, :destroy, :new, :create]

def index
    @random = Item.order("RANDOM()").limit(1)
    @items = Item.all
    if params[:search] == nil
        @items= Item.all.page(params[:page]).per(12)
      elsif params[:search] == ''
        @items= Item.all.page(params[:page]).per(12)
      else
        #部分検索
        @items = Item.where("item_name LIKE ? ",'%' + params[:search] + '%').page(params[:page]).per(6)
      end
  end

  def new
    @item = Item.new
  end

  def create
    item = Item.new(item_params)
    item.user_id = current_user.id
    if item.save
      redirect_to :action => "index"
    else
      redirect_to :action => "new"
    end
  end

  def show
    @item = Item.find(params[:id])
    @comments = @item.comments
    @comment = Comment.new
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    item = Item.find(params[:id])
    if item.update(item_params)
      redirect_to :action => "show", :id => item.id
    else
      redirect_to :action => "new"
    end
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    redirect_to action: :index
  end

#カテゴリー分け
  def category1
    @category1 = Item.where(category:"見る・聞く")
  end

  def category2
    @category2 = Item.where(category:"つくる") 
  end

  def category3
    @category3 = Item.where(category:"動く") 
  end

  def category4
    @category4 = Item.where(category:"遊ぶ") 
  end

  def category5
    @category5 = Item.where(category:"身につける") 
  end

    private
    def item_params
      params.require(:item).permit(:item_name, :body, :required_time, :cost, :image, :category)
    end



end
