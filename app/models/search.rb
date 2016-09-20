class Search < ApplicationRecord

    def organizations
		@organizations||= find_organizations
	end

	def needs
		@needs||= find_needs
	end

	def users
		@users||= find_users
	end

	def search_organizations
		organizations = Organization.all
		organizations = organizations.where("org_name LIKE?","%#{keyword}%").or(organizations.where(["info LIKE?","%#{keyword}%"])).or(organizations.where(["email LIKE?","%#{keyword}%"]))
	    organizations = organizations.where("isApproved = ?", true)
		return organizations
	end

	def search_needs
		needs = Need.all
        needs = needs.where("title LIKE?","%#{keyword}%").or(needs.where(["description LIKE?","%#{keyword}%"]))
		return needs
	end

	def search_users
		users = User.all
        users = users.where("user_name LIKE?","%#{keyword}%") 
		users = users.where("isAdmin = ?",false)
		return users
	end
end
