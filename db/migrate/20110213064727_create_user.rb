class CreateUser < ActiveRecord::Migration
	def self.up
		create_table :user do |t|
			t.string "username", :limit => 128, :null => false
			t.string "password", :limit => 128, :null => false
			t.string "nickname", :limit => 128, :null => false
			t.string "email",    :limit => 128, :null => false
		end	
	end

	def self.down
		drop_table :user
	end
end
