class OrganizationMailer < ApplicationMailer

	
  def approve_email(organization)
    @organization = organization
    @url  = 'http://localhost:3000/login'
    mail(to: @organization.email, subject: 'Congratulations! Welcome to Our Awesome Site: Donation Platform')
  end

  def disapprove_email(organization)
    @organization = organization
    @url  = 'http://localhost:3000/login'
    mail(to: @organization.email, subject: 'Sorry! from Donation Platform')
  end

end
