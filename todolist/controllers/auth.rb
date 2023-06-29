class Users
  def initialize(user_id = nil)
    @user_id = user_id
    @conn = db_connect
    @table = "users"
  end

  def get_all_users
    return @conn.exec("SELECT * FROM #{@table}")
  end

  def get_user()
    return @conn.exec("
      SELECT * FROM #{@table}
      WHERE id=#{@user_id}")
  end

  def register_user(user)
    return @conn.exec("
      INSERT INTO #{@table}
      (first_name,last_name,nickname,email,password)
      VALUES (
        '#{user[:first_name]}',
        '#{user[:last_name]}',
        '#{user[:nickname]}',
        '#{user[:email]}',
        '#{user[:password]}'
      )
      RETURNING *")
  end

  def login_user(user_data)
    users = get_all_users
    need_user = nil
    users.each do |user|
      if user['email'] === user_data[:email] && user['password'] === user_data[:password]
        need_user = user
      end
    end
    return need_user
  end
    
  def change_user(user)
    return @conn.exec("
      UPDATE #{@table}
      SET
        first_name='#{user[:first_name]}',
        last_name='#{user[:last_name]}',
        nickname='#{user[:nickname]}',
        email='#{user[:email]}',
        password='#{user[:password]}'
      WHERE id=#{@user_id}
      RETURNING *")
  end

  # future
  # def activate_user
end