	class SessionsController < ApplicationController


	def create_donor
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password]) && user.isAdmin == false
			donor_log_in user
			redirect_to organizations_path
		elsif user && user.authenticate(params[:session][:password]) && user.isAdmin == true
			admin_log_in user
			redirect_to admin_home_path
		else
			flash.now[:danger] = 'Invalid Email or Password !'
			render 'new_donor'
		end
	end

	def create_donor_provider
	    user = User.from_omniauth(env["omniauth.auth"])
	    session[:user_id] = user.id
	    redirect_to root_url
	  end


	def show_donor
 		@user = User.find(params[:id])
 	end

 	def destroy_donor
 		donor_log_out
		redirect_to root_url
 	end

 	def destroy_admin
 		admin_log_out
		redirect_to root_url
 	end

	def create
		organization = Organization.find_by(email: params[:session][:email].downcase)
		if organization && organization.authenticate(params[:session][:password]) && organization.isApproved == true
			log_in organization
			redirect_to organization
		# Log the user in and redirect to the user's show page.
		else
			flash.now[:danger] = 'Invalid email/password combination'
			render 'new'
		end
	end

	def destroy
		log_out
		redirect_to root_url
	end
	def show
 		@organization = Organization.find(params[:id])
 	end

end
