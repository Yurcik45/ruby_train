todolist_db = Tasks.new
params_check = ParamsCheck.new

before do
  check_auth_and_halt(request)
end

get '/test' do
  headers = request.env
  puts "authorization header: #{headers['HTTP_AUTHORIZATION']}"
end

# Read all items
get '/items' do
  tasks = todolist_db.get_all_tasks.map { |row| row.to_h }
  tasks.to_json
end


# Read a specific item
get '/items/:id' do
  id = params[:id].to_i
  tasks_in_db = todolist_db.get_task(id)
  if tasks_in_db.ntuples > 0
    task = tasks_in_db[0].to_h
    status 200
    body task.to_json
  else
    send_wrong_msg("no items was found with id #{id}")
  end
end

# Create a new item
post '/items' do
  item = JSON.parse(request.body.read, symbolize_names: true)
  if params_check.todo_post(item)
    added = todolist_db.add_task(item[:task])[0].to_h
    status 201
    body added.to_json
  else
    send_wrong_msg
  end
end

# Update an existing item
put '/items/:id' do
  id = params[:id].to_i
  updated_item = JSON.parse(request.body.read, symbolize_names: true)
  if params_check.todo_put(updated_item)
    updated_in_db = todolist_db.change_task(id, updated_item[:task], updated_item[:completed])
    if updated_in_db.ntuples > 0
      updated = updated_in_db[0].to_h
      status 200
      body updated.to_json
    else
      send_wrong_msg
    end
  else
    send_wrong_msg
  end
end

# Delete an item
delete '/items/:id' do
  id = params[:id].to_i
  deleted_in_db = todolist_db.delete_task(id)
  if deleted_in_db
    deleted = deleted_in_db[0].to_h
    status 200
    body deleted.to_json
  else
    send_wrong_msg
  end
end
