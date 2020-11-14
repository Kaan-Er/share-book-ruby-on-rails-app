class Comment < ApplicationRecord
  belongs_to :book
  belongs_to :user

  scope :accepted, -> {where(accept: true)}
end
