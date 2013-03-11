module SessionsHelper

	def sign_in (client)
		cookies.permanent[:remember_token] = client.remember_token
		current_client = client
	end

	def signed_in?
		!current_client.nil?
	end

	def current_client=(client)
		@current_client = client
	end

	def current_client
		@current_client ||= Client.find_by_remember_token(cookies[:remember_token])
		#igual a ter: @current_client = @current_client  || Client.find_by_remember_token(cookies[:remember_token])
	end

	def sign_out
		current_client = nil
		cookies.delete(:remember_token)
	end
end