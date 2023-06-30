class Tasks
  def initialize(user_id)
    @user_id = user_id
    @conn = db_connect
    @table = "todolist"
  end

  def get_all_tasks
    return @conn.exec("
      SELECT id,task,completed FROM #{@table}
      WHERE user_id=#{@user_id}")
  end

  def get_task(id)
    return @conn.exec("
      SELECT id,task,completed FROM #{@table}
      WHERE id=#{id} AND user_id=#{@user_id}")
  end

  def add_task(task)
    return @conn.exec("
      INSERT INTO #{@table} (task,user_id)
      VALUES ('#{task}', #{@user_id})
      RETURNING id,task,completed")
  end
    
  def change_task(id, task, completed)
    return @conn.exec("
      UPDATE #{@table}
      SET task='#{task}', completed=#{completed}
      WHERE id=#{id} AND user_id=#{@user_id}
      RETURNING id,task,completed")
  end

  def delete_task(id)
    return @conn.exec("
      DELETE FROM #{@table}
      WHERE id=#{id} AND user_id=#{@user_id}
      RETURNING *")
  end
end