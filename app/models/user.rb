class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :trades
  has_many :books
  has_many :comments
  validates :email, presence: true, format: /\A[^@]{5,50}@[^@]+\z/
  
  # validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true
  # validates :username, presence: true, length: { minimum:5, maximum:50}


  attr_writer :login

  before_create :build_username

  def login
    @login || self.username || self.email
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      if conditions[:username].nil?
        where(conditions).first
      else
        where(username: conditions[:username]).first
      end
    end
  end

  private

  def build_username
    self.username = self.email[/^[^@]+/]
  end
end