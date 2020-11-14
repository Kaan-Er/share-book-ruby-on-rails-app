class AddTradeableToBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :tradeable, :boolean
  end
end
