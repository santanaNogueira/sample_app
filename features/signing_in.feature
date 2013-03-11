Feature: Signing in

Scenario: Unsuccessful signin
	Given a client visits signin page
	When he submits invalid signin information
	Then he should see an error message


Scenario: Successful signin
	Given a client visits signin page
		And the client has an account
		And the client submits valid signin information
	Then he should see his profile page
		And he should see a signout link