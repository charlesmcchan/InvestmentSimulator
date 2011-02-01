class HomeController < ApplicationController
	def login
		@status = 'Please input username/password'
		if params[:username]!=nil && !params[:password].empty? then
			if User.where(:username=>params[:username]).first != nil then
				if Digest::MD5.hexdigest(params[:password]) == User.where(:username=>params[:username]).first.password then
					session[:user] = params[:username]
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
end
