class Trade < ApplicationRecord

  enum trade_status: { waiting: 0, approve: 1, deny: -1 }

  belongs_to :user
  belongs_to :book
end
