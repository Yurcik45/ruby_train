params_check = ParamsCheck.new

before do
  if request.path_info.start_with?('/items') || request.path_info.match?('/users/info') || request.path_info.match?('/users/activate')
    # Logic specific to certain routes
    puts "before is working"
    user_id = check_auth_and_halt(request)
    if user_id
      request.env['user_id'] = user_id
    end
  end
end

# Read all items
get '/items' do
  todolist_db = Tasks.new(request.env['user_id'])
  tasks = todolist_db.get_all_tasks.map { |row| row.to_h }
  tasks.to_json
end


# Read a specific item
get '/items/:id' do
  id = params[:id].to_i
  todolist_db = Tasks.new(request.env['user_id'])
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
  todolist_db = Tasks.new(request.env['user_id'])
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
  todolist_db = Tasks.new(request.env['user_id'])
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
  todolist_db = Tasks.new(request.env['user_id'])
  deleted_in_db = todolist_db.delete_task(id)
  if deleted_in_db
    deleted = deleted_in_db[0].to_h
    status 200
    body deleted.to_json
  else
    send_wrong_msg
  end
end
