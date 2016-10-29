json.extract! user, :id, :name, :lastname, :email, :password_digest, :reference, :role, :created_at, :updated_at
json.url user_url(user, format: :json)