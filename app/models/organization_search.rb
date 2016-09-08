class OrganizationSearch < ApplicationRecord
	def organizations
		@organizations||= find_organizations
	end

	def search_organizations
		organizations = Organization.all
		organizations = organizations.where("org_name LIKE?","%#{org_name}%") if org_name.present?
		organizations = organizations.where(["email LIKE?",email]) if email.present?
		# email must be written coorectly , note : it is a email field
		organizations = organizations.where(["info LIKE?","%#{info}%"]) if info.present?
		organizations = organizations.where(["contacts LIKE?","%#{contacts}%"]) if contacts.present?
		organizations = organizations.where(["website_URL LIKE?","%#{website_URL}%"]) if website_URL.present?
		
		return organizations
	end
end
