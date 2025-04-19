require 'sinatra'
require 'json'
require 'rack/cors'

# Set up rack-cors middleware for handling CORS
use Rack::Cors do
  allow do
    origins '*' # Allow all origins, you can specify specific domains here if needed
    resource '*', headers: :any, methods: [:get, :post, :options]
  end
end

# In-memory store (use DB in real app)
ENTRIES = []

# Allow preflight (for CORS)
options "*" do
  response.headers["Allow"] = "GET, POST, OPTIONS"
  response.headers["Access-Control-Allow-Origin"] = "*"
  response.headers["Access-Control-Allow-Headers"] = "Content-Type"
  200
end

before do
  content_type :json
  headers 'Access-Control-Allow-Origin' => '*' # CORS headers
end

# GET /entries
get '/entries' do
  ENTRIES.to_json
end

# POST /submit
post '/submit' do
  data = JSON.parse(request.body.read)
  entry = { name: data['name'], phone: data['phone'] }
  ENTRIES << entry
  { message: 'Saved successfully', entry: entry }.to_json
end

