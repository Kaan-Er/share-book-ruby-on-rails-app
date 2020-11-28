class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!
  def index
     @books = Book.where('status': 1)

     @bookmarks = Bookmark.group('book_id').order('count_all Desc').limit(5).count
  end
end
