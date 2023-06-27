require 'dotenv/load'
require 'pg'

# Connection parameters
$HOST = ENV['HOST']
$PORT = ENV['PORT'].to_i
$DBNAME = ENV['DBNAME']
$USER = ENV['USER']
$PASSWORD = ENV['PASSWORD']

def get_users
  # Establish the connection
  conn = PG::Connection.new(host: $HOST, port: $PORT, dbname: $DBNAME, user: $USER, password: $PASSWORD)

  # Execute a SQL query
  result = conn.exec('SELECT * FROM users')

  conn.close
  return result
end