require 'sinatra'
require 'json'
require './db.rb'
require './tools.rb'
require './controllers/auth.rb'
require './controllers/todos.rb'
require './api/auth.server.rb'
require './api/todos.server.rb'

# initialize database
initial_connect

require 'rack/cors'
use Rack::Cors do
  allow do
    origins '*'  # Update this with the appropriate origin or set to '*' for any origin
    resource '*', headers: :any, methods: [:get, :post, :put, :patch, :delete, :options]
  end
end
