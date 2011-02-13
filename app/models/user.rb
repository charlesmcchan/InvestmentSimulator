class User < ActiveRecord::Base
	set_table_name 'user'
	
	def self.email2id email
		return self.where(:email=>email).first.id
	end
	
	def self.email2nick email
		return self.where(:email=>email).first.nickname
	end
end
