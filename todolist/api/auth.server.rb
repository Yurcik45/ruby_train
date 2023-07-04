params_check = ParamsCheck.new

# Read user info
get '/users/info' do
  puts "/users/info"
  users_db = Users.new(request.env['user_id'])
  user_in_db = users_db.get_user_info
  if user_in_db.ntuples > 0
    user = user_in_db[0].to_h
    status 200
    body user.to_json
  else
    send_wrong_msg
  end
end

# Register a new user
post '/users/register' do
  body = JSON.parse(request.body.read, symbolize_names: true)
  if params_check.user_info(body)
    users_db = Users.new
    added_in_db = users_db.register_user(body)
    halt send_wrong_msg "user with this email already exists" if !added_in_db
    if added_in_db.ntuples > 0
      added = added_in_db[0].to_h
      status 201
      body added.to_json
    else
      send_wrong_msg
    end
  else
    send_wrong_msg
  end
end

get '/users/activate' do
  users_db = Users.new(request.env['user_id'])
  halt 300 if users_db.check_user_activate
  confirms_in_db = users_db.set_confirmation_info
  halt send_wrong_msg if confirms_in_db.ntuples === 0
  status 201
  msg = { message: "Activated code on your email (haahahhah, NO, in console)" }.to_h
  body msg.to_json
end

post '/users/activate' do
  body = JSON.parse(request.body.read, symbolize_names: true)
  halt 400 if !params_check.user_activate(body)
  users_db = Users.new(request.env['user_id'])
  halt 300 if users_db.check_user_activate
  user_code = body[:activation_code]
  puts "POST user_code: #{user_code}"
  confirms_in_db = users_db.activate_user user_code
  halt send_wrong_msg if !confirms_in_db
  status 201
  msg = { message: "Activation Successfull" }.to_h
  body msg.to_json
end

# Login a new user
post '/users/login' do
  body = JSON.parse(request.body.read, symbolize_names: true)
  if params_check.user_login(body)
    users_db = Users.new
    token = users_db.login_user(body)
    if token
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

# only for developing mode

# Read all users
get '/users' do
  halt 404 if settings.environment != :development
  users_db = Users.new
  users = users_db.get_all_users.map { |row| row.to_h }
  users.to_json
end

# Read a specific user
get '/users/:id' do
  puts "/users/:id"
  halt 404 if settings.environment != :development
  id = params[:id].to_i
  users_db = Users.new(id)
  user_in_db = users_db.get_user
  if user_in_db.ntuples > 0
    user = user_in_db[0].to_h
    status 200
    body user.to_json
  else
    send_wrong_msg "no users was found with id #{id}"
  end
end