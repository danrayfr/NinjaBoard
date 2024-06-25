json.extract! login, :id, :device_id, :ip_address, :user_agent, :user_id, :created_at, :updated_at
json.url login_url(login, format: :json)
