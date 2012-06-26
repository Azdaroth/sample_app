module Validations

	def sign_in(user)
		visit signin_path
		fill_in "Email", with: user.email
		fill_in "Password", with: user.password
		click_button "Sign in"
		# Sign in when not using Capybara as well.
		cookies[:remember_token] = user.remember_token
	end

	def validate_email(user, addresses, action)
		addresses.each do |address|
			user.email = address
			if action == true
				user.should be_valid
			elsif action == false	
				user.should_not be_valid
			end
		end
	end
end
