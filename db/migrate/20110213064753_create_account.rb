class CreateAccount < ActiveRecord::Migration
	def self.up
		create_table "account", :force => true do |t|
			t.integer "user_id",                                                :null => false
			t.string  "currency", :limit => 128,                                :null => false
			t.decimal "count",                   :precision => 20, :scale => 4, :null => false
		end
	end

	def self.down
		drop_table :account
	end
end
