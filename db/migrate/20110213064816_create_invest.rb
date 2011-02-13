class CreateInvest < ActiveRecord::Migration
	def self.up
		create_table "invest", :force => true do |t|
			t.integer "account_id",                :null => false
			t.string  "name",       :limit => 128, :null => false
			t.string  "kind",       :limit => 128, :null => false
			t.string  "currency",   :limit => 128, :null => false
		end
	end

	def self.down
		drop_table :invest
	end
end
