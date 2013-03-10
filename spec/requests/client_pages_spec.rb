require 'spec_helper'

describe "Client pages" do
  subject {page}
  describe "signup page" do
  	before {visit signup_path}

  	it { should have_selector('h1', text: 'Sign up') }
  	it { should have_selector('title', text: full_title('Sign up')) }
  end

describe "profile page" do
	let(:client) { FactoryGirl.create(:client) }

  	before {visit client_path(client)}

  	it { should have_selector('h1', 	text: client.name) }
  	it { should have_selector('title',  text: client.name) }
  end

  describe "signup" do
 	before { visit signup_path }

 	let(:submit) {"Create My Account" }

 	describe "with invalid information" do
 		it "should not create a user" do
 			expect { click_button submit }.not_to change(Client, :count)
 		end

 	describe "after submission" do
 		before { click_button submit }
 			it { should have_selector('title', text: 'Sign up') }
 			it { should have_content('error') }
 			it { should_not have_content('Password digest') }

 	end
  end




 	describe "with valid information" do

 		before do
 			fill_in "Name", 		with: "Example User"
 			fill_in "Email", 		with: "client@example.com"
 			fill_in "Password", 	with: "foobar"
 			fill_in "Confirmation", with: "foobar"
 		end

 		it "should create a user"  do
 			expect { click_button submit }.to change(Client, :count).by(1)
 		end

 		describe "after savind a user" do

 			before { click_button submit }

 			let(:client) { Client.find_by_email("client@example.com") }

 			it { should have_selector('title', text: client.name)}
 			it { should have_selector('div.alert.alert-success', text: 'Bem Vindo') }
 		end
 	end
 end
end
