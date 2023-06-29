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

