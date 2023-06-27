require 'dotenv/load'
require 'pg'

# Connection parameters
$HOST = ENV['HOST']
$PORT = ENV['PORT'].to_i
$DBNAME = ENV['DBNAME']
$USER = ENV['USER']
$PASSWORD = ENV['PASSWORD']

class Users
  def initialize
    @users = Array.new
    @conn = Users.connect_to_db
  end

  def self.connect_to_db
    return PG::Connection.new(host: $HOST, port: $PORT, dbname: $DBNAME, user: $USER, password: $PASSWORD)
  end

  def get_all_users
    @users = @conn.exec("SELECT * FROM users")
    # @conn.close
    return @users
  end

  def get_user(id)
    user = @conn.exec("SELECT * from users where id=#{id}")
    return user
  end

  def add_user(name, age)
    @conn.exec("INSERT INTO users (name, age) VALUES ('#{name}', #{age})")
  end

  def delete_user(id)
    @conn.exec("DELETE FROM users WHERE id=#{id}")
  end
  
  def change_age(id, age)
    @conn.exec("UPDATE users SET age=#{age} WHERE id=#{id}")
  end
  
  def change_name(id, name)
    @conn.exec("UPDATE users SET name='#{name}' WHERE id=#{id}")
  end

end