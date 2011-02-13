class User < ActiveRecord::Base
	set_table_name 'user'
	
	def self.name2id name
		return self.where(:username=>name).first.id
	end
end
