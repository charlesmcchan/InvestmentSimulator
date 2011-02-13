class CreateQuoteHistories < ActiveRecord::Migration
  def self.up
    create_table :quote_histories do |t|
      t.string :quote_id
      t.float :price
      t.string :currency
      t.timestamps
    end
  end

  def self.down
    drop_table :quote_histories
  end
end
