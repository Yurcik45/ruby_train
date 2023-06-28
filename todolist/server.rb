require 'sinatra'
require 'json'
require './db.rb'

# Set the IP address and port
# set :bind, '0.0.0.0'
# set :port, 4567

todolist_db = Tasks.new

# Read all items
get '/items' do
  tasks = todolist_db.get_all_tasks.map { |row| row.to_h }
  tasks.to_json
end

# Read a specific item
get '/items/:id' do
  id = params[:id].to_i
  task = todolist_db.get_task(id)[0].to_h
  tasks.to_json
  if item
    status 200
    body item.to_json
  else
    status 404
    body 'Item not found'
  end
end

# Create a new item
post '/items' do
  item = JSON.parse(request.body.read, symbolize_names: true)
  added = todolist_db.add_task(item)[0].to_h
  status 201
  body added.to_json
end

# Update an existing item
put '/items/:id' do
  id = params[:id].to_i
  updated_item = JSON.parse(request.body.read, symbolize_names: true)
  updated = todolist_db.change_task(id, updated_item[:task], updated_item[:completed])[0].to_h
  status 200
  body updated.to_json
end

# Delete an item
delete '/items/:id' do
  id = params[:id].to_i
  deleted = todolist_db.delete_task(id)[0].to_h
  status 200
  body deleted.to_json
end
