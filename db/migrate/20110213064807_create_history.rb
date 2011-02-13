class CreateHistory < ActiveRecord::Migration
	def self.up
		create_table "history", :force => true do |t|
			t.integer   "invest_id",                                 :null => false
			t.decimal   "local",      :precision => 20, :scale => 4, :null => false
			t.decimal   "rate",       :precision => 20, :scale => 4, :null => false
			t.decimal   "unit",       :precision => 20, :scale => 4, :null => false
			t.decimal   "price",      :precision => 20, :scale => 4, :null => false
			t.decimal   "commission", :precision => 20, :scale => 4, :null => false
			t.timestamp "timestamp",                                 :null => false
		end
	end

	def self.down
		drop_table :history
	end
end
