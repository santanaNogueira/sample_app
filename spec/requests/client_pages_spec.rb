require 'spec_helper'

describe "Client pages" do

  subject {page}

  describe "index" do

    let(:client) { FactoryGirl.create(:client) }

    before(:all)  { 30.times { FactoryGirl.create(:client) } }
    after(:all)   { Client.delete_all }

    before(:each) do
      sign_in client
      visit clients_path
    end

    it { should have_selector('title', text: 'Todos os Utilizadores') }
    it { should have_selector('h1', text: 'Todos os Utilizadores') }

    describe "pagination" do

      it { should have_selector('div.pagination') }

      it "should list each user" do
        Client.paginate(page: 1).each do |client|
          page.should have_selector('li>a', text: client.name)
        end
      end
    end

    describe "delete link" do
      it { should_not have_link('delete') }

      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit clients_path
        end

        it { should have_link('delete', href: client_path(Client.first)) }

        it "should be able to delete another user" do
          expect {click_link('delete') }.to change(Client, :count).by(-1)
        end

        it { should_not have_link('delete', href: client_path(admin)) }
      end
    end
  end

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
    end

     	describe "after submission" do
     		before { click_button submit }
     			it { should have_selector('title', text: 'Sign up') }
     			it { should have_content('error') }
     			it { should_not have_content('Password digest') }

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
          it { should have_link('Sign out')}
     		end
     	end
  end

  describe "edit" do
        let(:client){ FactoryGirl.create(:client) }
        before do 
          sign_in(client)
          visit edit_client_path(client)
        end


        describe "page" do
          
          it { should have_selector('h1',    text: "Update your profile") }
          it { should have_selector('title', text: "Edit user") }
          it { should have_link('change',    href:'http://gravatar.com/emails') }
        end

        describe "with invalid information" do
          before { click_button "Save changes" }

          it { should have_content('error') }
        end

        describe "with valid information" do
          let(:new_name){"New Name"}
          let(:new_email){"new@example.com"}

          before do
            fill_in "Name",             with: new_name
            fill_in "Email",            with: new_email
            fill_in "Password",         with: client.password
            fill_in "Confirm Password", with: client.password
            click_button "Save changes"
          end

          it { should have_selector('title', text: new_name) }
          it { should have_link('Sign out', href: signout_path) } 
          it { should have_selector('div.alert.alert-success') }
          specify { client.reload.name.should == new_name }
          specify { client.reload.email.should == new_email }
        end
  end
end

   
