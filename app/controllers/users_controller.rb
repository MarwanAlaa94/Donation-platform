class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy ]
  before_action :correct_donor_or_admin, only: [:show, :destroy]
  before_action :correct_donor, only: [ :edit, :update]
  before_action :logged_in_admin, only:[:index,:index_admins]
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  def index_admins
    @admins = User.where(isAdmin:true)
  end
  # GET /users/invite
  def invite_admin
    @user = User.new
  end

  #POST /users/invite
  def invite_new_admin
    rand_password = (('0'..'9').to_a + ('a'..'z').to_a + ('A'..'Z').to_a).shuffle.first(10).join
    params[:user][:password] = rand_password
    params[:user][:password_confirmation] = rand_password
    params[:user][:isAdmin] = true

    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        @user.send_admin_invitation_mail(rand_password)
        # Tell the UserMailer to send a welcome Email after save
        format.html { redirect_to admin_home_path, notice: 'New Admin was invited by email.' }
      else
        format.html { render :invite_admin }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  # GET /users/1
  # GET /users/1.json
  def show
  end
  def showPayment
    @user = User.find(params[:user_id])
    @payments = @user.payments
  end

  def myKheir

   @user = User.find(params[:user_id])
    @payments = @user.payments
    @payments1 = @payments.sort_by &:org_id
    @lists=[]
    @lists.append([])
    i=0;j=0;
    @payments1.each do |pay|
        if j!=0
          if @payments1[j].org_id!=@payments1[j-1].org_id
            @lists.append([])
            i+=1
          end
        end
        @lists[i].append(@payments1[j])
        j+=1
    end
  end


  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        @user.send_admin_mail
        session[:user_id]=@user.id
        # Tell the UserMailer to send a welcome Email after save
        format.html { redirect_to @user, notice: 'Donor was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'Donor was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    donor_log_out
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'Donor was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  protect_from_forgery

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def logged_in_admin
        unless admin_logged_in?
           redirect_to root_url
        end
    end

    def correct_donor_or_admin
        @user = User.find(params[:id])
        redirect_to(root_url) if !current_user?(@user) && !admin_logged_in?
    end

    def correct_donor
        @user = User.find(params[:id])
        redirect_to(root_url) if !current_user?(@user)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:user_name, :email, :password, :password_confirmation, :avatar, :avatar_cache, :remove_avatar, :isAdmin)
    end
end
