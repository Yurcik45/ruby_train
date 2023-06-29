require 'jwt'
require 'bcrypt'

class ParamsCheck
  def todo_post(body)
    return false if !body || !body[:task]
    return true
  end
  def todo_put(body)
    return false if !body || !body[:task] || !body[:completed]
    return true
  end
  def user_info(body)
    return false if !body || !body[:first_name] ||
                    !body[:last_name] || !body[:nickname] ||
                    !body[:email] || !body[:password]
    return true
  end
  def user_login(body)
    return false if !body || !body[:email] || !body[:password]
    return true
  end
end

def send_wrong_msg(message = "something went wrong")
  status 400
  msg = { message: message }
  msg.to_h
  body msg.to_json
end

def send_auth_error_msg
  status 401
  msg = { message: "Authorization error" }
  msg.to_h
  body msg.to_json
end

def check_auth_token(token)
  return false if !token
  users_db = Users.new
  init_user_data = decode_token(token)
  email = init_user_data[:email]
  user_in_db = users_db.get_user_by_email(email)
  return false if user_in_db.ntuples === 0
  db_user_data = user_in_db[0]
  test_token = generate_token(db_user_data)
  return true if token === test_token
  return false
end

def check_auth_and_halt(request)
  halt 401, send_auth_error_msg if !check_auth(request.env['HTTP_AUTHORIZATION'])
end

$jwt_key = ENV['JWT_KEY']

def generate_token(payload)
  return JWT.encode(payload, $jwt_key, 'HS256')
end

def decode_token(token)
  return JWT.decode(token, $jwt_key, true, algorithm: 'HS256')
end

def hash_password(password)
  return BCrypt::Password.create(password)
end

def compare_passwords(hashed, normal)
  return true if BCrypt::Password.new(hashed) == normal
  return false
end

