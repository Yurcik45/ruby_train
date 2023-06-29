require 'dotenv/load'
require 'pg'

# Connection parameters
$HOST = ENV['HOST']
$PORT = ENV['PORT'].to_i
$DBNAME = ENV['DBNAME']
$USER = ENV['USER']
$PASSWORD = ENV['PASSWORD']

$table = "todolist"

class Tasks
  def initialize
    @conn = Tasks.connect_to_db
    # Register a custom type caster for the boolean column
    @conn.type_map_for_results = PG::BasicTypeMapForResults.new(@conn).tap do |tm|
      tm.add_coder(PG::TextDecoder::Boolean.new)
    end
    Tasks.check_table_exists @conn
  end

  def self.connect_to_db
    begin
      return PG::Connection.new(host: $HOST, port: $PORT, dbname: $DBNAME, user: $USER, password: $PASSWORD)
    rescue PG::ConnectionBad => e
      puts "Error connecting to the PostgreSQL server: #{e.message}"
      exit 1
    end
  end

  def self.check_table_exists(conn)
    begin
      conn.exec("SELECT * FROM #{$table}")
    rescue PG::UndefinedTable => e
      puts "Error: Table does not exist. #{e.message}"
      exit 1
    end
  end

  def get_all_tasks
    return @conn.exec("SELECT * FROM #{$table}")
  end

  def get_task(id)
    return @conn.exec("SELECT * FROM #{$table} WHERE id=#{id}")
  end

  def add_task(task)
    return @conn.exec("INSERT INTO #{$table} (task) VALUES ('#{task}') RETURNING *")
  end
    
  def change_task(id, task, completed)
    return @conn.exec("UPDATE #{$table} SET task='#{task}', completed=#{completed} WHERE id=#{id} RETURNING *")
  end

  def delete_task(id)
    return @conn.exec("DELETE FROM #{$table} WHERE id=#{id} RETURNING *")
  end
  
end