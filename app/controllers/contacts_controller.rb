class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params[:contact])
    @contact.request = request
    if @contact.deliver
      flash.now[:notice] = 'Thank you for your message. We will contact you soon!'
      redirect_to root_path, :notice => 'Thank you for your message. We will contact you soon!'
    else
      flash.now[:error] = 'Cannot send message. Please fill the form correctly.'
      #redirect_to root_path, :notice => 'Cannot send message. Please fill the form correctly.'
      
    end
  end
end