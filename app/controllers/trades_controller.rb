class TradesController < ApplicationController
  
  def edit
    @trading = Trade.find(params[:id])
    @trading_user = User.find(@trading.user_id)
    @trading_book = Book.find(@trading.offered_book_id)
  end

  def update
    @trading = Trade.find(params[:id])
    if @trading.update(trade_params)
      redirect_to @trade
    else
      render 'edit'
    end
  end

  def approve
    @trade = Trade.find(params[:id])
    @trade.update_attributes(:trade_status => 1)
    redirect_to dashboard_index_path
  end

  def deny
    @trade = Trade.find(params[:id])
    @trade.update_attributes(:trade_status => -1)
    redirect_to dashboard_index_path
  end

  def new 
    @book = Book.find(params[:book_id])
    @user = User.find_by_id(@book.user_id)
    @books = current_user.books.listed
  end
  
  def create
    @book = Book.find(params[:book_id])
    @trade = @book.trades.build(trade_params)
    if @trade.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  private
  def trade_params
    params.require(:trade).merge(user_id: current_user.id).permit(:user_id, :offered_book_id)
  end
end
