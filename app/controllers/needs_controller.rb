class NeedsController < ApplicationController
  before_action :set_need, only: [:show, :edit, :update, :destroy]

  def index
      @needs = Need.where(organization_id: params[:organization_id] ,achievment_flag:false)
  end

  def indexAchivements
      @needs = Need.where(organization_id: params[:organization_id] ,achievment_flag:true)
  end
  def show
  end
  def new
    @organization = Organization.find(params[:organization_id])
    @need=@organization.needs.build
  end
  def edit
      @need.need_images.build
  end

  def donate
   @need = Need.find(params[:need_id])

   @payment= @need.payments.build(org_id: @need.organization.id,
    user_id: current_user.id , need_name:@need.title , is_recieved: false)
 end

  def create
    @organization = Organization.find(params[:organization_id])
    @need = @organization.needs.create(need_params)
      if @organization.save
          redirect_to organization_path(@organization)
        else
         render :new
  end
end


  def update
    respond_to do |format|
      if @need.update(need_params)
        format.html { redirect_to [@need.organization, @need], notice: 'Need was successfully updated.' }
        format.json { render :show, status: :ok, location: @need }
      else
        format.html { render :edit }
        format.json { render json: @need.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @need.destroy
    respond_to do |format|
      format.html { redirect_to needs_url, notice: 'Need was successfully destroyed.' }
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
         payments_attributes:[:comment ,:need_name, :donated_money, :user_id, :org_id , :id , :is_recieved])

      end
end
