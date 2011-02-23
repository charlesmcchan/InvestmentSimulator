class HomeController < ApplicationController
	def login
		@status = 'Please input email/password'
		if params[:email]!=nil && !params[:email].empty? && !params[:password].empty? then
			if User.where(:email=>params[:email]).first != nil then
				if Digest::MD5.hexdigest(params[:password]) == User.where(:email=>params[:email]).first.password then
					session[:user] = params[:email]
					redirect_to '/home/index'
				else
					@status = 'Password error'
				end
			else
				@status = 'No such user'
			end
		end
	end
	
	def logout
		session[:user] = nil
		redirect_to '/home/index'
	end
	
	def register
		@status = 'Please fill the register form'
		if params[:email]!=nil && !params[:email].empty? && !params[:password].empty? && !params[:confirm].empty? && !params[:nickname].empty? then
			if params[:password]!=params[:confirm] then
				@status = 'Password not match'
			else
				if User.where(:email=>params[:email]).size!=0 then
					@status = 'Email exist'
				else
					row = User.new(:email=>params[:email], :password=>Digest::MD5.hexdigest(params[:password]), :nickname=>params[:nickname])
					row.save
					@status = 'Account created successfully'
				end
			end
		end
	end
end
