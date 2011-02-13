class CreateQuotes < ActiveRecord::Migration
  def self.up
    create_table :quotes do |t|
      t.string :quote_id
      t.string :name
      t.string :quote_type
      t.timestamps
    end
  end

  def self.down
    drop_table :quotes
  end
end
