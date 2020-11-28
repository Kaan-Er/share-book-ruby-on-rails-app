class BooksController < ApplicationController
  before_action :require_permission, only: :edit

  def new
    @book = Book.new
  end

  def create
    @book = current_user.books.build(book_params) 
    if @book.save
      redirect_to @book
    else
      render 'new'
    end  
  end

  def favorite
    @bookmark = Bookmark.new
    @bookmark.user_id = current_user.id
    @bookmark.book_id = params[:id]

    @bookmark_control = Bookmark.where(book_id: params[:id], user_id: current_user.id).first
    if @bookmark_control != nil
      @bookmark_control.destroy
      redirect_to controller: 'books', action: 'show', id: (params[:id])
    else
      @bookmark.save 
      redirect_to controller: 'books', action: 'show', id: (params[:id])
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id]) 
    if @book.update(book_params)
      redirect_to @book
    else
      render 'edit'
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
  
    # redirect_to dashboard_index_path
    respond_to do |format|
      format.html { redirect_to dashboard_index_path, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end

  end

  def show
    @book = Book.find(params[:id])

    @book_user = User.find(@book.user_id)
    @owner_control = current_user.id === @book_user.id

    @bookmark_control = Bookmark.where(book_id: params[:id], user_id: current_user.id).first

    @unapproved = Comment.where(accept: 0, user_id: current_user.id, book_id: params[:id])

    @trade_control = Trade.where(book_id: params[:id]).first

    @comments = @book.comments.accepted
    
    @comment = Comment.new
    @comment.accept = 0
    @comment.user_id = current_user.id
    @comment.book_id = @book.id
  end

  private
  def book_params
    params.require(:book).permit(:title, :author, :pagecount, :tradeable, :status, :user_id)
  end

  def require_permission
    if current_user != Book.find(params[:id]).user
      redirect_to root_path
    end
  end
end
