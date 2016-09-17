class Search < ApplicationRecord

def organizations
		@organizations||= find_organizations
	end

	def needs
		@needs||= find_needs
	end

	def search_organizations
		organizations = Organization.all
		organizations = organizations.where("org_name LIKE?","%#{keyword}%").or(organizations.where(["info LIKE?","%#{keyword}%"]))
	    organizations = organizations.where("isApproved = ?", true)
		return organizations
	end

		def search_needs
		needs = Need.all
        needs = needs.where("title LIKE?","%#{keyword}%") 
		return needs
	end
end
