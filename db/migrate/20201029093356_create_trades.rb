class CreateTrades < ActiveRecord::Migration[6.0]
  def change
    create_table :trades do |t|
      t.references :offered_book, index: true, foreign_key: { to_table: :books }
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.integer :trade_status, default: 0
      t.timestamps
    end
  end
end
