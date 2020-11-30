# Share Book Platform

Share Book is a Ruby on Rails application that you can Sign in , share books and trade books with another users. It uses MVC pattern and renders serverside HTML to the view.

### New Features!

  - Books owner cannot assign a request to own book
  - Books that have been approved or rejected have been removed from the "Incoming Wish List"
  - Users can add books to own favorite list
  - The five most liked books by users have been added to the favorite books list on the main page
  - Users can see the books they add to their favorites on their own dashboard

##### Also the features I want on the site as an additional feature;
- Categorizing books
- Pagination of books on the home page
    
### Technologies

* Bootstrap: For the style
* Devise: For Authentication
* PostgreSql: For the database
* rbenv install 2.7.2
* Rails 6.0.3
* Using Bundler

### Installation

You can git clone: https://github.com/Kaan-Er/share-book.git

```sh
$ cd book_share
Check your Ruby version
$ ruby -v
Install the dependencies and devDependencies
$ bundle install
Initialize the database
$ rails db:create
$ rails db:migrate
Open the project local
$ rails s
```

### Application Link

`You can visit:` https://book-platform.herokuapp.com/
