include ApplicationHelper

RSpec::Matchers.define :have_error_message do |message|
	match do |page|
		should have_selector('div.alert.alert-error', text: 'Invalid')
	end
end

def sign_in(client)
	visit signin_path
	fill_in "Email", 		with: client.email
 	fill_in "Password", 	with: client.password
 	click_button "Sign in"
 	#Sign in when not using Capybara
 	cookies[:remember_token] = client.remember_token
end

