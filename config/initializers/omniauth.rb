OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
	
  provider :facebook, '512814392252882', '09f98273ea5bc0bcf62d203ffc73266c'
end
