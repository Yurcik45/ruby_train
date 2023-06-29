params_check = ParamsCheck.new

# Read all users
get '/users' do
  if development?
    users_db = Users.new
    users = users_db.get_all_users.map { |row| row.to_h }
    users.to_json
  else
    status 404
  end
end

# Read a specific user
get '/users/:id' do
  id = params[:id].to_i
  users_db = Users.new(id)
  user_in_db = users_db.get_user
  if user_in_db.ntuples > 0
    user = user_in_db[0].to_h
    status 200
    body user.to_json
  else
    send_wrong_msg("no users was found with id #{id}")
  end
end

# Register a new user
post '/users/register' do
  body = JSON.parse(request.body.read, symbolize_names: true)
  if params_check.user_info(body)
    users_db = Users.new
    added = users_db.register_user(body)
    status 201
    body added.to_json
  else
    send_wrong_msg
  end
end

# Login a new user
post '/users/login' do
  body = JSON.parse(request.body.read, symbolize_names: true)
  if params_check.user_login(body)
    users_db = Users.new
    result = users_db.login_user(body)
    if result
      token = result.to_h
      status 201
      body token.to_json
    else
      send_wrong_msg "incorrect email or login"
    end
  else
    send_wrong_msg
  end
end

# Update an existing user
put '/users/:id' do
  id = params[:id].to_i
  body = JSON.parse(request.body.read, symbolize_names: true)
  if params_check.user_info(body)
    users_db = Users.new(id)
    updated_in_db = users_db.change_user(body)
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