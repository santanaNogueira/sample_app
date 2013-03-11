Given(/^a client visits signin page$/) do
  visit signin_path
end

When(/^he submits invalid signin information$/) do
  click_button "Sign in"
end

Then(/^he should see an error message$/) do
  should have_selector('div.alert.alert-error')
end

Given(/^the client has an account$/) do
  @client = Client.create(name: "Example Client", email: "client@example.com",
  							password: "foobar", password_confirmation: "foobar")
end

Given(/^the client submits valid signin information$/) do
  fill_in "Email", with: @client.email
  fill_in "Password", with: @client.password
  click_button "Sign in"
end

Then(/^he should see his profile page$/) do
  page.should have_selector('title', text: @client.name)
end

Then(/^he should see a signout link$/) do
  page.should have_link('Sign out', href: signout_path)
end
