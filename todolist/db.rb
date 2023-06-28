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
  end

  def self.connect_to_db
    return PG::Connection.new(host: $HOST, port: $PORT, dbname: $DBNAME, user: $USER, password: $PASSWORD)
  end

  def get_all_tasks
    return @conn.exec("SELECT * FROM #{$table}")
  end

  def get_task(id)
    return @conn.exec("SELECT * from #{$table} where id=#{id}")
  end

  def add_task(task)
    return @conn.exec("INSERT INTO #{$table} (task, completed) VALUES ('#{task}', #{false}) RETURNING *")
  end
    
  def change_task(id, task, completed)
    return @conn.exec("UPDATE #{$table} SET task='#{task}', completed=#{completed} WHERE id=#{id} RETURNING *")
  end

  def delete_task(id)
    return @conn.exec("DELETE FROM #{$table} WHERE id=#{id} RETURNING *")
  end
  
end