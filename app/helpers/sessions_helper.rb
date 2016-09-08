module SessionsHelper
	 def log_in(organization)
		session[:organization_id] = organization.id
		 #Just a cookie produced in the browser and stays till u sign out or close the browser
	end

	def current_organization
		@current_organization = @current_organization || Organization.find_by(id: session[:organization_id])
	end

	def logged_in?
		!current_organization.nil?
	end

	def log_out

		session.delete(:organization_id)
		@current_organization = nil
	end

	def donor_log_in(user)
		session[:user_id] = user.id
	end

	def current_user
		@current_user = @current_user || User.find_by(id: session[:user_id])
	end

	def donor_logged_in?
		!current_user.nil?
	end
	def donor_log_out

		session.delete(:user_id)
		@current_user = nil
	end
end
