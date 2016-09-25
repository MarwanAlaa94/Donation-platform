class OrganizationsController < ApplicationController
  before_action :set_organization, only: [:show,:editAndaddImages ,:edit, :update, :destroy]
  before_action :logged_in_user, only: [:edit,:show]
  before_action :correct_user_org,   only: [:edit]
  before_action :correct_user_or_admin,   only: [:destroy]
  # GET /organizations
  # GET /organizations.json
  def index
    organizations_all = Organization.search(params[:search])
    @organizations = organizations_all.where(isApproved: true).paginate(page: params[:page],:per_page=> 20)
  end

  def notApproved
    organizations_all = Organization.search(params[:search])
    @organizations = organizations_all.where(isApproved: false).paginate(page: params[:page],:per_page=> 20)
  end

  def showNotApproved
    @organization = Organization.find(params[:id])
  end

  def approveOrg
    @organization = Organization.find(params[:id])
    @organization.isApproved = true
    respond_to do |format|
      if @organization.save
        @organization.send_admin_approve_mail
        # wait approve from admin # session[:organization_id]=@organization.id

        format.html { redirect_to admin_home_path, notice: 'Organization is approved successfully.' }
        #format.json { render :show, status: :created, location: @organization }

      else
        format.html { render :new }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end

  end
  def disapproveOrg
    @organization = Organization.find(params[:id])
    @organization.send_admin_disapprove_mail
    @organization.destroy
    respond_to do |format|
      format.html { redirect_to organizations_url, notice: 'Organization was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  # GET /organizations/1
  # GET /organizations/1.json
  def show
    @organization = Organization.find(params[:id])
    @needs = @organization.needs.where(achievment_flag:false)
    @achievments = @organization.needs.where(achievment_flag:true)
  end

  # GET /organizations/new
  def new
    @organization = Organization.new
  end

  # GET /organizations/1/edit
  def edit
  end

  def editAndaddImages
    @organization.org_images.build
  end

  # POST /organizations
  # POST /organizations.json
  def create
    @organization = Organization.new(organization_params)

    @organization.isApproved = false
    respond_to do |format|
      if @organization.save
        # wait approve from admin # session[:organization_id]=@organization.id

        format.html { redirect_to editImages_path(@organization)}
        #format.json { render :show, status: :created, location: @organization }

      else
        format.html { render :new }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /organizations/1
  # PATCH/PUT /organizations/1.json
  def update
    respond_to do |format|
      @organization2 = @organization.update(organization_params)
      if @organization2 && @organization.isApproved
        format.html { redirect_to @organization, notice: 'Organization was successfully updated.' }
        format.json { render :show, status: :ok, location: @organization }
      elsif @organization2 && !@organization.isApproved
          format.html { redirect_to root_url, notice: 'Waiting for admin approvement. We will contact you soon.' }
          format.json { render :show, status: :ok, location: @organization }
      else
        format.html { render :edit }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organizations/1
  # DELETE /organizations/1.json
  def destroy
    log_out
    @organization.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Organization was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organization
      @organization = Organization.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def organization_params
        params.require(:organization).permit(:org_name, :email, :password, :info, :website_URL, :contacts, :logo_url , :password_confirmation,:image, :isApproved, org_images_attributes:[:caption,:photo,:id] )   end
        end

    def logged_in_user
         unless logged_in? || admin_logged_in? || donor_logged_in?
           flash[:danger] = "Please log in."
           redirect_to login_url
         end
       end

    def correct_user_or_admin
        @organization = Organization.find(params[:id])
        redirect_to(root_url) unless current_organization?(@organization) || admin_logged_in?
    end
   def correct_user_org

        @organization = Organization.find(params[:id])
        redirect_to(root_url) unless current_organization?(@organization)
    end
