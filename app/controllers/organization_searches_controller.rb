class OrganizationSearchesController < ApplicationController
	def new 
    	@organization_search = OrganizationSearch.new
 	 end

 	 def create
    	@organization_search = OrganizationSearch.create!(search_params)
   	 	redirect_to @organization_search
  	end

 
 	def show
    	@organization_search = OrganizationSearch.find(params[:id])
  	end

 	private
 	def search_params
 		params.require(:organization_search).permit(:org_name, :email , :info, :website_URL, :contacts )
 	end
end
