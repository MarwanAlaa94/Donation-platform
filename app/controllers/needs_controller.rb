class NeedsController < ApplicationController
  before_action :set_need, only: [:show, :edit,:addImage, :update, :destroy,:ignore, :recieve]
   before_action :correct_user,   only: [:edit,:destroy,:showPayments]

  def index
      @needs = Need.where(organization_id: params[:organization_id] ,achievment_flag:false)
  end

  def indexAchivements
      @needs = Need.where(organization_id: params[:organization_id] ,achievment_flag:true)
  end

  def addImage
      @need.need_images.build
  end
  def show
  end

  def showPayments
     @need = Need.find(params[:need_id])
     recommended_payments_ids = recommend_payments
     @recommended_payments= Array.new
     recommended_payments_ids.each do |index|
      @recommended_payments.push(Payment.find(index))
    end
   end


  def new
    @organization = Organization.find(params[:organization_id])
    @need=@organization.needs.build
    @need.need_images.build
  end
  def edit
      @need.need_images.build
  end

  def deleteNeedImage
    @image = NeedImage.find(params[:image_id])
    @image.destroy
    #redirect_to organization_needs_path+"/"+params[:need_id].to_s+"/edit", notice: 'Image was successfully deleted.'
  end

  def donate
   @need = Need.find(params[:need_id])
   @payment= @need.payments.build(org_id: @need.organization.id,
    user_id: current_user.id , need_name:@need.title , is_recieved: false
     )
 end

  def recieve
     @payment = Payment.find(params[:payment_id])
     @payment.is_recieved = true
     @payment.save
     @payment.need.donated_money += @payment.donated_money
      if @payment.need.donated_money >= @payment.need.money
        @payment.need.achievment_flag = true

      end
    @payment.need.save
    user= User.find(@payment.user_id)
    users = Array.new
    users.push(@payment.user_id)
    redirect_to organization_need_create_noti_path(:users =>users, :org_id => params[:organization_id], :need_id => @need.id, :pay_id => @payment.id, :noti_type => 2)

    #redirect_to organization_need_needPayments_path(need_id: @payment.need.id), notice: 'Payment has been recieved successfully'
  end

  def ignore
      @payment = Payment.find(params[:payment_id])
      user= User.find(@payment.user_id)
      users = Array.new
      users.push(@payment.user_id)
      @need.send_payment_ignorance_mail(user,@payment)
    
      redirect_to organization_need_create_noti_path(:users =>users, :org_id => params[:organization_id], :need_id => @need.id, :pay_id => @payment.id, :noti_type => 1) 
      @payment.destroy
     #redirect_to organization_need_needPayments_path, notice: 'Payment has been ignored successfully'
 end

  def create
      @organization = Organization.find(params[:organization_id])
      @need = @organization.needs.create(need_params)
      if @organization.save
            followers=Array.new
            followers= @organization.followings.pluck(:user_id) 
            if followers.any?
              redirect_to organization_need_create_noti_path(:users =>followers, :org_id => params[:organization_id], :need_id => @need.id, :pay_id => ' ', :noti_type => 3) 
            else
              redirect_to  organization_needs_path, notice: 'Need was successfully created.'
            end
      else
          render :new
      end
end


  def update
    respond_to do |format|
      if @need.update(need_params)
        format.html { redirect_to [@need.organization, @need] }
        format.json { render :show, status: :ok, location: @need }
      else
        format.html { render :edit }
        format.json { render json: @need.errors, status: :unprocessable_entity }
      end
    end
  end



  def destroy
    Notification.destroy_all(:organization_id => @need.organization.id)
    @need.destroy
    respond_to do |format|
      format.html { redirect_to organization_needs_path, notice: 'Need was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_need
      @need = Need.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def need_params
        params.require(:need).permit(:title, :description, :start_date, :end_date, :in_progress, :money,
         :urgent_rate, :achievment_flag ,need_images_attributes:[:caption,:photo,:id] ,
         payments_attributes:[:comment ,:need_name, :donated_money, :user_id, :org_id ,
          :id , :is_recieved , :user_name , :user_address , :user_number])

    end
    def recommend_payments
         recommended_payments_ids= Array.new
         array1 = @need.payments.pluck(:id)
         array2 = @need.payments.pluck(:donated_money)
         close_payments_cominations= Array.new
         close_sum =  (@need.money - @need.donated_money) + (0.1* @need.money )
         (1..array2.count).each do |len|
            array2.combination(len).each_with_index do |comb, index|
               sum = comb.inject(:+)
               if sum == (@need.money - @need.donated_money)
                   return recommended_payments_ids=array1.combination(len).to_a[index]
               elsif (sum > (@need.money - @need.donated_money) && sum < close_sum )
                  close_payments_cominations = comb
                  close_sum = sum
                   recommended_payments_ids=array1.combination(len).to_a[index]
               end

            end
         end
         return recommended_payments_ids
     end
end
