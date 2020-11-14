class DashboardController < ApplicationController
  before_action :require_permission, only: :edit

  def new
    @book = Book.new
  end

  def index
    @books = Book.where('user_id': current_user.id)
    @my_comments = Comment.where('user_id': current_user.id)
    @my_wish_list = Trade.where('user_id': current_user.id)
    @trades = Trade.all
  end

  def create
    @book = current_user.books.build(book_params)  
    if @book.save
      redirect_to @dashboard
    else
      render 'new'
    end  
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id]) 
    if @book.update(book_params)
      redirect_to @dashboard
    else
      render 'edit'
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
  
    redirect_to dashboard_path
  end

  def show
    @book = Book.find(params[:id])
  end


  private
  def book_params
    params.require(:book).permit(:title, :author, :pagecount, :status, :user_id)
  end

  def require_permission
    if current_user != Book.find(params[:id]).user
      redirect_to root_path
    end
  end
end
