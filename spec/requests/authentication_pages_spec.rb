require 'spec_helper'

describe "Authentication" do
	subject {page}
	describe "signin page" do
		before { visit signin_path } 

		it { should have_selector('h1', text: 'Sign in')  }
		it { should have_selector('title', text: 'Sign in') }
	end

	describe "signin" do
		before { visit signin_path } 

		describe "with invalid information" do
			before { click_button "Sign in" }

			it { should have_selector('title', text: 'Sign in') }
			it { should have_error_message }

			describe "after visiting another page" do
				before { click_link "Home" }
				it { should_not have_error_message }
			end
		end

		describe "with valid information" do
			let(:client) { FactoryGirl.create(:client) }

			before { sign_in(client) }
				

			it { should have_selector('title', 	 text: client.name) }
			it { should have_link('Profile', 	 href: client_path(client)) }
			it { should have_link('Sign out', 	 href: signout_path) }
			it { should have_link('Settings', 	 href: edit_client_path(client)) }
			it { should have_link('Users', 	 	 href: clients_path) }
			it { should_not have_link('Sign in', href: signin_path) }

			describe "followd by signout" do
				before { click_link "Sign out"}
				it { should have_link('Sign in') }
			end
		end
	end

	describe "authorization" do
		

		describe "for non-signed-in users" do
			let(:client) { FactoryGirl.create(:client) }

			describe "when attempting to visita protected page" do
				before do
				visit edit_client_path(client)
				fill_in "Email", 	with: client.email
				fill_in "Password", with: client.password
				click_button "Sign in"
				end

				describe "after signing in" do
					it "should render the desired protected page" do
						page.should have_selector('title', text: 'Edit user')
					end


					describe "when signing in again" do
						before do
							click_link "Sign out"
							click_link "Sign in"
							fill_in "Email", 	with: client.email
							fill_in "Password", with: client.password
							click_button "Sign in"
						end

						it "should render the default (profile) page" do
							page.should have_selector('title', text: client.name)

						end
					end
				end
			end

			describe "in the Clients controller" do


				describe "visiting the edit page" do
					before { visit edit_client_path(client) }

					it { should have_selector('title', text: 'Sign in') }
					it { should have_selector('div.alert.alert-notice') }

				end

				describe "submitting to the update action" do
					before { put client_path(client) }
					specify { response.should redirect_to(signin_path) }
				end

				describe "visiting the user index" do
					before { visit clients_path } #page to list all users
					it { should have_selector('title', text: 'Sign in') }
				end

			end
		end

		describe "as wrong user" do
			let(:client) { FactoryGirl.create(:client) }
			let(:wrong_client) { FactoryGirl.create(:client, email: "wrong@example.com") }

			before { sign_in client }

			describe "visiting Clients#edit page" do
				before { visit edit_client_path(wrong_client)}

				it { should_not have_selector('title', text: 'Edit user') }
			end
		

			describe "submitting a PUT to the Clients#update action" do
						before { put client_path(wrong_client) }
						specify { response.should redirect_to(root_path) }
			end
		end

		describe "as non-admin user" do
			let(:client) 	 { FactoryGirl.create(:client) }
			let(:non_admin)  {  FactoryGirl.create(:client) }

			before { sign_in non_admin }

			describe "submitting a DELETE request to Clients#destroy action" do
				before { delete client_path(client) }
				specify { response.should redirect_to(root_path) }
			end

		end
	end
end
