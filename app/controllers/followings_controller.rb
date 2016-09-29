class FollowingsController < ApplicationController
    def create
        if !Following.exists?(user_id: current_user.id ,organization_id: params[:organization_id] ) 
            organization=Organization.find(params[:organization_id])
            follow = organization.followings.build(user_id: current_user.id, organization_id: params[:organization_id])
            organization.save 
     end
    end

    def destroy
        Following.destroy_all(user_id: current_user.id ,organization_id: params[:organization_id] )
    end
   
    private
    def following_params
        params.require(:following).permit(:user_id, :organization_id )
    end
end
