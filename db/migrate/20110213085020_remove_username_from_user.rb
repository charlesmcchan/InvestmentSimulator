class RemoveUsernameFromUser < ActiveRecord::Migration
  def self.up
  	change_table :user do |t|
  		t.remove :username
  	end
  end

  def self.down
		change_table :user do |t|
			t.string "username", :limit => 128, :null => false
  	end
  end
end
