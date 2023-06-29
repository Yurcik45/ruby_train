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