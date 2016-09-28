class NotificationsController < ApplicationController
before_action :correct_user,   only: [:showNotifications]
#####
def create
    users =params[:users]
    users.each do |user_id|
        notification=Notification.new
        notification.user_id=user_id
        notification.notification_type=params[:noti_type]
        notification.organization_id=params[:org_id]
        notification.need_id=params[:need_id]
        if params[:pay_id] == ' '
           
        else
            notification.payment_id=params[:pay_id]
        end
        notification.save
        user= User.find(user_id)
        User.where(:id => user_id).update_all(:notifications_count => user.notifications_count+1)
    end 
    if params[:noti_type]==1.to_s
        redirect_to organization_need_needPayments_path, notice: 'Payment was ignored successfully'
    elsif params[:noti_type]==2.to_s
        redirect_to organization_need_needPayments_path, notice: 'Payment has been recieved successfully'
    elsif params[:noti_type]==3.to_s
       redirect_to  organization_needs_path+"/"+params[:need_id]+"/addImage"
    else
         redirect_to root_path
    end

end

    def destroy
    
    end



private
    def notification_params
        params.require(:notification).permit(:user_id, :organization_id, :need_id, :payment_id, :notification_type )
    end

 
end
