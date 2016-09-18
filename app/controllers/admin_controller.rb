class AdminController < ApplicationController
  before_action :logged_in_admin, only:[:home]

  def home
  end

private 
  def logged_in_admin
        unless admin_logged_in?
           redirect_to root_url
        end
    end
end
