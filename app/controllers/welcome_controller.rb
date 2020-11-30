class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!
  BOOKS_PER_PAGE = 10

  def index
    share_books = Book.where('status': 1).length

    @bookmarks = Bookmark.group('book_id').order('count_all Desc').limit(5).count

    #pagination => http://localhost:3000/?page=0
    @page_count = (share_books % BOOKS_PER_PAGE) == 0 ? (share_books / BOOKS_PER_PAGE) : (share_books / BOOKS_PER_PAGE).to_i + 1
    if share_books <= BOOKS_PER_PAGE
      @page_count = 1
    end

    @page = params.fetch(:page, 0).to_i
    
    @books = Book.where('status': 1).offset(@page * BOOKS_PER_PAGE).limit(BOOKS_PER_PAGE)
  end
end