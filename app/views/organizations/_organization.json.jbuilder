json.extract! organization, :id, :org_name, :email, :password, :info, :website_URL, :contacts, :logo_url, :created_at, :updated_at
json.url organization_url(organization, format: :json)