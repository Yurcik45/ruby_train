require 'dotenv/load'
require 'pg'

# Connection parameters
$db_config = {
  host: ENV['HOST'],
  port: ENV['PORT'].to_i,
  dbname: ENV['DBNAME'],
  user: ENV['USER'],
  password: ENV['PASSWORD']
}

# Read the contents of the migration file
$migration_file = File.read('./tables.sql')

def db_connect
  conn = PG::Connection.new($db_config)
  conn.exec($migration_file)
  conn.type_map_for_results = PG::BasicTypeMapForResults.new(conn).tap do |tm|
    tm.add_coder(PG::TextDecoder::Boolean.new)
  end
  return conn
end

def initial_connect
  begin
    conn = PG::Connection.new($db_config)
    conn.exec($migration_file)
    puts 'Tables created successfully.'
  rescue PG::Error => e
    puts "Error creating tables: #{e.message}"
  rescue PG::ConnectionBad => e
    puts "Error connecting to the PostgreSQL server: #{e.message}"
    exit 1
  end
  begin
    conn.exec("SELECT * FROM users")
  rescue PG::UndefinedTable => e
    puts "Error: Table 'users' does not exist. #{e.message}"
    exit 1
  end
  begin
    conn.exec("SELECT * FROM todolist")
  rescue PG::UndefinedTable => e
    puts "Error: Table 'todolist' does not exist. #{e.message}"
    exit 1
  ensure
    conn.close if conn
  end
end