class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!
  def index
     @books = Book.where('status': 1)
  end
end
