FactoryGirl.define do 
	factory :client do
		name 					"Michael Hartl"
		email 					"mhartl@example.com"
		password 				"foobar"
		password_confirmation 	"foobar"
	end
	
end