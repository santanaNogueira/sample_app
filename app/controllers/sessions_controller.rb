class SessionsController < ApplicationController
	def new
		
	end

	def create
		client = Client.find_by_email(params[:session][:email])
		if client && client.authenticate(params[:session][:password])
			sign_in client
			redirect_back_or client
		else
			flash.now[:error] = "Invalid email/password combination"
			render 'new'
		end
	end

	def destroy
		sign_out
		redirect_to root_path
	end
end
